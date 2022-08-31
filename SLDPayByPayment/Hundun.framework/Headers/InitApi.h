//
// Created by Zenas Song on 2021/8/29.
//

#import <Foundation/Foundation.h>
#import <Hundun/HundunVoid.h>
#import <Hundun/HundunRuntimeInfo.h>
#import <Hundun/libhundun.h>

@interface InitApi : NSObject

+ (void)initializeHundunWithArgJson:(HundunRuntimeInfo *)arg
                            success:(void(^)(HundunVoid *obj))success
                            failure:(void(^)(HundunError *obj))failure
          credentialExpiredCallback:(CredentialExpiredCallback)credentialExpiredCallback
               networkErrorCallback:(NetworkErrorCallback)networkErrorCallback
                 nativeSignCallback:(NativeSignCallback)nativeSignCallback
              nativeEncryptCallback:(NativeEncryptCallback)nativeEncryptCallback;

//+ (void)setEnvContentLanguage:(NSString *)lan
//                      success:(void(^)(HundunVoid *obj))success
//                      failure:(void(^)(HundunError *obj))failure;

@end
