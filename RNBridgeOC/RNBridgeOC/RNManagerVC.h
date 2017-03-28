//
//  RNManagerVC.h
//  RNBridgeOC
//
//  Created by Zero on 2017/3/27.
//  Copyright © 2017年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

// RN控制器跳回上级控制器操作
typedef void(^RNBackTypeBlock)(id rnParams);

// RN控制器跳转别的控制器操作
typedef void(^RNNextTypeBlock)(UIViewController *vc, id rnParams);

@interface RNManagerVC : UIViewController

- (instancetype)initWithBack:(RNBackTypeBlock)rnBackTyp Next:(RNNextTypeBlock)rnNextType;

@end
