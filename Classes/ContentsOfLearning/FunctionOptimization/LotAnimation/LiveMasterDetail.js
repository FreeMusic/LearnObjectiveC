import React from 'react';
import {
    View,
    Animated,
    ScrollView,
    ImageBackground,
    TouchableOpacity,
    Image,
    Text,
    StyleSheet,
    NativeModules, NativeEventEmitter, Platform, DeviceEventEmitter, RefreshControl
} from "react-native";
import {deviceWidth, isIosBangsPhone, vPx} from "../../../utils/Lpx";
import Header, {HeaderWhiteRightIconText, HeaderWithblack, HeaderWithWhite} from "../../../components/HeardView";
import {TitleBar} from "./component/TitleBar";
import S from "../../../Styles";
import VideoView from "../../../components/VideoView";
import {addressArr, DICT_DATA} from "../../../utils/MenuData";
import {requestGet, requestPost} from "../../../request/HttpUtil";
import {LiVE_MASTER_ONE, LIVE_MASTER_ROOM} from "../../../request/api";
import LottieView from "lottie-react-native";
import Toast from 'react-native-root-toast';
import {EmptyBuy, EmptyLiveHome} from "../../small_shop/EmptyPage";
import JAnalytics from "../../../utils/JAnalytics";
import {inject, observer} from "mobx-react";
import {BASE_URL_TOOL} from "../../../config/config";

const NativeRouterManager = NativeModules.NativeRouterManager;
const NativeModulesByIOS = NativeModules.RnEventModules;
var NativeNotificationMoudule;
if (NativeModulesByIOS) {
    NativeNotificationMoudule = new NativeEventEmitter(NativeModulesByIOS);
}
@inject('store')
@observer
export default class LiveMasterDetail extends React.Component {


    componentWillMount(): void {
        this.item = this.props.navigation.state.params.item;

    }

    state = {
        roomList: [],
        scrollY: new Animated.Value(0),
        masterData: {},
        refreshing: false,
        dataList: [],
        showBackIcon: false,
        showUpImg: false,
        thumbnail: null,
        width: null,
        height: null
    }
    page = 1
    pageSize = 10

