//
//  NetReachibility.h
//  RXB
//
//  Created by fizz on 16/5/6.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^isReach)(BOOL reachState);

@interface NetReachibility : NSObject
@property (nonatomic, assign, readonly) BOOL isReachability;


+ (NetReachibility *)shareInstance;
- (void)startReachbility;
- (BOOL)isReachability;

@end
