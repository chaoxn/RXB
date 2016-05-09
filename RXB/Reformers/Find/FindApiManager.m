//
//  FindApiManager.m
//  RXB
//
//  Created by fizz on 16/5/9.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "FindApiManager.h"

@interface FindApiManager()

@property (nonatomic, copy, readwrite) NSString *methodName;

@end

@implementation FindApiManager

@synthesize methodName = _methodName;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _methodName = @"http://api2.pianke.me/ting/radio_list";
        
        self.delegate = self;
        self.paramSource = self;
        self.validator = self;
    }
    return self;
}

- (APIManagerRequestType)requestType
{
    return APIManagerRequestTypeGet;
}

#pragma mark - RTAPIManagerApiCallBackDelegate
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    //
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    //do nothing
}

#pragma mark - RTAPIManagerValidator
- (BOOL)manager:(APIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data
{
    if ([data[@"data"][@"list"] count] > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)manager:(APIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data
{
    return NO;
}

#pragma mark - RTAPIManagerParamSourceDelegate
- (NSDictionary *)paramsForApi:(APIBaseManager *)manager
{   
    return  [NSMutableDictionary dictionaryWithObjectsAndKeys:
             @"2", @"client",
             @"9", @"limit",
             self.page, @"start",nil];
}

#pragma setter&&getter
- (void)setPage:(NSString *)page
{
    _page = page;
}

@end
