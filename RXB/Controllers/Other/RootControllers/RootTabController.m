//
//  RootTabController.m
//  RXB
//
//  Created by fizz on 16/5/5.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "RootTabController.h"
#import "HomepageVC.h"
#import "FindVC.h"
#import "PlayVC.h"
#import "MineVC.h"
#import "RDVTabBarItem.h"
#import "UIFont+Category.h"

#define TabbarTitles @[@"首页", @"找保险", @"一起玩", @"我的"]
#define SliderViewHeight 3.0f

@interface RootTabController ()

{
    UIView *slieder;
}

@end

@implementation RootTabController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViewControllers];
}

- (void)setupViewControllers
{
    HomepageVC *homepageVc = [[HomepageVC alloc]init];
    UINavigationController *homeVC = [[UINavigationController alloc]initWithRootViewController:homepageVc];
    
    FindVC *findVc = [[FindVC alloc]init];
    UINavigationController *findVC = [[UINavigationController alloc]initWithRootViewController:findVc];
    
    PlayVC *playVc = [[PlayVC alloc]init];
    UINavigationController *playVC = [[UINavigationController alloc]initWithRootViewController:playVc];
    
    MineVC *mineVc = [[MineVC alloc]init];
    UINavigationController *mineVC = [[UINavigationController alloc]initWithRootViewController:mineVc];
    
    self.delegate = self;
    
    [self setViewControllers:@[homeVC,findVC,playVC,mineVC]];
    
    [self addSliderView];
    [self customizeTabBarForController];
}

- (void)customizeTabBarForController
{
    //FIXME
    UIImage *backgroundImage = [UIImage imageNamed:@"tabbar_background"];
    NSArray *tabBarItemImages = @[@"0", @"1", @"2", @"3"];
    
    NSInteger index = 0;
    
    for (RDVTabBarItem *item in [[self tabBar] items]) {
        
        item.titlePositionAdjustment = UIOffsetMake(0, 10);
    
        [item setBackgroundSelectedImage:backgroundImage withUnselectedImage:backgroundImage];
        UIImage *selectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_selected",
                                                      [tabBarItemImages objectAtIndex:index]]];
        UIImage *unselectedimage = [UIImage imageNamed:[NSString stringWithFormat:@"%@_normal",
                                                        [tabBarItemImages objectAtIndex:index]]];
        
        
        [item setFinishedSelectedImage:selectedimage withFinishedUnselectedImage:unselectedimage];
        
        
        [item setSelectedTitleAttributes:@{NSFontAttributeName:[UIFont fontOfPingFangSCOfSize:11.0f],
                                           NSForegroundColorAttributeName:[UIColor colorWithRed:0.565  green:0.765  blue:0.129 alpha:1]}];
        [item setUnselectedTitleAttributes:@{NSFontAttributeName:[UIFont fontOfPingFangSCOfSize:11.0],
                                             NSForegroundColorAttributeName:[UIColor darkGrayColor]}];
        
        [item setTitle:[TabbarTitles objectAtIndex:index]];
        
        index++;
    }

}

- (void)addSliderView
{
    UIView *sliderView = [[UIView alloc]initWithFrame:CGRectMake(0, 49 - SliderViewHeight, ScreenWidth, SliderViewHeight)];
    sliderView.backgroundColor = [UIColor darkGrayColor];
    [self.tabBar insertSubview:sliderView belowSubview:[self.tabBar.items firstObject]];
    
    UIView *sliderLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth/4, SliderViewHeight)];
    sliderLineView.backgroundColor = [UIColor colorWithRed:0.565  green:0.765  blue:0.129 alpha:1];
    [sliderView addSubview:sliderLineView];
    
    slieder = sliderLineView;
}

- (void)moveSliderView:(NSUInteger )currenIndex {
    
    [UIView animateWithDuration:0.30f animations:^{
        
        slieder.frame = CGRectMake(0 + currenIndex * ScreenWidth/4, 0, ScreenWidth/4, SliderViewHeight);
    }];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    
    [super setSelectedIndex:selectedIndex];
    
    RDVTabBarItem *item = self.tabBar.items [selectedIndex];
    
    [item setTitle:TabbarTitles[selectedIndex]];
    
    [self moveSliderView:selectedIndex];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
