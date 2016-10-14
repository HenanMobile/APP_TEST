//
//  UIViewController+BarItem.h
//  Fullbcn
//
//  Created by apple on 15/11/30.
//  Copyright © 2015年 Cisetech. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MessageButton.h"

@interface UIViewController (BarItem)

- (UIView *)barButtonWithTitle:(NSString *)title
                      fontSize:(CGFloat)fontSize
                        action:(SEL)action;

- (UIBarButtonItem *)barButtonWithImageName:(NSString *)imgName
                            action:(SEL)action;

- (UIBarButtonItem *)setBackBarItem;


//- (MessageButton *)barButtonWithMessageWithAction:(SEL)action;

@end
