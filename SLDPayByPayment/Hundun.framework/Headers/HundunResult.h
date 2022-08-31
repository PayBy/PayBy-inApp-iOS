//
//  result.h
//  octest
//
//  Created by Zenas Song on 2021/7/3.
//

#ifndef result_h
#define result_h


#endif /* result_h */

#import <Hundun/HundunOption.h>

@interface HundunResult<L, R> : NSObject

/// Factory method to create a left instance;
+ (instancetype)left:(L)leftValue;

/// Factory method to create a right instance;
+ (instancetype)right:(R)rightValue;

/// Detect this result is on left;
- (BOOL)isLeft;

/// Detect this result is on left;
- (BOOL)isRight;

/// Get left value;
- (HundunOption<L> *)leftValue;

/// Get right value;
- (HundunOption<R> *)rightValue;

/// a convenient method to get left value unsafely
- (L)unsafeGetLeftValue;

/// a convenient method to get right value unsafely
- (R)unsafeGetRightValue;

/// flatten a double-layer result into a simple one
+ (instancetype)flatten:(HundunResult<L, HundunResult<L, R> *> *)result;

@end

@interface HundunResultMapper<Left, InputR, OutputR> : NSObject
- (HundunResult<Left, OutputR> *)map:(HundunResult<Left, InputR> *)result withBlock:(OutputR (^)(InputR obj))block;
@end

@interface HundunResultFlatMapper<Left, InputR, OutputR> : NSObject
- (HundunResult<Left, OutputR> *)flatMap:(HundunResult<Left, InputR> *)result withBlock:(HundunResult<Left, OutputR> *(^)(InputR obj))block;
@end


@interface HundunResultLeftMapper<InputL, OutputL, Right> : NSObject
- (HundunResult<OutputL, Right> *)mapLeft:(HundunResult<InputL, Right> *)result withBlock:(OutputL (^)(InputL obj))block;
@end