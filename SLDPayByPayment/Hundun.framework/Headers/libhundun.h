#ifndef libhundun_h
#define libhundun_h

#include <stdarg.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdlib.h>
#include <Foundation/Foundation.h>
#include <Hundun/Hundun.h>

typedef void (*CredentialExpiredCallback)(void);
typedef void (*NetworkErrorCallback)(NSString *headCode, NSString *responseJson);
typedef HundunResult<NSString *, NSString *>* (*NativeSignCallback)(NSString *source);
typedef HundunResult<NSString *, NSString *>* (*NativeEncryptCallback)(NSString *source);


/// Initialize Hundun SDK
///
/// It can be only successfully invoked once
HundunResult<HundunError *, NSString *> *hundun_init_initialize(
    NSString *argJson,
    CredentialExpiredCallback credentialExpiredCallback,
    NetworkErrorCallback  networkErrorCallback,
    NativeSignCallback  nativeSignCallback,
    NativeEncryptCallback nativeEncryptCallback
);

//HundunResult<HundunError *, HundunVoid *> *hundun_init_setEnvContentLanguage(NSString *argJson);

#endif
