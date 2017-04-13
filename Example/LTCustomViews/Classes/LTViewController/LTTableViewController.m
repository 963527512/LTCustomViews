//
//  LTTableViewController.m
//  LTCustomViews
//
//  Created by 冰凌天 on 2017/4/13.
//  Copyright © 2017年 963527512@qq.com. All rights reserved.
//

#import "LTTableViewController.h"
#import "LTShufflingViewController.h"           // 轮播图测试界面

@interface LTTableViewController ()

/** 数组 */
@property (nonatomic, strong) NSArray *titles;

@end

@implementation LTTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.titles = @[
                    @"LTShufflingView"
                    ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *Id = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:Id];
    }
    
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            LTShufflingViewController *sVc = [[LTShufflingViewController alloc] init];
            [self.navigationController pushViewController:sVc animated:YES];
        }
            break;
        default:
            break;
    }
}

@end






































