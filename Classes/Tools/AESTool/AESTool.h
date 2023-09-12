//
//  AESTool.h
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/9/11.
//  Copyright © 2023 橘子. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    TWCryptorNoPadding = 0,    // 无填充
    TWCryptorPKCS7Padding = 1, // PKCS_7 | 每个字节填充字节序列的长度。 ***此填充模式使用系统方法。***
    TWCryptorZeroPadding = 2,  // 0x00 填充 | 每个字节填充 0x00
    TWCryptorANSIX923,         // 最后一个字节填充字节序列的长度，其余字节填充0x00。
    TWCryptorISO10126          // 最后一个字节填充字节序列的长度，其余字节填充随机数据。
}TWCryptorPadding;

typedef enum {
    TWKeySizeAES128          = 16,
    TWKeySizeAES192          = 24,
    TWKeySizeAES256          = 32,
}TWKeySizeAES;

typedef enum {
    TWModeECB        = 1,
    TWModeCBC        = 2,
    TWModeCFB        = 3,
    TWModeOFB        = 7,
}TWMode;

@interface AESTool : NSObject


/// 加密
/// - Parameters:
///   - originalStr: 初始字符串
///   - mode: 填充模式
///   - key: 秘钥
///   - keySize: 密钥长度
///   - iv: initializationVector（即iv，填充值）
///   - padding: 初始向量（偏移量）
+ (NSString *)TW_AES_Encrypt:(NSString *)originalStr
                      mode:(TWMode)mode
                       key:(NSString *)key
                   keySize:(TWKeySizeAES)keySize
                        iv:(NSString * _Nullable )iv
                   padding:(TWCryptorPadding)padding;

/// 解密
/// - Parameters:
///   - originalStr: 初始字符串
///   - mode: 填充模式
///   - key: 秘钥
///   - keySize: 密钥长度
///   - iv: initializationVector（即iv，填充值）
///   - padding: 初始向量（偏移量）
+ (NSString *)TW_AES_Decrypt:(NSString *)originalStr
                      mode:(TWMode)mode
                       key:(NSString *)key
                   keySize:(TWKeySizeAES)keySize
                        iv:(NSString * _Nullable )iv
                   padding:(TWCryptorPadding)padding;

@end

NS_ASSUME_NONNULL_END
