import React, {Component} from 'react';
import {View, Text, Image, StyleSheet, TouchableOpacity} from "react-native";
import {deviceWidth, vPx} from "../../../utils/Lpx";
import S from "../../../Styles";
import {requestPost} from "../../../request/HttpUtil";
import {LIVE_MASTER} from "../../../request/api";
import {DICT_DATA} from "../../../utils/MenuData";
import {TitleBar} from "./component/TitleBar";
import Toast from 'react-native-root-toast'
import {writeFile} from "react-native-fs";
import LottieView from "lottie-react-native";

export default class LiveMaster extends Component {
    state = {
        masterList: []
    }

    componentDidMount(): void {
        this.props.onRef(this)
        this.getData()
    }

    getData = () => {
        requestPost(LIVE_MASTER).then((res) => {
            console.log(res)
            if (res.code == 0) {
                this.setState({masterList: res.data})
            } else {
                console.log(res.data.msg)
            }
        })
    }


    renderItem = (item, index) => {
        return (
            <TouchableOpacity
                onPress={() => {
                    this.props.navigation.navigate('LiveMasterDetail', {item})
                }}
                key={item.avatar} style={styles.starItem}>
                <Image source={{uri: item.avatar}}
                       style={{borderRadius: vPx(31), width: vPx(62), height: vPx(62)}}/>
                <View style={{marginLeft: vPx(8), flex: 1}}>
                    <View style={{flexDirection: 'row', alignItems: 'center', flex: 1}}>
                        <Text numberOfLines={1} ellipsizeMode={'tail'}
                              style={[S.font16B, {
                                  maxWidth: deviceWidth - vPx(32 + 8 + 62 + 52),
                                  marginRight: vPx(4)
                              }]}>{item.name}</Text>
                        {item.type == 0 &&
                        <View
                            style={{width: vPx(52), backgroundColor: '#FF6445', height: vPx(19), borderRadius: vPx(2)}}>
                            <LottieView autoPlay loop={true} source={require('../../../images/liveing.json')}/>
                        </View>}
                    </View>
                    <Text numberOfLines={2} ellipsizeMode={'tail'}
                          style={[S.font13_666, {
                              flex: 1,
                              width: deviceWidth - vPx(32 + 8 + 62)
                          }]}>{item.introduction}</Text>
                </View>
            </TouchableOpacity>
        )
    }

    render() {
        const {masterList} = this.state
        return (
            <View style={styles.container}>
                <TitleBar title={'大咖'} remark={'邀请访谈行业大咖'}/>
                {masterList.length != 0 && masterList.map((item, index) => {
                    return (
                        this.renderItem(item, index)
                    )
                })}
            </View>
        )
    }


}

const styles = StyleSheet.create({
    container: {
        backgroundColor: '#fff',
        width: deviceWidth,
        marginTop: vPx(8),
        paddingVertical: vPx(16)
    },
    titleBar: {
        flexDirection: 'row',
        alignItems: 'center',
    },
    boldTitle: {
        fontSize: vPx(18),
        color: '#333333',
        fontWeight: 'bold',
        marginLeft: vPx(4)
    },
    remark: {
        fontSize: vPx(13),
        color: '#666666',
        marginLeft: vPx(8)
    },
    starItem: {
        height: vPx(62),
        flexDirection: 'row',
        marginHorizontal: vPx(16),
        marginTop: vPx(16)
    }

})
