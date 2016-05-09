//
//  NetReachibility.m
//  RXB
//
//  Created by fizz on 16/5/6.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "NetReachibility.h"

@interface NetReachibility ()

@property (nonatomic, assign, readwrite) BOOL isReachability;
@property (nonatomic, strong) Reachability *reachBility;

@end

@implementation NetReachibility

+ (NetReachibility *)shareInstance {
    static NetReachibility *reachbility = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        reachbility = [[NetReachibility alloc]init];
    });
    return reachbility;
}

- (void)startReachbility {
    self.reachBility = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    typeof(self) weakSelf = self;
    
    self.reachBility.reachableBlock = ^(Reachability *reachability) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.isReachability = YES;
        });
    };
    
    self.reachBility.unreachableBlock = ^(Reachability *reachability) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.isReachability = NO;
            [SVProgressHUD showErrorWithStatus:@"您的网络断开连接"];
        });
    };
    
    [self.reachBility startNotifier];
}
- (BOOL)isReachability {
    if (self.reachBility.currentReachabilityStatus == NotReachable) {
        self.isReachability = NO;
        return NO;
    }else {
        self.isReachability = YES;
        return YES;
    }
}


@end
