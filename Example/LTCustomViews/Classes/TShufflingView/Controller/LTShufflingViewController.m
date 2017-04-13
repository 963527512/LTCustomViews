//
//  LTShufflingViewController.m
//  LTShufflingView
//
//  Created by 冰凌天 on 2017/4/13.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTShufflingViewController.h"
#import "LTShufflingView.h"
#import "AFNetworking.h"
#import "LTFocusImageModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

#define kBaseUrl @"http://mobile.ximalaya.com/"

@interface LTShufflingViewController ()

@end

@implementation LTShufflingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    LTShufflingView *shufflingView = [LTShufflingView shufflingView];
    shufflingView.frame = CGRectMake(0, 100, width, 200);
    [self.view addSubview:shufflingView];
    
    NSString *url = [NSString stringWithFormat:@"%@%@", kBaseUrl, @"mobile/discovery/v4/recommends"];
    NSDictionary *param = @{
                            @"channel": @"ios-b1",
                            @"device": @"iPhone",
                            @"includeActivity": @(YES),
                            @"includeSpecial": @(YES),
                            @"scale": @2,
                            @"version": @"5.4.21"
                            };
    [[AFHTTPSessionManager manager] GET:url parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        NSArray<LTFocusImageModel *> *focusImageMs = [LTFocusImageModel mj_objectArrayWithKeyValuesArray:responseObject[@"focusImages"][@"list"]];
        
        [shufflingView setTotalCount:focusImageMs.count loadImage:^(UIImageView *imageView, NSInteger index) {
            [imageView sd_setImageWithURL:[NSURL URLWithString:focusImageMs[index].pic]];
        }];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
    
    shufflingView.clickEvent = ^(NSInteger index) {
        NSLog(@"%zd", index);
    };
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
