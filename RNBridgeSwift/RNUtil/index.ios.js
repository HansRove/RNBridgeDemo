'use strict';

import React, { Component } from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
} from 'react-native';
//按钮1   退出当前回到原生，带出数据
  //按钮2   获取原生中数据
  //数据展示
class RNTestViewModule extends Component {
// 初始化
  constructor(props) {
    super(props);
    this.state={
      callBackSuccess:false,
      callBackItems:null,
    };
  }
  render() {
    var { NativeModules } = require('react-native');
    //创建原生模块实例,NativeModules 是 react-native 文件夹下实例，swift是RCT_EXPORT_MODULE(swift); Swift设定的
    var RNBridgeModule=NativeModules.swift;

    var contents = this.props["scores"].map(
      score => <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
    );
    var callBackContents = this.state.callBackSuccess ? this.state.callBackItems.map(
      score => <Text key={score.name}>{score.name}:{score.value}{"\n"}</Text>
    ) : null;

    return (
      <View style={styles.container}>

        <TouchableHighlight style={styles.btnBack} underlayColor="#eee" onPress={() => {
            //方法调用 transportMessage要和Swift设定的一样
          RNBridgeModule.transportMessage({'name':'华南犀牛','url':'http://www.jianshu.com/u/5d91572789ad'});
        }}>
            <Text style={{color:'#ffffff'}}>back回上层VC</Text>
          </TouchableHighlight>

          <TouchableHighlight style={styles.btnFetch} underlayColor="#eee" onPress={()=>{RNBridgeModule.RNInvokeOCCallBack(
            //方法调用 RNInvokeOCCallBack 要和Swift设定的一样，并把下面这个字典传给OC
            {'name':'华南犀牛','url':'http://www.jianshu.com/u/5d91572789ad'},
            // 回调方法，从OC中获取events数组
            (error,events)=>{
                if(error){
                  console.error(error);
                }else{
                  this.setState({callBackItems:events, callBackSuccess:true});
                }
          })}}>
            <Text style={{color:'#ffffff'}}>获取原生中数据</Text>
          </TouchableHighlight>

        <Text style={styles.scores}>
          {this.state.callBackSuccess ? callBackContents : contents }
        </Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFFFFF',
  },
  scores: {
    fontSize: 20,
    textAlign: 'center',
    color: '#333333',
    margin: 15,
  },
  btnBack:{
    width: 150,
    height: 40,
    borderRadius: 20,
    backgroundColor: "red",
    alignItems: "center",
    justifyContent: "center",
    marginTop: 15,
  },
  btnFetch:{
    width: 150,
    height: 40,
    borderRadius: 20,
    backgroundColor: "blue",
    alignItems: "center",
    justifyContent: "center",
    marginTop: 15,
  },
});

// Module name
AppRegistry.registerComponent('RNTestViewModule', () => RNTestViewModule);