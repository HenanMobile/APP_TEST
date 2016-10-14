//
//  UIImage+Color.m
//  AppTest
//
//  Created by 认默 on 16/10/13.
//  Copyright © 2016年 默认. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

- (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
