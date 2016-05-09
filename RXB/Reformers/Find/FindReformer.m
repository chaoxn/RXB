//
//  FindReformer.m
//  RXB
//
//  Created by fizz on 16/5/9.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "FindReformer.h"
#import "FindApiManager.h"

@implementation FindReformer

- (id)manager:(APIBaseManager *)manager reformData:(NSDictionary *)data {
    [SVProgressHUD dismiss];
   
    if ([manager isKindOfClass:[FindApiManager class]]) {
        
        return data[@"data"][@"list"];
    }
    
    else {
        return nil;
    }
}

@end
