//
//  ATTools.m
//  AppTest
//
//  Created by 认默 on 16/10/13.
//  Copyright © 2016年 默认. All rights reserved.
//

#import "ATTools.h"
#import "ATUtils.h"

@implementation ATTools




+ (CGFloat)widthOfLabel:(NSString *)strText
               fontSize:(CGFloat)fontSize
{
    CGSize size;
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    if (kVersion >= 7.0) {
        NSDictionary *attribute = @{NSFontAttributeName:font};
        size = [strText boundingRectWithSize:CGSizeMake(0, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    } else {
        //        size = [strText sizeWithFont:font];
    }
    
    return size.width;
}


@end
