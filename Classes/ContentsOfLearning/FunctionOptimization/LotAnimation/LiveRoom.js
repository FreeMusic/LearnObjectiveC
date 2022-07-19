import React, {Component} from 'react';
import {
    View,
    Text,
    Image,
    TouchableOpacity,
    ImageBackground,
    NativeModules,
    NativeEventEmitter, Platform, DeviceEventEmitter
} from 'react-native';
import {deviceWidth, vPx} from "../../../utils/Lpx";
import S from "../../../Styles";
import LottieView from "lottie-react-native";
import {DICT_DATA} from "../../../utils/MenuData";
import LinearGradient from "react-native-linear-gradient";
import {BASE_URL_TOOL} from "../../../config/config";

const NativeRouterManager = NativeModules.NativeRouterManager;
const NativeModulesByIOS = NativeModules.RnEventModules;
var NativeNotificationMoudule;
if (NativeModulesByIOS) {
    NativeNotificationMoudule = new NativeEventEmitter(NativeModulesByIOS);
}
export default class LiveRoom extends Component {

    componentDidMount(): void {
        if (Platform.OS == 'ios') {
            this.subscription = NativeNotificationMoudule.addListener(
                'gotoProductDetail',
                (res) => {
                    this.gotoProductDetail(res)
                },
            );
        } else {
            this.subscription = DeviceEventEmitter.addListener('gotoProductDetail', (res) => {
                this.gotoProductDetail(res)
            });
        }
    }

    gotoProductDetail = (res) => {
        if (res.playback_progress) {
            global.liveData.playback_progress = res.playback_progress
        }
        this.props.navigation.navigate('MallProductDetailsScreen', {
            productId: res.id,
        });
    };

    componentWillUnmount(): void {
        this.subscription && this.subscription.remove();
    }

    render() {
        let item = this.props.item
        return (
            <TouchableOpacity key={item.id}
                              style={{marginVertical: vPx(4), marginHorizontal: vPx(4)}}
                              onPress={() => {
                                  if (item.liveType == 2) {
                                      global.liveData = item
                                      NativeRouterManager && NativeRouterManager.onOpenNativeScreen({
                                          ActivityName: 'PlayLiveActivity',
                                          userInfo: JSON.stringify(global.user),
                                          liveData: JSON.stringify(item),
                                      });
                                  } else {
                                      this.props.navigation.navigate('H5Screen', {url: item.videoUrl});
                                  }
                              }}>
                {item.background ?
                    <ImageBackground imageStyle={{borderRadius: vPx(2)}} source={{uri: item.background}}
                                     style={{
                                         width: (deviceWidth - 42) / 2,
                                         height: vPx(168),
                                     }}>
                        <View style={{
                            flexDirection: 'row',
                            alignItems: 'center',
                            justifyContent: 'space-between',
                            padding: vPx(4)
                        }}>
                            {item.type == 0 ?
                                <View style={{
                                    flexDirection: 'row',
                                    backgroundColor: '#FF6445',
                                    alignItems: 'center',
                                    borderRadius: vPx(2)
                                }}>
                                    <View style={{
                                        width: vPx(52),
                                        height: vPx(19),
                                        borderTopLeftRadius: vPx(2),
                                        borderBottomLeftRadius: vPx(2)
                                    }}>
                                        <LottieView
                                            autoPlay loop={true} source={require('../../../images/liveing.json')}/>
                                    </View>
                                    {item.hotStatus === 1 ?
                                        <View style={{
                                            width: item.hotStatus === 1 ? vPx(15) : vPx(0),
                                            height: vPx(19),
                                            justifyContent: 'center',
                                            borderTopRightRadius: vPx(2),
                                            borderBottomRightRadius: vPx(2)
                                        }}>
                                            <Image source={require('../../../images/live_room_hot.png')}
                                                   style={{
                                                       width: vPx(11),
                                                       height: vPx(11),
                                                   }}/>
                                        </View> : null}
                                </View>
                                : null}
                            <View style={{
                                ...S.flexCC,
                                minWidth: vPx(63),
                                height: vPx(19),
                                backgroundColor: 'rgba(0,0,0,0.2)',
                                borderRadius: vPx(2)
                            }}>
                                <Text
                                    style={{paddingHorizontal: 4, ...S.font11_fff}}>{DICT_DATA.SECTION_TYPE_TW[item.sectionType]}</Text>
                            </View>
                        </View>
                        <View style={{flex: 1}}/>
                        <LinearGradient colors={['rgba(0, 0, 0, 0)', 'rgba(0, 0, 0, 1)']}
                                        style={{
                                            borderBottomLeftRadius: vPx(2),
                                            borderBottomRightRadius: vPx(2),
                                            padding: vPx(4)
                                        }}>
                            <View style={{
                                flexDirection: 'row',
                                alignItems: 'center',
                            }}>
                                {item.hostessAvatar ? <Image source={{uri: item.hostessAvatar}}
                                                             style={{
                                                                 width: vPx(22),
                                                                 height: vPx(22),
                                                                 borderRadius: vPx(11),
                                                                 borderWidth: vPx(1),
                                                                 borderColor: '#fff'
                                                             }}/> : null}
                                <Text numberOfLines={1} ellipsizeMode={'tail'}
                                      style={[S.font14_fff, {
                                          marginLeft: vPx(4),
                                          fontWeight: 'bold',
                                          width: vPx(120)
                                      }]}>{item.hostessName || ''}</Text>
                            </View>
                            <Text ellipsizeMode={'tail'} numberOfLines={1}
                                  style={[S.font13_fff, {
                                      marginTop: vPx(4),
                                      marginLeft: vPx(2)
                                  }]}>{item.topic || ''}</Text>
                        </LinearGradient>
                    </ImageBackground> : null}
            </TouchableOpacity>
        )
    }

}