    componentDidMount(): void {
        this.getData()
        this.getLivingRooms();
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
            productId:  res.id,
        });
    };

    componentWillUnmount(): void {
        this.subscription && this.subscription.remove();
    }

    getData = () => {
        requestGet(LiVE_MASTER_ONE, {id: this.item.id}).then(res => {
            if (res.code == 0) {
                this.setState({masterData: res.data})
            } else {
                console.log(res.msg)
            }
        })
    }
    getLivingRooms = () => {
        requestPost(LIVE_MASTER_ROOM, {masterId: this.item.id, page: this.page, pageSize: this.pageSize}).then(res => {
            if (res.code == 0) {
                this.setState({
                    dataList: this.page == 1 ? res.data.list : [...this.state.dataList, ...res.data.list],
                });
                this.total = Math.ceil(res.data.total / this.pageSize);
            } else {
                Toast.show(res.data.msg)
            }
        }).finally(() => {
            this.setState({
                refreshing: false,
            });
        });
    }
    renderStatus = (type) => {
        if (type == 0) {
            return <View
                style={{width: vPx(52), backgroundColor: '#FF6445', height: vPx(19), borderRadius: vPx(2)}}>
                <LottieView autoPlay loop={true} source={require('../../../images/liveing.json')}/>
            </View>
        } else if (type == 1) {
            return <Text style={{
                backgroundColor: '#EBB109',
                color: "#FFFFFF",
                padding: vPx(4),
                fontSize: vPx(11),
                width: vPx(32),
                borderRadius: 2
            }}>回放</Text>
        } else {
            return <View/>
        }
    }


    renderRoom = () => {
        const {dataList} = this.state
        if (dataList.length == 0) {
            return <EmptyLiveHome/>
        } else {
            return (
                <View style={styles.rooms}>
                    {dataList.length != 0 && dataList.map((item, index) => {
                        return (
                            <TouchableOpacity key={item.background} onPress={() => {
                                if(item.liveType==2) {
                                    NativeRouterManager && NativeRouterManager.onOpenNativeScreen({
                                        ActivityName: 'PlayLiveActivity',
                                        userInfo: JSON.stringify(global.user),
                                        liveData: JSON.stringify(item),
                                    });
                                    console.log(item)
                                    global.liveData = item
                                } else {
                                    this.props.navigation.navigate('H5Screen', {url: item.videoUrl});
                                }
                            }}>
                                <ImageBackground source={{uri: item.background}}
                                                 style={{
                                                     width: (deviceWidth - 40) / 2,
                                                     height: vPx(168),
                                                     borderRadius: 2,
                                                     marginTop: vPx(8),
                                                     padding: vPx(4)
                                                 }}>
                                    <View style={{
                                        flexDirection: 'row',
                                        alignItems: 'center',
                                        justifyContent: 'space-between'
                                    }}>
                                        {this.renderStatus(item.type)}
                                        <Text style={{
                                            backgroundColor: '#0000',
                                            color: "#FFFFFF",
                                            padding: vPx(4),
                                            fontSize: vPx(11),
                                            borderRadius: 2
                                        }}>{DICT_DATA.SECTION_TYPE_TW[item.sectionType]}</Text>
                                    </View>
                                    <View style={{flex: 1}}/>
                                    <View>
                                        <View style={{flexDirection: 'row', alignItems: 'center'}}>
                                            <Image source={{uri: item.hostessAvatar}}
                                                   style={{
                                                       width: vPx(22),
                                                       height: vPx(22),
                                                       borderRadius: vPx(11),
                                                       borderWidth: 2,
                                                       borderColor: '#fff'
                                                   }}/>
                                            <Text style={[S.font14_fff, {marginLeft: vPx(4)}]}>{item.hostessName}</Text>
                                        </View>
                                        <Text
                                            style={[S.font13_fff, {
                                                marginTop: vPx(4),
                                                marginLeft: vPx(2)
                                            }]}>{item.topic}</Text>
                                    </View>
                                </ImageBackground>
                            </TouchableOpacity>
                        )
                    })}
                </View>
            )
        }
    }
    ref = (ref) => {
        this.player = ref;
    }
    setShowBackIcon = (state) => {
        if (state != this.state.showBackIcon) {
            this.setState({showBackIcon: state})
        }
    };
    onRefresh = () => {
        if (!this.state.refreshing) {
            this.getData();
            this.getLivingRooms();
        }
    }


    render() {
        const {masterData, showBackIcon, showUpImg} = this.state
        let {ShopStore: {setShowTab}} = this.props.store;

        return (
            <View style={{flex: 1, backgroundColor: '#fff'}}>
                <ScrollView refreshControl={
                    <RefreshControl
                        refreshing={this.state.refreshing}
                        onRefresh={() => {
                            this.onRefresh()
                        }}/>
                } onScroll={
                    Animated.event(
                        [{nativeEvent: {contentOffset: {y: this.state.scrollY}}}],
                        {
                            listener: (event) => {
                                this.onScroll = event.nativeEvent.contentOffset.y;
                                if (this.onScroll > 50) {
                                    this.setShowBackIcon(true);
                                } else {
                                    this.setShowBackIcon(false);
                                }
                                this.onScroll < this.headHeight - this.topBarHeight ? setShowTab(false) : setShowTab(true);
                            },
                        },
                    )} scrollEventThrottle={1}>
                    {masterData.background ? <Image source={{uri: masterData.background}}
                                                    style={{
                                                        opacity: 0.8,
                                                        width: deviceWidth,
                                                        height: vPx(209),
                                                        backgroundColor: '#ECECEC'
                                                    }}/> : null}
                    <View style={{paddingHorizontal: vPx(16), flexDirection: 'row'}}>
                        <View style={{...S.posRel}}>
                            {masterData.avatar ? <Image source={{uri: masterData.avatar}} style={{
                                width: vPx(88),
                                height: vPx(88),
                                borderWidth: vPx(2),
                                borderRadius: vPx(44),
                                borderColor: '#fff',
                                marginTop: vPx(-14),
                            }}/> : null}
                            {masterData.type == 0 &&
                            <View style={{
                                ...S.posAbs, left: vPx(88 - 52) / 2, bottom: 0
                            }}>
                                <View style={{
                                    width: vPx(52),
                                    backgroundColor: '#FF6445',
                                    height: vPx(19),
                                    borderRadius: vPx(2)
                                }}>
                                    <LottieView
                                        autoPlay loop={true} source={require('../../../images/liveing.json')}/>
                                </View>
                            </View>}
                        </View>

                        <View
                            style={{paddingLeft: vPx(12), width: deviceWidth - vPx(32 + 88), justifyContent: 'center'}}>
                            <Text numberOfLines={1} ellipsizeMode={'tail'}
                                  style={{
                                      fontSize: vPx(22),
                                      fontWeight: 'bold',
                                      color: '#333'
                                  }}>{masterData.name}</Text>
                            <Text numberOfLines={1} ellipsizeMode={'tail'} style={[S.font13_666, {
                                lineHeight: vPx(17),
                                marginTop: vPx(6)
                            }]}>{masterData.dynamicMsg}</Text>
                        </View>
                    </View>
                    <View style={{paddingVertical: vPx(28)}}>
                        <TitleBar title={'大咖简介'}/>
                        <View style={{...S.posRel, marginHorizontal: vPx(16)}}>
                            {showUpImg ?
                                <Text style={{...S.font15, marginTop: vPx(8)}}>{masterData.introduction}</Text> :
                                <Text numberOfLines={2} ellipsizeMode={'tail'}
                                      style={{...S.font15, marginTop: vPx(8)}}>{masterData.introduction}</Text>
                            }
                            {masterData.introduction && masterData.length > 20 ?
                                <TouchableOpacity style={{...S.posAbs, bottom: 0, right: 0, padding: vPx(2)}}
                                                  onPress={() => {
                                                      if (showUpImg) {
                                                          this.setState({showUpImg: false})
                                                      } else {
                                                          this.setState({showUpImg: true})
                                                      }
                                                  }}>
                                    <Image
                                        source={showUpImg ? require('../../../images/icon_go_up.png') : require('../../../images/icon_pull_down.png')}
                                        style={{width: vPx(14), height: vPx(14)}}/>
                                </TouchableOpacity> : null}

                        </View>
                    </View>
                    {masterData.videoUrl ? <View style={{paddingBottom: vPx(16)}}>
                        <TitleBar title={'大咖VCR'} style={{paddingBottom: vPx(16)}}/>
                        <VideoView onItemPlay={this.onItemPlay} ref={this.ref}
                                   videoSource={masterData.videoUrl}
                                   videoImage={masterData.videoUrl + '?spm=a2c4g.11186623.2.1.yjOb8V&x-oss-process=video/snapshot,t_200,f_png,w_800,h_600,m_fast'}/>
                    </View> : null}
                    <View style={{height: vPx(8), backgroundColor: '#F6F7F9'}}/>
                    <View style={{paddingTop: vPx(16)}}>
                        <TitleBar title={'大咖直播间'} remark={'直播间的那些事'}/>
                        {this.renderRoom()}
                    </View>
                </ScrollView>
                <HeaderWithWhite onLayout={e => this.topBarHeight = e.nativeEvent.layout.height}
                                 onBack={() => this.props.navigation.pop()}
                                 backIcon={showBackIcon ? require('../../../images/icon_goback_black.png') : require('../../../images/go_back_white.png')}
                                 style={{
                                     backgroundColor: this.state.scrollY.interpolate({
                                         inputRange: [0, 100, 100],
                                         outputRange: ['#0000', '#fff', '#ffff'],
                                     }), position: 'absolute', top: 0,
                                 }}
                                 titleStyle={{
                                     color: this.state.scrollY.interpolate({
                                         inputRange: [0, 100, 100],
                                         outputRange: ['#fff', '#000', '#000'],
                                     }),
                                 }}
                                 title={'大咖资料'}
                />
            </View>
        )
    }

}
const styles = StyleSheet.create({
    contain: {
        flex: 1,
        backgroundColor: '#fff',
    },
    rooms: {
        flexWrap: 'wrap',
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingHorizontal: vPx(16),
        paddingBottom: isIosBangsPhone() ? vPx(40) : vPx(20)
    }
})
