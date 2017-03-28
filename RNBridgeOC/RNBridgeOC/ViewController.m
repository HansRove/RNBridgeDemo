//
//  ViewController.m
//  RNBridgeOC
//
//  Created by Zero on 2017/3/27.
//  Copyright © 2017年 macbook. All rights reserved.
//

#import "ViewController.h"
#import "RNManagerVC.h"
#import <React/RCTRootView.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (weak, nonatomic) IBOutlet UILabel *thankLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = NSLocalizedString(@"原生VC", nil);
    
}

// 跳转RN生产View的控制器
- (IBAction)jumpRN:(UIButton *)sender {
    NSLog(@"jump RN");
    // 因为要用到http, 要排除localhost域名，或者打开ATS
    NSURL *jsCodeLocation = [NSURL
                             URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios"];
    // 传给RN的参数必须是字典类型，要和js代码propertis一致
    NSDictionary *params = @{@"scores" : @[
                                     @{@"name" : @"Alex",
                                         @"value": @"42"},
                                     @{@"name" : @"Joel",
                                         @"value": @"10"}
                                     ]
                             };
    // moduleName 要对应index.ios.js 上的 AppRegistry module
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL : jsCodeLocation
                                                 moduleName        : @"RNTestViewModule"
                                                 initialProperties : params
                                                  launchOptions    : nil];
    
    // RN管理VC
    RNManagerVC *vc = [[RNManagerVC alloc] initWithBack:^(id rnParams) {
        // 返回回调
        NSLog(@"params %@",rnParams);
        if ([rnParams isKindOfClass:[NSDictionary class]]) {
            self.welcomeLabel.text = [rnParams objectForKey:@"name"];
            self.thankLabel.text = [rnParams objectForKey:@"url"];
        }
        
    } Next:^(UIViewController *vc, id rnParams) {
        // 跳转VC回调
        NSLog(@"params %@",rnParams);
        UIViewController *nextVC = [UIViewController new];
        nextVC.view.backgroundColor = [UIColor redColor];
        if ([rnParams isKindOfClass:[NSDictionary class]]) {
            nextVC.title = [rnParams objectForKey:@"name"];
        }
        UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
        item.title = @"";
        vc.navigationItem.backBarButtonItem = item;
        [vc.navigationController pushViewController:nextVC animated:YES];
    }];
    // 赋值RN的view到VC中view(必须)
    vc.view = rootView;
    vc.title = @"承载RN视图的VC";
    // 去掉返回箭头的title
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"";
    self.navigationItem.backBarButtonItem = item;
    [self.navigationController pushViewController:vc animated:YES];
//    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
