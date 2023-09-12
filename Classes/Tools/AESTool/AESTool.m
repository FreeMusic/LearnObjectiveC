//
//  AESTool.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/9/11.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "AESTool.h"

@implementation AESTool

+ (NSString *)TW_AES_Encrypt:(NSString *)originalStr
                      mode:(TWMode)mode
                       key:(NSString *)key
                   keySize:(TWKeySizeAES)keySize
                        iv:(NSString * _Nullable )iv
                   padding:(TWCryptorPadding)padding;
{
    NSData *data = [originalStr dataUsingEncoding:NSUTF8StringEncoding];
    data = [self TW_AES_WithData:data operation:kCCEncrypt mode:mode key:key keySize:keySize iv:iv padding:padding];
    return [data base64EncodedStringWithOptions:0];
}

+ (NSString *)TW_AES_Decrypt:(NSString *)originalStr
                      mode:(TWMode)mode
                       key:(NSString *)key
                   keySize:(TWKeySizeAES)keySize
                        iv:(NSString * _Nullable )iv
                   padding:(TWCryptorPadding)padding
{
    NSData *data = [[originalStr dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
    
    data = [self TW_AES_WithData:data operation:kCCDecrypt mode:mode key:key keySize:keySize iv:iv padding:padding];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSData *)TW_AES_WithData:(NSData *)originalData
                 operation:(CCOperation)operation
                      mode:(CCMode)mode
                       key:(NSString *)key
                   keySize:(TWKeySizeAES)keySize
                        iv:(NSString *)iv
                   padding:(TWCryptorPadding)padding
{
    NSAssert((mode != kCCModeECB && iv != nil && iv != NULL) || mode == kCCModeECB, @"使用 CBC 模式，initializationVector（即iv，填充值）必须有值");
    
    CCCryptorRef cryptor = NULL;
    CCCryptorStatus status = kCCSuccess;
    
    NSMutableData * keyData = [[key dataUsingEncoding: NSUTF8StringEncoding] mutableCopy];
    NSMutableData * ivData = [[iv dataUsingEncoding: NSUTF8StringEncoding] mutableCopy];
    
#if !__has_feature(objc_arc)
    [keyData autorelease];
    [ivData autorelease];
#endif
    
    [keyData setLength:keySize];
    [ivData setLength:keySize];
    
    //填充模式（系统API只提供了两种）
    CCPadding paddingMode = (padding == ccPKCS7Padding) ? ccPKCS7Padding : ccNoPadding ;
    NSData *sourceData = originalData;
    if (operation == kCCEncrypt) {
        sourceData =  [self bitPaddingWithData:originalData mode:mode padding:padding];    //FIXME: 实际上的填充模式
    }
    
    status = CCCryptorCreateWithMode(operation, mode, kCCAlgorithmAES, paddingMode, ivData.bytes, keyData.bytes, keyData.length, NULL, 0, 0, 0, &cryptor);
    if ( status != kCCSuccess ){
        NSLog(@"Encrypt Error:%d",status);
        return nil;
    }
    
    //确定处理给定输入所需的输出缓冲区大小尺寸。
    size_t bufsize = CCCryptorGetOutputLength( cryptor, (size_t)[sourceData length], true );
    void * buf = malloc( bufsize );
    size_t bufused = 0;
    size_t bytesTotal = 0;
    
    //处理（加密，解密）一些数据。如果有结果的话,写入提供的缓冲区.
    status = CCCryptorUpdate( cryptor, [sourceData bytes], (size_t)[sourceData length],
                             buf, bufsize, &bufused );
    if ( status != kCCSuccess ){
        NSLog(@"Encrypt Error:%d",status);
        free( buf );
        return nil;
    }
    bytesTotal += bufused;
    if (padding == TWCryptorPKCS7Padding) {
        status = CCCryptorFinal( cryptor, buf + bufused, bufsize - bufused, &bufused );
        if ( status != kCCSuccess ){
            NSLog(@"Encrypt Error:%d",status);
            free( buf );
            return nil;
        }
        bytesTotal += bufused;
    }
    
    NSData *result = [NSData dataWithBytesNoCopy:buf length: bytesTotal];
    if (operation == kCCDecrypt) {
        //解密时移除填充
        result = [self removeBitPaddingWithData:result mode:mode operation:operation andPadding:padding];
    }
    
    CCCryptorRelease(cryptor);

    return result;
}

// 填充需要加密的字节
+ (NSData *)bitPaddingWithData:(NSData *)data
                          mode:(CCMode)mode
                       padding:(TWCryptorPadding)padding;
{
    NSMutableData *sourceData = data.mutableCopy;
    int blockSize = kCCBlockSizeAES128;         //FIXME: AES的块大小都是128bit，即16bytes
    
    switch (padding) {
        case TWCryptorPKCS7Padding:
        {
            if (mode == kCCModeCFB || mode == kCCModeOFB) {
                //MARK: CCCryptorCreateWithMode方法在这两个模式下，并不会给块自动填充，所以需要手动去填充
                NSUInteger shouldLength = blockSize * ((sourceData.length / blockSize) + 1);
                NSUInteger diffLength = shouldLength - sourceData.length;
                uint8_t *bytes = malloc(sizeof(*bytes) * diffLength);
                for (NSUInteger i = 0; i < diffLength; i++) {
                    // 补全缺失的部分
                    bytes[i] = diffLength;
                }
                [sourceData appendBytes:bytes length:diffLength];
            }
        }
            break;
        case TWCryptorZeroPadding:
        {
            int pad = 0x00;
            int diff =   blockSize - (sourceData.length % blockSize);
            for (int i = 0; i < diff; i++) {
                [sourceData appendBytes:&pad length:1];
            }
        }
            break;
        case TWCryptorANSIX923:
        {
            int pad = 0x00;
            int diff =   blockSize - (sourceData.length % blockSize);
            for (int i = 0; i < diff - 1; i++) {
                [sourceData appendBytes:&pad length:1];
            }
            [sourceData appendBytes:&diff length:1];
        }
            break;
        case TWCryptorISO10126:
        {
            int diff = blockSize - (sourceData.length % blockSize);
            for (int i = 0; i < diff - 1; i++) {
                int pad  = arc4random() % 254 + 1;      //FIXME: 因为是随机填充，所以相同参数下，每次加密都是不一样的结果（除了分段后最后一个分段的长度为15bytes的时候加密结果相同）
                [sourceData appendBytes:&pad length:1];
            }
            [sourceData appendBytes:&diff length:1];
        }
            break;
        default:
            break;
    }
    return sourceData;
}

+ (NSData *)removeBitPaddingWithData:(NSData *)sourceData mode:(CCMode)mode operation:(CCOperation)operation andPadding:(TWCryptorPadding)padding
{
    int correctLength = 0;
    int blockSize = kCCBlockSizeAES128;
    Byte *testByte = (Byte *)[sourceData bytes];
    char end = testByte[sourceData.length - 1];
    
    if (padding == TWCryptorPKCS7Padding) {
        if ((mode == kCCModeCFB || mode == kCCModeOFB) && (end > 0 && end < blockSize + 1)) {
            correctLength = (short)sourceData.length - end;
        }else{
            return sourceData;
        }
    }else if (padding == TWCryptorZeroPadding && end == 0) {
        for (int i = (short)sourceData.length - 1; i > 0 ; i--) {
            if (testByte[i] != end) {
                correctLength = i + 1;
                break;
            }
        }
    }else if ((padding == TWCryptorANSIX923 || padding == TWCryptorISO10126) && (end > 0 && end < blockSize + 1)){
        correctLength = (short)sourceData.length - end;
//        if (padding == MIUCryptorISO10126 || ( testByte[sourceData.length - end] == 0 && testByte[sourceData.length - 2] == 0)) {
//            correctLength = (short)sourceData.length - end;
//        }
    }
    
    NSData *data = [NSData dataWithBytes:testByte length:correctLength];
    return data;
}

@end
