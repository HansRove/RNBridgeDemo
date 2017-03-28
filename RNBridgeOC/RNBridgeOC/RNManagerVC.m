//
//  RNManagerVC.m
//  RNBridgeOC
//
//  Created by Zero on 2017/3/27.
//  Copyright © 2017年 macbook. All rights reserved.
//

#import "RNManagerVC.h"
#import "NotificationMacro.h"

@interface RNManagerVC ()
{
    RNBackTypeBlock backBlock_;
    RNNextTypeBlock nextBlock_;
}
@end

@implementation RNManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
}
/// RNBackTypeBlock
    // RN控制器跳回上级控制器操作
    // typedef void(^RNBackTypeBlock)(id rnParams);
/// RNNextTypeBlock
    // RN控制器跳转别的控制器操作
    // typedef void(^RNNextTypeBlock)(UIViewController *vc, id rnParams);
- (instancetype)initWithBack:(RNBackTypeBlock)rnBackTyp Next:(RNNextTypeBlock)rnNextType {
    if(self = [super init]){
        
        backBlock_ = rnBackTyp;
        nextBlock_ = rnNextType;
    }
    
    return self;
}

/// 不能写在viewDidLoad  和 dealloc 因为有可能有原生跳RN  再跳原生  再跳RN  最后back，发通知会收到两个通知方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [Notif addObserver:self selector:@selector(back:) name:kNotificationRNBackName object:nil];
    [Notif addObserver:self selector:@selector(nextVC:) name:kNotificationRNNextVCName object:nil];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    NotificationAllRemoveFrom(self);
}
- (void)dealloc {
    nextBlock_ = nil;
    backBlock_ = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

- (void)back:(NSNotification *)notification {
    NSLog(@"current NSThread %@",[NSThread currentThread]);
    
    id params = [notification object];
    
    // 必须在主线程跳转VC, 因为RN会开一条特殊的线程处理
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (backBlock_) {
            backBlock_(params);
        }
        
        if(self.navigationController.viewControllers.count > 1)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    });
}

- (void)nextVC:(NSNotification *)notification {
    NSLog(@"current NSThread %@",[NSThread currentThread]);
    
    id params = [notification object];
    
    // 必须在主线程跳转VC, 因为RN会开一条特殊的线程处理
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (nextBlock_) {
            nextBlock_(self, params);
        }
    });
    
}

@end
