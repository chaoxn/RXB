//
//  FindVC.m
//  RXB
//
//  Created by fizz on 16/5/5.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import "FindVC.h"
#import "FindReformer.h"
#import "FindApiManager.h"

@interface FindVC ()<APIManagerApiCallBackDelegate>

@property (nonatomic, strong)FindApiManager *findApi;
@property (nonatomic, strong) id<APIManagerCallbackDataReformer> storeReformer;

@end

@implementation FindVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    self.findApi.page = @"19";
    
    [self.findApi loadData];
    
}

- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager
{
    id data = [manager fetchDataWithReformer:self.storeReformer];
    if ([manager isKindOfClass:[FindApiManager class]]) {
        
        DLog(@"----------------------%@-----------------", data);
    }
}

- (void)managerCallAPIDidFailed:(APIBaseManager *)manager
{
    
}

- (id<APIManagerCallbackDataReformer>)storeReformer {
    if (!_storeReformer) {
        _storeReformer = [[FindReformer alloc]init];
    }
    return _storeReformer;
}

- (FindApiManager *)findApi
{
    if (!_findApi) {
        _findApi = [[FindApiManager alloc]init];
        _findApi.delegate = self;
    }
    return _findApi;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
