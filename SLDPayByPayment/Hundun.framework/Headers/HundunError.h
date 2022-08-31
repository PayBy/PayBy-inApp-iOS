//
// Created by Zenas Song on 2021/7/3.
//

#ifndef HundunError_h
#define HundunError_h

#endif

#import <Foundation/Foundation.h>
#import <Hundun/HundunOption.h>

@interface HundunError : NSObject
+(instancetype) initWithTraceCode: (HundunOption<NSString*> *)traceCode
                             code: (HundunOption<NSString*> *)code
                          message: (HundunOption<NSString*> *)message
                          riskUrl: (HundunOption<NSString*> *)riskUrl;

- (HundunOption<NSString *> *) traceCode;
- (HundunOption<NSString *> *) code;
- (HundunOption<NSString *> *) message;
- (HundunOption<NSString *> *) riskUrl;
- (NSString *) show;
- (NSString *) getCode;
- (NSString *) getRiskUrl;
- (NSString *) getMessage;
- (NSString *) getTraceCode;
@end
