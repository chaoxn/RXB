//
//  FindApiManager.h
//  RXB
//
//  Created by fizz on 16/5/9.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindApiManager : APIBaseManager<APIManager,APIManagerParamSourceDelegate,APIManagerApiCallBackDelegate,APIManagerValidator>

@property (nonatomic, strong) NSString *page;

@end
