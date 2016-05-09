//
//  NetRequest.m
//  RXB
//
//  Created by fizz on 16/5/6.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "NetRequest.h"


@implementation NetRequest

+ (instancetype)shareInstance {
    static NetRequest *netRequest = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netRequest = [[self alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    return netRequest;
}


- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer.timeoutInterval = 10;
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", @"application/x-javascript", nil];
    
    [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];
    
    //是否验证主机名
    self.securityPolicy.validatesDomainName = NO;
    //是否允许CA不信任的证书通过
    self.securityPolicy.allowInvalidCertificates = YES;
    
    return self;
}

/**
 *  异步请求
 *
 *  @param url          API
 *  @param params       参数
 *  @param requestType  请求类型
 *  @param successBlock 成功回调
 *  @param failBlock    失败回调
 */
- (void)requestAsynchRonousWithurl:(NSString *)url params:(NSDictionary *)params requestType:(NSString *)requestType customeHandle:(SuccessBlock)successBlock failureHandle:(FailedBlock)failBlock {
    

    //    NSURL *baseURL = [NSURL URLWithString:@"http://www.baidu.com/"];
    //    AFHTTPSessionManager *sessionManager = [[AFHTTPSessionManager alloc]initWithBaseURL:baseURL];
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    
    sessionManager.requestSerializer.timeoutInterval = 5;
    NSOperationQueue *operationQueue = sessionManager.operationQueue;
    [self reachbilityNetworkWithOperation:operationQueue networkManager:sessionManager url:url];
    
    
    
    //FIXME
}

- (void)reachbilityNetworkWithOperation:(NSOperationQueue *)operationQueue networkManager:(AFHTTPSessionManager *)sessionManager url:(NSString *)url {
    [sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [SVProgressHUD showErrorWithStatus:@"您的网络断开连接"];
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    [sessionManager.reachabilityManager startMonitoring];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(APIManagerRequestType )method
                       andBlock:(void (^)(id data, NSError *error))block{
    
    [self requestJsonDataWithPath:aPath withParams:params withMethodType:method autoShowError:YES andBlock:block];
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary*)params
                 withMethodType:(APIManagerRequestType )method
                  autoShowError:(BOOL)autoShowError
                       andBlock:(ResultBlock)block{
    if (!aPath || aPath.length <= 0) {
        return;
    }
 
    DLog(@"\n===========request===========\n%@:\n%@", aPath, params);
    aPath = [aPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    
    switch (method) {
        case APIManagerRequestTypeGet:{
//            //所有 Get 请求，增加缓存机制
//            NSMutableString *localPath = [aPath mutableCopy];
//            if (params) {
//                [localPath appendString:params.description];
//            }
            [self GET:aPath parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, responseObject);
//                id error = [self handleResponse:responseObject autoShowError:autoShowError];
                id error;
                if (error) {
//                    responseObject = [NSObject loadResponseWithPath:localPath];
//                    block(responseObject, error);
                }else{
                    if ([responseObject isKindOfClass:[NSDictionary class]]) {
                        //判断数据是否符合预期，给出提示
                        if ([responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
                           
                        }
                    }
                    block(responseObject, nil);
                }
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                DLog(@"\n===========response===========\n%@:\n%@", aPath, error);
//                !autoShowError || [NSObject showError:error];
//                id responseObject = [NSObject loadResponseWithPath:localPath];
//                block(responseObject, error);
            }];
            break;}
        case APIManagerRequestTypePost:{
            
            break;
        }
            
            
            
        default:
            break;
    }
}



@end
