//
//  RNManagerBridge.m
//  RNBridgeSwift
//
//  Created by Zero on 2017/3/28.
//  Copyright © 2017年 macbook. All rights reserved.
//

#import "RNManagerBridge.h"


@implementation RNManagerBridge

    RCT_EXPORT_MODULE(swift); //此处不添加参数即默认为这个OC类的名字（RNManagerBridge）
    
    // transportMessage 和 js上调用方法一致
    RCT_EXPORT_METHOD(transportMessage:(id)message) {
        NSLog(@"transportMessage:\n %@",message);
        
        if ([message isKindOfClass:[NSDictionary class]]) {
            NSString *method = [message objectForKey:@"method"];
            
            BOOL isNext = method ? ([method isEqualToString:@"push"] || [method isEqualToString:@"present"]) : NO ;
            
            if (isNext) {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificatioinNext" object:message userInfo:nil];
            } else {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificatioinBack" object:message userInfo:nil];
            }
            
        }
    }
    
    //RN传参数调用原生OC,并且返回数据给RN  通过CallBack
    RCT_EXPORT_METHOD(RNInvokeOCCallBack:(NSDictionary *)dictionary callback:(RCTResponseSenderBlock)callback){
        NSLog(@"接收到RN传过来的数据为:%@",dictionary);
        NSArray *events = @[
                            @{
                                @"name" : @"我是回调1item---",
                                @"value": @"100"
                                },
                            @{
                                @"name" : @"我是回调2item---",
                                @"value": @"99"
                                }
                            ];
        
        callback(@[[NSNull null], events]);
    }
@end
