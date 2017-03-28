//
//  RNBridgeModule.m
//  RNBridgeOC
//
//  Created by Zero on 2017/3/27.
//  Copyright © 2017年 macbook. All rights reserved.
//

#import "RNBridgeModule.h"
#import "NotificationMacro.h"

@implementation RNBridgeModule

RCT_EXPORT_MODULE(hans); //此处不添加参数即默认为这个OC类的名字（RNBridgeModule）

// transportMessage 和 js上调用方法一致
RCT_EXPORT_METHOD(transportMessage:(id)message) {
    NSLog(@"transportMessage:\n %@",message);
 
    if ([message isKindOfClass:[NSDictionary class]]) {
        NSString *method = [message objectForKey:@"method"];
        
        BOOL isNext = method ? ([method isEqualToString:@"push"] || [method isEqualToString:@"present"]) : NO ;
        
        if (isNext) {
            kNotificationRNNextVC(message);
        } else {
            kNotificationRNBack(message);
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
