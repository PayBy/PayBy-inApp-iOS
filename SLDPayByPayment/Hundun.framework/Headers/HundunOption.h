//
//  HundunOption.h
//
//  Created by Zenas Song on 2021/7/3.
//

#ifndef HundunOption_h
#define HundunOption_h


#endif /* HundunOption_h */

@interface HundunOption<T> : NSObject

/// Factory method to create some value;
+ (instancetype)some:(T)value;

/// Factory method to create none value;
+ (instancetype)none;

/// Factory method to lift a nullable value to option;
+ (instancetype)lift:(T)value;

/// Flatten a double-layer option value into a simple option value;
+ (instancetype)flatten:(HundunOption<HundunOption<T> *> *)optionOfOption;

/// Detect this option is some or not;
- (BOOL)isSome;

/// Detect this option is none or not;
- (BOOL)isNone;

/// get value unsafely, if this option is none, an NPE exception will be thrown;
- (T)unsafeGetValue;

/// get value safely with a default value, if this options' value is null, the default value will be returned;
- (T)getOrElse:(T)defaultValue;

/// execute an effect block, if this option's value is none, nothing will happen;
- (void)foreach:(void (^)(T value))block;

@end

@interface HundunOptionMapper<Input, Output> : NSObject
- (HundunOption<Output> *)map:(HundunOption<Input> *)option withBlock:(Output (^)(Input obj))block;
@end

@interface HundunOptionFlatMapper<Input, Output> : NSObject
- (HundunOption<Output> *)flatMap:(HundunOption<Input> *)option withBlock:(HundunOption<Output> *(^)(Input obj))block;
@end