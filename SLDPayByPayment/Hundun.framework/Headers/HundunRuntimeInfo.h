//
// Created by Zenas Song on 2021/7/4.
//

#import <Foundation/Foundation.h>
#import <Hundun/HundunBaseObject.h>

@interface HundunRuntimeInfo : HundunBaseObject
@property(nonatomic, copy) NSString *serverEnv;
//@property(nonatomic, copy) NSString *storePath;
@property(nonatomic, copy) NSString *appId;
@property(nonatomic, copy) NSString *appVersion;
@property(nonatomic, copy) NSString *sdkVersion;
@property(nonatomic, copy) NSString *platform;
@property(nonatomic, copy) NSString *contentLanguage;
@property(nonatomic, copy) NSString *deviceModel;
@property(nonatomic, copy) NSString *operateSystem;
@property(nonatomic, copy) NSString *operateSystemVersion;
@property(nonatomic, copy) NSString *screenRatio;
@property(nonatomic, copy) NSString *screenWidth;
@property(nonatomic, copy) NSString *screenHeight;
@property(nonatomic, copy) NSString *rootFlag;
@property(nonatomic, copy) NSString *deviceId;
@end
