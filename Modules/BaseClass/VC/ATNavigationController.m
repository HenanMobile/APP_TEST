//
//  ATNavigationController.m
//  AppTest
//
//  Created by 认默 on 16/10/12.
//  Copyright © 2016年 默认. All rights reserved.
//

#import "ATNavigationController.h"
#import "ATUtils.h"
#import "UIViewController+BarItem.h"

@interface ATNavigationController ()

@end

@implementation ATNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets=NO;
    
    UINavigationBar *naviBarApperance=[UINavigationBar appearance];
    [naviBarApperance setBarTintColor:COLOR_TABAR_BG];
    
    NSDictionary *textAttributes= @{NSFontAttributeName:[UIFont systemFontOfSize:18],
                                               NSForegroundColorAttributeName:[UIColor whiteColor]};
    [naviBarApperance setTitleTextAttributes:textAttributes];
    [naviBarApperance setTintColor:[UIColor whiteColor]];
    
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //设置导航控制器中当前控制器通过push到下一个控制器的返回按钮内容
    UIBarButtonItem *backButtonItem=[self setBackBarItem];
    self.visibleViewController.navigationItem.backBarButtonItem=backButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
