//
//  NetRequest.h
//  RXB
//
//  Created by fizz on 16/5/6.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIBaseManager.h"

typedef void(^ SuccessBlock)(NSURLSessionDataTask *task, id responseObject);
typedef void(^ FailedBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void(^ ResultBlock)(id data, NSError *error);


@interface NetRequest : AFHTTPRequestOperationManager

+ (instancetype)shareInstance;

- (void)requestAsynchRonousWithurl:(NSString *)url
                            params:(NSDictionary *)params
                       requestType:(NSString *)requestType
                     customeHandle:(SuccessBlock)successBlock
                     failureHandle:(FailedBlock)failBlock;

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(APIManagerRequestType)method
                       andBlock:(ResultBlock)block;

@end
