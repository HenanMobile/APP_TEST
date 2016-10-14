//
//  ATUtils.h
//  AppTest
//
//  Created by 认默 on 16/10/12.
//  Copyright © 2016年 默认. All rights reserved.
//

#ifndef ATUtils_h
#define ATUtils_h


#endif /* ATUtils_h */

/** debug信息*/
#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

/** 颜色*/
/** 导航条背景色*/
#define COLOR_TABAR_BG (UIColorFromRGB(0x5B00AE))






/**  当前系统版本 */
#define kVersion [[[UIDevice currentDevice] systemVersion] doubleValue]

/**  当前屏幕高度 */
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

/**  当前屏幕宽度 */
#define kScreen_Width [UIScreen mainScreen].bounds.size.width



/**  设置RGB颜色 */
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

/**  十六进制颜色 */
#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >>16))/255.0f \
green:((float)((rgbValue & 0xFF00) >>8))/255.0f \
blue:((float)(rgbValue & 0xFF))/255.0f \
alpha:1.0]


/**  系统提示框 */
#define ALERT(title,msg)  [[[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil] show]