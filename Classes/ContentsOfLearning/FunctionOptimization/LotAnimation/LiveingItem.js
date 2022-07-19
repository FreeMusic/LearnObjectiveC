import React, {Component} from 'react';
import {View, Text, StyleSheet, TouchableOpacity, ScrollView, Image} from 'react-native';
import {deviceHeight, deviceWidth, vPx} from '../../../../utils/Lpx';
import RootToast from 'react-native-root-toast';
import S from '../../../../Styles';
import moment from 'moment';
import LottieView from 'lottie-react-native';

export default class LiveingItem extends Component {

    componentDidMount() {
        // this.animation.play();

    }

    componentWillUnmount() {
    }

    renderLiveText = (sectionType) => {//0 大咖访谈 1 买卖一件通 2 在线课堂 3 预约关注
        let text = ''
        let color = ''
        let backgroundColor = ''
        switch (sectionType) {
            case 0 :
                text = '大咖访谈';
                color = '#D62832';
                backgroundColor = 'rgba(214, 40, 50, 0.2)';
                break;
            case 1:
                text = '买卖一键通';
                color = '#575CF1';
                backgroundColor = 'rgba(87, 92, 241, 0.2)';
                break;
            case 2 :
                text = '在线课堂';
                color = '#D3A010';
                backgroundColor = 'rgba(235, 183, 34, 0.2)';
                break;
            // case 3 :
            //     text = '预约关注';
            //     color = '#4FAE59';
            //     backgroundColor = 'rgba(136, 79, 174, 0.2)';
            //     break;
            case 4 :
                text = '直播带货';
                color = '#884FAE';
                backgroundColor = 'rgba(136, 79, 174, 0.2)';
                break;
            case 5 :
                text = '行业资讯';
                color = '#4FAE59';
                backgroundColor = 'rgba(79, 174, 89, 0.2)';
                break;

        }
        return <View
            style={{
                backgroundColor: backgroundColor,
                ...S.flexCC,
                height: vPx(19),
                borderRadius: vPx(2),
                padding: vPx(4)
            }}>
            <Text style={{fontSize: vPx(11), color: color}}>{text}</Text>
        </View>
    };

    render() {
        let navigation = this.props.navigation;
        let {data} = this.props

        return (
            <TouchableOpacity onPress={this.props.onItemClick} style={[{
                height: vPx(130),
                //  marginHorizontal: vPx(16),
                flexDirection: 'row',
            }, this.props.style]}>
                {data.background ? <Image source={{uri: data.background}}
                                          style={{height: vPx(130), width: vPx(130), borderRadius: vPx(2)}}/> : null}

                <View style={{...S.posAbs, top: vPx(4), left: vPx(4)}}>
                    {data.type == 0 &&
                    <View style={{width: vPx(52), backgroundColor: '#FF6445', height: vPx(19), borderRadius: vPx(2)}}>
                        <LottieView
                            autoPlay loop={true} source={require('../../../../images/liveing.json')}/>
                    </View>
                   }

                    {/*<View style={{*/}
                    {/*    minWidth: vPx(63),*/}
                    {/*    height: vPx(19),*/}
                    {/*    marginTop: vPx(4),*/}
                    {/*    backgroundColor: 'rgba(0,0,0,0.2)',*/}
                    {/*    borderRadius: vPx(2),*/}
                    {/*    ...S.flexCC*/}
                    {/*}}>*/}
                    {/*    <Text*/}
                    {/*        style={{...S.font11_fff}}>{this.renderLiveText(data.sectionType)}</Text>*/}
                    {/*</View>*/}

                </View>
                <View style={{flex: 1, paddingLeft: vPx(8), paddingTop: vPx(3)}}>
                    <Text numberOfLines={2} style={{...S.font14, fontWeight: 'bold'}}>{data.topic} </Text>
                    <View style={{flexDirection: 'row', alignItems: 'center', marginTop: vPx(8), marginRight: vPx(4)}}>
                        {this.renderLiveText(data.sectionType)}
                        {data.hotStatus == 1 ? <Image source={require('../../../../images/live_hot.png')}
                                                      style={{
                                                          width: vPx(16),
                                                          height: vPx(16),
                                                          marginLeft: vPx(4)
                                                      }}/> : null}
                        <View style={{flex: 1}}/>
                    </View>
                    <View style={{
                        flexDirection: 'row',
                        alignItems: 'center',
                        marginTop: vPx(48),
                    }}>
                        {/*<Image source={{uri: data.hostessAvatar}}*/}
                        {/*       style={{height: vPx(24), marginRight: vPx(3), width: vPx(24), borderRadius: vPx(12)}}/>*/}
                        <Text style={{
                            ...S.font14_666,
                        }}>{data.hostessName ? (data.hostessName.length > 5 ? data.hostessName.substr(0, 4) + "..." : data.hostessName) : ""}</Text>
                        <Text style={{
                            ...S.font14_666,
                        }}>｜</Text>
                        <Text style={{
                            ...S.font14_666,
                        }}>{moment(data.startTime).format('HH:mm')}开播</Text>


                    </View>
                </View>
            </TouchableOpacity>
        );
    }
}

const styles = StyleSheet.create({
    image: {
        borderRadius: vPx(2),
    },
});
