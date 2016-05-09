//
//  APIBaseManager.m
//  RXB
//
//  Created by fizz on 16/5/6.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "APIBaseManager.h"
#import "NetRequest.h"
#import "NetReachibility.h"

#define CallAPI(REQUESTTYPE, APINAME, PARAMS) \
{       \
[[NetRequest shareInstance] requestJsonDataWithPath:APINAME withParams:PARAMS withMethodType:REQUESTTYPE andBlock:^(id data, NSError *error){               \
          [self successedOnCallingAPI:data];                                      \
}];  \
}

@interface APIBaseManager()

@property (nonatomic, strong, readwrite) id fetchedRawData;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) APIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;

@end

@implementation APIBaseManager

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _paramSource = nil;
        
        _fetchedRawData = nil;
        
        _errorMessage = nil;
        _errorType = APIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(APIManager)]) {
            self.child = (id <APIManager>)self;
        }
    }
    return self;
}

- (void)successedOnCallingAPI:(id )data
{
    if (data) {
        self.fetchedRawData = data;
    }
    
    if ([self.validator manager:self isCorrectWithCallBackData:data]) {
        
        [self.delegate managerCallAPIDidSuccess:self];
    } else {
        
        [self failedOnCallingAPI:data withErrorType:APIManagerErrorTypeNoContent];
    }
}

- (void)failedOnCallingAPI:(id)data withErrorType:(APIManagerErrorType)errorType
{
    self.errorType = errorType;
    [self.delegate managerCallAPIDidFailed:self];
}

- (id)fetchDataWithReformer:(id<APIManagerCallbackDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(manager:reformData:)]) {
        resultData = [reformer manager:self reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy];
    }
    return resultData;
}

#pragma mark - calling api
- (void)loadData
{
    NSDictionary *params = [self.paramSource paramsForApi:self];
    [self loadDataWithParams:params];
}

- (void )loadDataWithParams:(NSDictionary *)params
{
    // FIXME:-参数整合
    NSDictionary *apiParams = [self reformParams:params];
    
    NSString *APIName = [self.child methodName];
    
    APIManagerRequestType requestType = self.child.requestType;
    switch (requestType) {
        case APIManagerRequestTypeGet:
            CallAPI(requestType, APIName ,params);
            break;
        case APIManagerRequestTypePost:
            CallAPI(requestType, APIName, params);
            break;
        default:
            break;
    }
}

//如果需要在调用API之前额外添加一些参数，比如pageNumber和pageSize之类的就在这里添加
//子类中覆盖这个函数的时候就不需要调用[super reformParams:params]了
- (NSDictionary *)reformParams:(NSDictionary *)params
{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        // 如果child是继承得来的，那么这里就不会跑到，会直接跑子类中的IMP。
        // 如果child是另一个对象，就会跑到这里
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

// 网络判断
- (BOOL)isReachable
{
    return [[NetReachibility shareInstance] isReachability];
}

@end
