//
//  HundunBaseObject.h
//  Hundun
//
//  Created by 叶志巧 on 2021/10/19.
//
/*
 inspiration: https://github.com/ijoyc/CYZBaseModel
 */
#import <Foundation/Foundation.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface HundunBaseObject : NSObject <NSCoding>
/**
 *  哪个子类调用，就返回哪个子类的对象数组，根据传入的包含对象字典的数组来为每个对象赋值
 *  特定属性名称的映射关系可以通过attributeMapDictionary方法指定。
 *
 *  @param jsonArray 对象字典的数组。格式：@[@{name = ..., passwd = ...}, @{...}, ...]
 *
 *  @return 调用类的实例变量的数组。
 */
+ (NSArray *)objectArrayWithJsonArray:(NSArray *)jsonArray;

/**
 *  哪个子类调用，就返回哪个子类的对象数组。根据传入的json字符串（数组型）为每个对象赋值。
 *  特定属性名称的映射关系可以通过attributeMapDictionary方法指定。
 *
 *  @param jsonString json字符串
 *
 *  @return 调用类的实例变量的数组。
 */
+ (NSArray *)objectArrayWithJsonString:(NSString *)jsonString;

/**
 *  哪个类调用，就返回哪个类的对象数组对应的json数组。
 *
 *  @param objectArray 对象数组
 *
 *  @return json数组
 */
+ (NSArray *)jsonArrayWithObjectArray:(NSArray *)objectArray;

/**
 *  哪个类调用，就返回哪个类对象数组对应的json字符串。
 *
 *  @param objectArray 对象数组
 *
 *  @return json字符串
 */
+ (NSString *)jsonStringWithObjectArray:(NSArray *)objectArray;

/**
 *初始化方法，将传入字典的key对应的value赋值给Model对象中相应地属性。
 *@param aDict a Dictionary 该字典的key与attributeMapDictionary方法返回的字典的value同名，该字典的value为欲为属性赋的值
 *@return 返回实例变量
 */
- (id)initWithDict:(NSDictionary *)aDict;

/**
 *  初始化方法，传入json字符串，根据json字符串中的键值关系为对象相应属性赋值
 *  其映射关系可以在attributeMapDictionary中修改
 *
 *  @param json json字符串
 *
 *  @return 实例变量
 */
- (id)initWithJsonString:(NSString *)json;

/**
 *子类需要重写的方法，用以创建映射字典。
 *在该方法中将属性名称作为key值，与初始化时传入字典的key同名的字符串作为value。
 *若不重写，则返回nil,此时默认映射字典的key=value=初始化时传入字典的key同名的字符串。
 *@return 返回一个映射字典,或者nil(如果子类不重写)
 */
- (NSDictionary *)attributeMapDictionary;

/**
 *  子类需要重写的方法，用与字典中包含数组，并且数组中包含自定义对象时。
 *  如果不重写该方法，则创建的对象中数组类型的属性为空。
 *  自定义对象写自定义对象的类名
 *  字符串写@“NSString”
 *  数值型一律写成@“NSNumber”
 *  格式：@{"mapped-property-name": @"NSString"}
 *
 *  @return 映射字典
 */
- (NSDictionary *)objectClassesInArray;

/**
 *  默认情况下当遇到NSNull对象时会将其转换为@""空字符串
 *  如果某些属性不需要这样的转换，可以将属性名字写在该方法返回的数组中
 *
 *  @return 不需要进行空值转换的属性名的数组
 */
- (NSArray *)attributesWithoutConvertNull;

/**
 *为实例变量赋以新的属性映射字典。
 *@param aDict a Dictionary 新的属性映射字典
 */
- (void)setAttributesDictionary:(NSDictionary *)aDict;

/**
 *  将自定义的对象转换成字典对象，属性名为键，属性值为值。
 */
- (NSDictionary *)dictionaryRepresentation;

/**
 *  将自定义对象转换成json字符串
 */
- (NSString *)jsonStringRepresentation;
/**
 枚举对象，返回属性字段名称
 */
- (NSString *)getValuedKey;
@end

NS_ASSUME_NONNULL_END
