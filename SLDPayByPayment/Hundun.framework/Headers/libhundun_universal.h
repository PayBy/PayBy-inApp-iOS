//
//  libhundun_txn.h
//  hundun
//
//  Created by wujiangding on 2021/9/23.
//

#ifndef libhundun_txn_h
#define libhundun_txn_h

#include <Hundun/Hundun.h>

void hundun_misc_setNetworkHeader(NSString *key, NSString *value);

HundunResult<HundunError *, NSString *> *hundun_universal_post(NSString * args);
HundunResult<HundunError *, NSString *> *hundun_universal_getSalt(void);
HundunResult<HundunError *, NSString *> *hundun_universal_rsaEncrypt(NSString * args);

#endif /* libhundun_txn_h */
