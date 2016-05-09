//
//  Macro.h
//  RXB
//
//  Created by fizz on 16/5/5.
//  Copyright © 2016年 chaox. All rights reserved.
//

#ifndef Macro_h
#define Macro_h

/** 字体*/
#define Font(x) [UIFont systemFontOfSize:x]
#define BoldFont(x) [UIFont boldSystemFontOfSize:x]

/** 颜色*/
#define RGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define RGB16Color(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/** 输出 */
#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"\n%s [Line %d] \n" fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define DLog(...)
#endif

/** 获取硬件信息*/
#define ScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define ScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define zoomRate ([[UIScreen mainScreen] bounds].size.width / 375.0f)

#define WidthRate ([[UIScreen mainScreen] bounds].size.width / 375.0f)
#define HeightRate ([[UIScreen mainScreen] bounds].size.height / 667.0f)

#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
#define CurrentSystemVersion [[[UIDevice currentDevice] systemVersion] floatValue]

#define kKeyWindow [UIApplication sharedApplication].keyWindow

/** 适配*/
#define iOS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define iOS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define iOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define iOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define iOS_9_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)

#define iPhone4_OR_4s    (SXSCREEN_H == 480)
#define iPhone5_OR_5c_OR_5s   (SXSCREEN_H == 568)
#define iPhone6_OR_6s   (SXSCREEN_H == 667)
#define iPhone6Plus_OR_6sPlus   (SXSCREEN_H == 736)
#define iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 弱指针*/
#define WeakSelf(weakSelf) __weak __typeof(&*self)weakSelf = self;

/** 加载本地文件*/
#define LoadImage(file,type) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define LoadArray(file,type) [UIImage arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]
#define LoadDict(file,type) [UIImage dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:type]]

/** 多线程GCD*/
#define GlobalGCD(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MainGCD(block) dispatch_async(dispatch_get_main_queue(),block)

/** 数据存储*/
#define UserDefaults [NSUserDefaults standardUserDefaults]
#define CacheDir [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#define DocumentDir [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define TempDir NSTemporaryDirectory()

#define CX_DOCUMENT_DIRECTORY NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject

#define CX_APP_NAME    ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"])
#define CX_APP_VERSION ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])
#define CX_APP_BUILD   ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"])

/** 项目*/
#define kTitleFontColor UIColorFromRGB(0x57585a)


#endif
