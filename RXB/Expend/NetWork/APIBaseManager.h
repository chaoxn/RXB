//
//  APIBaseManager.h
//  RXB
//
//  Created by fizz on 16/5/6.
//  Copyright © 2016年 chaox. All rights reserved.
//

#import <Foundation/Foundation.h>

@class APIBaseManager;

//api回调
@protocol APIManagerApiCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(APIBaseManager *)manager;
- (void)managerCallAPIDidFailed:(APIBaseManager *)manager;

@end

//负责重新组装API数据的对象
@protocol APIManagerCallbackDataReformer <NSObject>
@required
- (id)manager:(APIBaseManager *)manager reformData:(NSDictionary *)data;
@end

//让manager能够获取调用API所需要的数据
@protocol APIManagerParamSourceDelegate <NSObject>
@required
- (NSDictionary *)paramsForApi:(APIBaseManager *)manager;
@end

//验证器，用于验证API的返回或者调用API的参数是否正确
@protocol APIManagerValidator <NSObject>
@required
/*
 所有的callback数据都应该在这个函数里面进行检查，事实上，到了回调delegate的函数里面是不需要再额外验证返回数据是否为空的。
 因为判断逻辑都在这里做掉了。
 而且本来判断返回数据是否正确的逻辑就应该交给manager去做，不要放到回调到controller的delegate方法里面去做。
 */
- (BOOL)manager:(APIBaseManager *)manager isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)manager:(APIBaseManager *)manager isCorrectWithParamsData:(NSDictionary *)data;
@end

/*
 当产品要求返回数据不正确或者为空的时候显示一套UI，请求超时和网络不通的时候显示另一套UI时，使用这个enum来决定使用哪种UI。
 不应该在回调数据验证函数里面设置这些值，事实上，在任何派生的子类里面你都不应该自己设置manager的这个状态，baseManager已经帮你搞定了。
 强行修改manager的这个状态有可能会造成程序流程的改变，容易造成混乱。
 */
typedef NS_ENUM (NSUInteger, APIManagerErrorType){
    APIManagerErrorTypeDefault,       //没有产生过API请求，这个是manager的默认状态。
    APIManagerErrorTypeSuccess,       //API请求成功且返回数据正确，此时manager的数据是可以直接拿来使用的。
    APIManagerErrorTypeNoContent,     //API请求成功但返回数据不正确。如果回调数据验证函数返回值为NO，manager的状态就会是这个。
    APIManagerErrorTypeParamsError,   //参数错误，此时manager不会调用API，因为参数验证是在调用API之前做的。
    APIManagerErrorTypeTimeout,       //请求超时。RTApiProxy设置的是20秒超时，具体超时时间的设置请自己去看RTApiProxy的相关代码。
    APIManagerErrorTypeNoNetWork      //网络不通。在调用API之前会判断一下当前网络是否通畅，这个也是在调用API之前验证的，和上面超时的状态是有区别的。
};

typedef NS_ENUM (NSUInteger, APIManagerRequestType){
    APIManagerRequestTypeGet,
    APIManagerRequestTypePost,
    APIManagerRequestTypeRestGet,
    APIManagerRequestTypeRestPost
};

@protocol APIManager <NSObject>

@required
- (NSString *)methodName;
//- (NSString *)serviceType;
- (APIManagerRequestType)requestType;

@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (BOOL)shouldCache;

@end

@interface APIBaseManager : NSObject

@property (nonatomic, weak) id<APIManagerApiCallBackDelegate> delegate;
@property (nonatomic, weak) id<APIManagerParamSourceDelegate> paramSource;
@property (nonatomic, weak) id<APIManagerValidator> validator;
@property (nonatomic, weak) NSObject<APIManager> *child; //里面会调用到NSObject的方法，所以这里不用id

/*
 baseManager是不会去设置errorMessage的，派生的子类manager可能需要给controller提供错误信息。所以为了统一外部调用的入口，设置了这个变量。
 派生的子类需要通过extension来在保证errorMessage在对外只读的情况下使派生的manager子类对errorMessage具有写权限。
 */
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) APIManagerErrorType errorType;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (id)fetchDataWithReformer:(id<APIManagerCallbackDataReformer>)reformer;

//尽量使用loadData这个方法,这个方法会通过param source来获得参数，这使得参数的生成逻辑位于controller中的固定位置
- (void)loadData;

//- (void)cancelAllRequests;
//- (void)cancelRequestWithRequestId:(NSInteger)requestID;

@end
