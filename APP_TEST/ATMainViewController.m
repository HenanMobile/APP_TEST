//
//  ATMainViewController.m
//  APP_TEST
//
//  Created by 认默 on 2016/10/13.
//  Copyright © 2016年 默认. All rights reserved.
//

#import "ATMainViewController.h"
#import "MainViewController.h"
#import "PeopleViewController.h"
#import "SetViewController.h"
#import "UIImage+Color.h"
#import "ATViewController.h"
#import "ATTools.h"
#import "ATUtils.h"
#import "ATTabBarButton.h"



@interface ATMainViewController ()<UITabBarControllerDelegate>
/**
 *  设置之前选中的按钮
 */
@property (nonatomic, weak) UIButton *selectedBtn;

///tabbar标题数组
@property(nonatomic,copy) NSMutableArray *tabBarTitleArray;

@end

@implementation ATMainViewController

-(instancetype)init
{
    self=[super init];
    if (self) {
        [self homeNaviConfig];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self configTabBar];
}

-(void)configTabBar
{
    UIFont *font=[UIFont systemFontOfSize:12.f];
    UIColor *normalColor=[UIColor brownColor];
    UIColor *selectColor=[UIColor redColor];
    NSDictionary *normalAttr=@{NSFontAttributeName:font,
                               NSForegroundColorAttributeName:normalColor};
    NSDictionary *selectAttr=@{NSFontAttributeName:font,
                               NSForegroundColorAttributeName:selectColor};
    [[UITabBarItem appearance] setTitleTextAttributes:normalAttr
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:selectAttr
                                             forState:UIControlStateSelected];
    
    UITabBarItem *item1=nil;
    UITabBarItem *item2=nil;
    UITabBarItem *item3=nil;
    
    item1=[[UITabBarItem alloc] initWithTitle:@"首页" image:[[UIImage new] imageFromColor:[UIColor greenColor]] selectedImage:[[UIImage new] imageFromColor:[UIColor grayColor]]];
    item2=[[UITabBarItem alloc] initWithTitle:@"联系人" image:[[UIImage new] imageFromColor:[UIColor greenColor]] selectedImage:[[UIImage new] imageFromColor:[UIColor grayColor]]];
    item3=[[UITabBarItem alloc] initWithTitle:@"设置" image:[[UIImage new] imageFromColor:[UIColor greenColor]] selectedImage:[[UIImage new] imageFromColor:[UIColor grayColor]]];
    item1.tag = 101;
    item2.tag = 102;
    item3.tag = 103;
    
    ATViewController *vc1=[[MainViewController alloc] init];
    vc1.tabBarItem=item1;
    ATViewController *vc2=[[PeopleViewController alloc] init];
    vc2.tabBarItem=item2;
    ATViewController *vc3=[[SetViewController alloc] init];
    vc3.tabBarItem=item3;
    
    self.viewControllers=@[vc1,vc2,vc3];
    
    
    
    
//    UIView *barView=[[UIView alloc] initWithFrame:CGRectMake(0, kScreen_Height-49, kScreen_Width, 49)];
//    barView.backgroundColor=[UIColor whiteColor];
//    [self.view addSubview:barView];
}

///首页配置
-(void)homeNaviConfig
{
    
    NSString *title = @"首页";
    UILabel *titV=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 320, 60)];
    titV.text=title;
    titV.textAlignment=NSTextAlignmentCenter;
    self.navigationItem.titleView = titV;
    self.title=@"首页";
    
    UIButton *rightButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    rightButton.frame=CGRectMake(0, 0, 60, 40);
    [rightButton setTintColor:[UIColor purpleColor]];
    [rightButton setTitle:@"连接" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(btnLogin:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

#pragma mark - 备用
///自定义TabBar
-(void)customTabBar
{
    CGRect rect = self.tabBar.frame;
    [self.tabBar removeFromSuperview];
    //测试添加自己的视图
    UIView *myView = [[UIView alloc] init];
    myView.frame = rect;
    myView.backgroundColor = [UIColor redColor];
    [self.view addSubview:myView];
    
    _tabBarTitleArray=[[NSMutableArray alloc] initWithObjects:@"首页",@"联系人",@"设置", nil];
    
    for (int i = 0; i < _tabBarTitleArray.count; i++) {
        //UIButton *btn = [[UIButton alloc] init];
        ATTabBarButton *btn = [[ATTabBarButton alloc] init];
        
        CGFloat x = i * myView.frame.size.width / _tabBarTitleArray.count;
        btn.frame = CGRectMake(x, 0, myView.frame.size.width / _tabBarTitleArray.count, myView.frame.size.height);
        
        [myView addSubview:btn];
        
        btn.tag = i;//设置按钮的标记, 方便来索引当前的按钮,并跳转到相应的视图
        [btn setTitle:_tabBarTitleArray[i] forState:UIControlStateNormal];
        
        //带参数的监听方法记得加"冒号"
        [btn addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //设置刚进入时,第一个按钮为选中状态
        if (0 == i) {
            btn.selected = YES;
            self.selectedBtn = btn;  //设置该按钮为选中的按钮
        }
    }

}

#pragma mark - UITabBarControllerDelegate
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    switch (item.tag) {
        case 101:{
            [self homeNaviConfig];
        }
            break;
        case 102:{
            self.navigationItem.titleView=nil;
            self.navigationItem.title=@"联系人";
            self.navigationItem.rightBarButtonItem=nil;
        }
            break;
        case 103:{
            self.navigationItem.titleView=nil;
            self.navigationItem.title=@"设置";
            self.navigationItem.rightBarButtonItem=nil;
        }
            break;
    }
}

#pragma mark - 登录按钮
-(void)btnLogin:(UIButton *)sender
{
    ALERT(@"提示", @"取消连接");
}

#pragma mark - tabBar点击
-(void)tabBarButtonClick:(UIButton *)sender
{
    ALERT(@"提示", @"取消连接");
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
