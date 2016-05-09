//
//  BaseViewController.h
//  RXB
//
//  Created by fizz on 16/5/5.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController


#pragma mark --------------------Navigation设置--------------------


/**
 *  设置左边按钮；title和图片目前只能二选一，title优先级高于图片
 *
 *  @param title     title description
 *  @param imageName imageName description
 */
- (void)setLeftNaviItemWithTitle:(NSString *)title imageName:(NSString *)imageName;

/**
 *  设置右边按钮；title和图片目前只能二选一，title优先级高于图片
 *
 *  @param title     title description
 *  @param imageName imageName description
 */
- (void)setRightNaviItemWithTitle:(NSString *)title imageName:(NSString *)imageName;

/**
 *  @author qiaoqiao.wu
 *
 *  自定义左边的按钮
 *
 *  @param leftButton leftButton description
 */
- (void)setLeftNaviItemWithButton:(UIButton *)leftButton;

/**
 *  @author qiaoqiao.wu
 *
 *  自定义右边的按钮
 *
 *  @param rightButton rightButton description
 */
- (void)setRightNaviItemWithButton:(UIButton *)rightButton;

#pragma mark --------------------等待提示显示--------------------



@end
