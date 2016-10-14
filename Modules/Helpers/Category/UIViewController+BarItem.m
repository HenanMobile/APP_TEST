//
//  UIViewController+BarItem.m
//  Fullbcn
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 Cisetech. All rights reserved.
//

#import "UIViewController+BarItem.h"
#import "ATTools.h"

@implementation UIViewController (BarItem)

- (UIView *)barButtonWithTitle:(NSString *)title
                      fontSize:(CGFloat)fontSize
                        action:(SEL)action
{
    UIButton *btn = [[UIButton alloc] init];
    CGFloat width = [ATTools widthOfLabel:title
                   fontSize:fontSize]+20;
    CGSize size = CGSizeMake(width, 25);
    btn.frame = (CGRect){{0,0},size};
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [btn addTarget:self action:action
  forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (UIBarButtonItem *)setBackBarItem
{
    UIImage* image = [UIImage imageNamed:@"tarbar_back"];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width, 0, 0)];
    UIBarButtonItem* item =
    [[UIBarButtonItem alloc] initWithTitle:@""
                                     style:UIBarButtonItemStylePlain
                                    target:nil action:nil];
    [item setBackButtonBackgroundImage:image
                              forState:UIControlStateNormal
                            barMetrics:UIBarMetricsDefault];
    [item setBackButtonTitlePositionAdjustment:UIOffsetMake(-400.f, 0)
                                 forBarMetrics:UIBarMetricsDefault];
    return item;
}

- (UIBarButtonItem *)barButtonWithImageName:(NSString *)imgName
                            action:(SEL)action
{
    UIImage* image = [UIImage imageNamed:imgName];
    UIBarButtonItem *item =
    [[UIBarButtonItem alloc] initWithImage:image
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:action];
    return item;
}

//- (MessageButton *)barButtonWithMessageWithAction:(SEL)action
//{
//    CGRect rect = CGRectMake(0, 0, 44, 44);
//    MessageButton *btn = [[MessageButton alloc] initWithFrame:rect];
//    [btn setImage:[UIImage imageNamed:@"tarbar_message"]
//         forState:UIControlStateNormal];
//    [btn setTitle:@"11" forState:UIControlStateNormal];
//    [btn addTarget:self action:action
//  forControlEvents:UIControlEventTouchUpInside];
//    return btn;
//}


@end
