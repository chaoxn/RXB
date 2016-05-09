/********************************************************************
 文件名称 : UIFont+Category.h 文件
 作 者   :
 创建时间 : 2012-00-00
 文件描述 : UIFont扩展类
 *********************************************************************/

#import "UIFont+Category.h"

@implementation UIFont (Category)


+ (UIFont *)fontOfHeitiScOfSize:(float)size
{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:size];
    return font;
}


+ (UIFont *)fontOfMediumOfSize:(float)size
{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Medium" size:size];
    return font;
}


+ (UIFont *)fontOfArialOfSize:(float)size
{
    UIFont *font = [UIFont fontWithName:@"Arial" size:size];
    return font;
}


+ (UIFont *)fontOfPingFangSCOfSize:(float)size
{
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:size];
    
    if (!font) {
        
        font = [UIFont fontOfHeitiScOfSize:size];
    }
    
    return font;
}

+ (UIFont *)fontOfHelveticaNeueBoldOfSize:(CGFloat )size {
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:size];
    
    if (!font) {
        
        font = [UIFont systemFontOfSize:size];
    }
    
    return font;
}

//+ (UIFont *)fontOfImpactOfSize:(CGFloat )size {
//
//    UIFont *font = [UIFont fontWithName:@"Impact" size:size];
//    return font;
//}

//输出所有的字体名称
+ (void)enumerateFonts{
    for(NSString *familyName in [UIFont familyNames]){
        NSLog(@"Font FamilyName = %@",familyName); //*输出字体族科名字
        
        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]){
            NSLog(@"\t%@",fontName);         //*输出字体族科下字样名字
        }
    }
}

@end
