//
//  SettingViewController.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/12.
//

#import "SettingViewController.h"
#import "ColorSettingViewController.h"
#import "AppDelegate.h"
#import "CustomNavigationController.h"
#import <Masonry/Masonry.h>
#import <SLDPayByPayment/SLDPayByPayment.h>

static inline NSUInteger hexStrToInt(NSString *str) {
    uint32_t result = 0;
    sscanf([str UTF8String], "%X", &result);
    return result;
}

static BOOL hexStrToRGBA(NSString *str,
                         CGFloat *r, CGFloat *g, CGFloat *b, CGFloat *a) {
    str = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if ([str hasPrefix:@"#"]) {
        str = [str substringFromIndex:1];
    } else if ([str hasPrefix:@"0X"]) {
        str = [str substringFromIndex:2];
    }
    
    NSUInteger length = [str length];
    //         RGB            RGBA          RRGGBB        RRGGBBAA
    if (length != 3 && length != 4 && length != 6 && length != 8) {
        return NO;
    }
    
    //RGB,RGBA,RRGGBB,RRGGBBAA
    if (length < 5) {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 1)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(1, 1)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(2, 1)]) / 255.0f;
        if (length == 4)  *a = hexStrToInt([str substringWithRange:NSMakeRange(3, 1)]) / 255.0f;
        else *a = 1;
    } else {
        *r = hexStrToInt([str substringWithRange:NSMakeRange(0, 2)]) / 255.0f;
        *g = hexStrToInt([str substringWithRange:NSMakeRange(2, 2)]) / 255.0f;
        *b = hexStrToInt([str substringWithRange:NSMakeRange(4, 2)]) / 255.0f;
        if (length == 8) *a = hexStrToInt([str substringWithRange:NSMakeRange(6, 2)]) / 255.0f;
        else *a = 1;
    }
    return YES;
}

UIColor * colorWithHexString(NSString *hexStr) {
    CGFloat r, g, b, a;
    if (hexStrToRGBA(hexStr, &r, &g, &b, &a)) {
        return [UIColor colorWithRed:r green:g blue:b alpha:a];
    }
    return nil;
}

@interface SettingItem : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy, nullable) NSString *content;
@property (nonatomic, copy, nullable) NSDictionary *colorDict;
@end

@implementation SettingItem

@end

@interface SettingColorView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *colorLabel;
@property (nonatomic, strong) UIView *displayView;
@end

@implementation SettingColorView

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self p_initSubviews];
        [self p_initLayouts];
    }
    return self;
}

#pragma mark - Private

- (void)p_initSubviews {
    [self addSubview:self.titleLabel];
    [self addSubview:self.colorLabel];
    [self addSubview:self.displayView];
}

- (void)p_initLayouts {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.centerY.mas_equalTo(0);
    }];
    
    [self.displayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.centerY.mas_equalTo(0);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.colorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.displayView.mas_leading).offset(-5);
        make.centerY.mas_equalTo(0);
    }];
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - Getter/Setter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = [UIColor lightGrayColor];
        _titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightBold];
    }
    return _titleLabel;
}

- (UILabel *)colorLabel {
    if (!_colorLabel) {
        _colorLabel = [UILabel new];
        _colorLabel.textColor = [UIColor lightGrayColor];
        _colorLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    }
    return _colorLabel;
}

- (UIView *)displayView {
    if (!_displayView) {
        _displayView = [UIView new];
    }
    return _displayView;
}

@end

@interface SettingCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) SettingColorView *lightColorView;
@property (nonatomic, strong) SettingColorView *darkColorView;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) SettingItem *item;
@end

@implementation SettingCell

#pragma mark - Life Cycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self p_initSubviews];
        [self p_initLayouts];
    }
    return self;
}

#pragma mark - Private

- (void)p_initSubviews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.lightColorView];
    [self.contentView addSubview:self.darkColorView];
}

- (void)p_initLayouts {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(16);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(self.arrowImageView.mas_leading).offset(-10);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-16);
        make.centerY.mas_equalTo(0);
    }];
    
    [self.lightColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8);
        make.leading.mas_equalTo(16);
        make.height.mas_equalTo(30);
    }];
    
    [self.darkColorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8);
        make.trailing.mas_equalTo(-32);
        make.leading.mas_equalTo(self.lightColorView.mas_trailing).offset(16);
        make.width.height.mas_equalTo(self.lightColorView);
    }];
}

#pragma mark - Public

#pragma mark - Event

#pragma mark - Getter/Setter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.font = [UIFont systemFontOfSize:16 weight:UIFontWeightBold];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [UILabel new];
        _contentLabel.textColor = [UIColor lightGrayColor];
        _contentLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightBold];
    }
    return _contentLabel;
}

- (SettingColorView *)lightColorView {
    if (!_lightColorView) {
        _lightColorView = [[SettingColorView alloc] initWithFrame:CGRectZero];
        _lightColorView.titleLabel.text = @"Light Color";
        _lightColorView.hidden = YES;
    }
    return _lightColorView;
}

- (SettingColorView *)darkColorView {
    if (!_darkColorView) {
        _darkColorView = [[SettingColorView alloc] initWithFrame:CGRectZero];
        _darkColorView.titleLabel.text = @"Dark Color";
        _darkColorView.hidden = YES;
    }
    return _darkColorView;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        UIImage *image = [UIImage imageNamed:@"arrow_gray_right"];
        if ([UIView appearance].semanticContentAttribute == UISemanticContentAttributeForceRightToLeft) {
            image = [UIImage imageWithCGImage:image.CGImage scale:image.scale orientation:UIImageOrientationUpMirrored];
        }
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
    }
    return _arrowImageView;
}

- (void)setItem:(SettingItem *)item {
    _item = item;
    self.titleLabel.text = item.title;
    if (item.colorDict.count) {
        _lightColorView.hidden = NO;
        _darkColorView.hidden = NO;
        _contentLabel.hidden = YES;
        _lightColorView.colorLabel.text = item.colorDict[@"lightColor"];
        _lightColorView.displayView.backgroundColor = colorWithHexString(item.colorDict[@"lightColor"]);
        _darkColorView.colorLabel.text = item.colorDict[@"darkColor"];
        _darkColorView.displayView.backgroundColor = colorWithHexString(item.colorDict[@"darkColor"]);
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16);
            make.top.mas_equalTo(16);
        }];
    } else if (item.content) {
        _lightColorView.hidden = YES;
        _darkColorView.hidden = YES;
        _contentLabel.hidden = NO;
        self.contentLabel.text = item.content;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(16);
            make.centerY.mas_equalTo(0);
        }];
    }
}

@end

static NSString *kStorePath;
static NSMutableDictionary *kSettingDict;

@interface SettingViewController ()
@property (nonatomic, copy) NSArray<SettingItem *> *items;
@end

@implementation SettingViewController

+ (void)initSetting {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    kStorePath = [[paths firstObject] stringByAppendingPathComponent:@"setting.plist"];
    kSettingDict = [NSMutableDictionary dictionaryWithContentsOfFile:kStorePath];
    if (kSettingDict == nil) {
        NSDictionary *settingDict = @{
            @"Language": @"en",
            @"UserInterfaceStyle": @"Unspecified",
            @"PaymentMethodMenuColor": @{
                @"lightColor": @"#000000",
                @"darkColor": @"#FFFFFF",
            },
            @"PaymentMethodTextColor": @{
                @"lightColor": @"#FFFFFF",
                @"darkColor": @"#303030",
            },
            @"PrimaryColor": @{
                @"lightColor": @"#00A75D",
                @"darkColor": @"#00A75D",
            },
            @"UseDefaultResultPage": @"Y",
            @"AppPayUseQrCode": @"N",
        };
        kSettingDict = [settingDict mutableCopy];
        [kSettingDict writeToFile:kStorePath atomically:NO];
    }
    
    if ([kSettingDict[@"Language"] isEqualToString:@"ar"]) {
        [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageAr];
        [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
        [UINavigationBar appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    } else {
        [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageEn];
        [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
        [UINavigationBar appearance].semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
    }
    
    NSString *userInterfaceStyle = kSettingDict[@"UserInterfaceStyle"];
    if ([userInterfaceStyle isEqualToString:@"Light"]) {
        [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleLight];
    } else if ([userInterfaceStyle isEqualToString:@"Dark"]) {
        [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleDark];
    } else {
        [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleUnspecified];
    }
    
    SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig new];
    config.paymentMethodMenuColor = [SLDPayByPaymentColor colorWithLightColor:colorWithHexString(kSettingDict[@"PaymentMethodMenuColor"][@"lightColor"]) darkColor:colorWithHexString(kSettingDict[@"PaymentMethodMenuColor"][@"darkColor"])];
    config.paymentMethodTextColor = [SLDPayByPaymentColor colorWithLightColor:colorWithHexString(kSettingDict[@"PaymentMethodTextColor"][@"lightColor"]) darkColor:colorWithHexString(kSettingDict[@"PaymentMethodTextColor"][@"darkColor"])];
    config.primaryColor = [SLDPayByPaymentColor colorWithLightColor:colorWithHexString(kSettingDict[@"PrimaryColor"][@"lightColor"]) darkColor:colorWithHexString(kSettingDict[@"PrimaryColor"][@"darkColor"])];
    config.appPayUseQrCode = [kSettingDict[@"AppPayUseQrCode"] isEqualToString:@"Y"];
    config.useDefaultResultPage = [kSettingDict[@"UseDefaultResultPage"] isEqualToString:@"Y"];
    [SLDPayByPaymentInterface updateConfig:config];
}

- (instancetype)init {
    if (self = [super init]) {
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SettingViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Setting";
    [self.tableView registerClass:[SettingCell class] forCellReuseIdentifier:@"SettingCell"];

    SettingItem *languageItem = [SettingItem new];
    languageItem.title = @"Language";
    languageItem.content = kSettingDict[languageItem.title];
    SettingItem *userInterfaceStyleItem = [SettingItem new];
    userInterfaceStyleItem.title = @"UserInterfaceStyle";
    userInterfaceStyleItem.content = kSettingDict[userInterfaceStyleItem.title];
    SettingItem *paymentMethodMenuColorItem = [SettingItem new];
    paymentMethodMenuColorItem.title = @"PaymentMethodMenuColor";
    paymentMethodMenuColorItem.colorDict = kSettingDict[paymentMethodMenuColorItem.title];
    SettingItem *paymentMethodTextColorItem = [SettingItem new];
    paymentMethodTextColorItem.title = @"PaymentMethodTextColor";
    paymentMethodTextColorItem.colorDict = kSettingDict[paymentMethodTextColorItem.title];
    SettingItem *primaryColorItem = [SettingItem new];
    primaryColorItem.title = @"PrimaryColor";
    primaryColorItem.colorDict = kSettingDict[primaryColorItem.title];
    SettingItem *useDefaultResultPageItem = [SettingItem new];
    useDefaultResultPageItem.title = @"UseDefaultResultPage";
    useDefaultResultPageItem.content = kSettingDict[useDefaultResultPageItem.title];
    SettingItem *appPayUseQrCodeItem = [SettingItem new];
    appPayUseQrCodeItem.title = @"AppPayUseQrCode";
    appPayUseQrCodeItem.content = kSettingDict[appPayUseQrCodeItem.title];
    self.items = @[
        languageItem,
        userInterfaceStyleItem,
        paymentMethodMenuColorItem,
        paymentMethodTextColorItem,
        primaryColorItem,
        useDefaultResultPageItem,
        appPayUseQrCodeItem,
    ];
}

- (void)showActionSheetWithTitle:(NSString *)title actionTitles:(NSArray<NSString *> *)actionTitles atIndexPath:(NSIndexPath *)indexPath selectCallback:(void(^)(NSString *actionTitle))selectCallback {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    for (NSString *actionTitle in actionTitles) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:actionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (selectCallback) {
                selectCallback(action.title);
            }
        }];
        [alertController addAction:action];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad ||
        [[UIDevice currentDevice].model isEqualToString:@"iPad"]) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        CGRect rect = [cell.superview convertRect:cell.frame toView:nil];
        alertController.popoverPresentationController.sourceView = cell;
        alertController.popoverPresentationController.sourceRect = CGRectMake(cell.frame.origin.x, 0, cell.frame.size.width, cell.frame.size.height);
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingCell" forIndexPath:indexPath];
    cell.item = self.items[indexPath.item];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingItem *item = self.items[indexPath.item];
    return [item.title hasSuffix:@"Color"] ? 76 : 56;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SettingItem *item = self.items[indexPath.item];
    if ([item.title isEqualToString:@"Language"]) {
        [self showActionSheetWithTitle:item.title actionTitles:@[@"en", @"ar"] atIndexPath:indexPath selectCallback:^(NSString *actionTitle) {
            if ([actionTitle isEqualToString:@"ar"]) {
                [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageAr];
                [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
                [UINavigationBar appearance].semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
            } else {
                [SLDPayByPaymentInterface setLanguage:SLDPayByPaymentLanguageEn];
                [UIView appearance].semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
                [UINavigationBar appearance].semanticContentAttribute = UISemanticContentAttributeForceLeftToRight;
            }
            
            kSettingDict[item.title] = actionTitle;
            [kSettingDict writeToFile:kStorePath atomically:YES];
//            item.content = actionTitle;
//            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController = [[CustomNavigationController alloc] init];
            });
        }];
    } else if ([item.title isEqualToString:@"UserInterfaceStyle"]) {
        [self showActionSheetWithTitle:item.title actionTitles:@[@"Unspecified", @"Light", @"Dark"] atIndexPath:indexPath selectCallback:^(NSString *actionTitle) {
            if ([actionTitle isEqualToString:@"Light"]) {
                [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleLight];
            } else if ([actionTitle isEqualToString:@"Dark"]) {
                [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleDark];
            } else {
                [SLDPayByPaymentInterface setUserInterfaceStyle:SLDPayByPaymentUserInterfaceStyleUnspecified];
            }
            
            kSettingDict[item.title] = actionTitle;
            [kSettingDict writeToFile:kStorePath atomically:NO];
            item.content = actionTitle;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else if ([item.title isEqualToString:@"UseDefaultResultPage"]) {
        [self showActionSheetWithTitle:item.title actionTitles:@[@"Y", @"N"] atIndexPath:indexPath selectCallback:^(NSString *actionTitle) {
            SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
            config.useDefaultResultPage = [actionTitle isEqualToString:@"Y"];
            [SLDPayByPaymentInterface updateConfig:config];
            
            kSettingDict[item.title] = actionTitle;
            [kSettingDict writeToFile:kStorePath atomically:NO];
            item.content = actionTitle;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else if ([item.title isEqualToString:@"AppPayUseQrCode"]) {
        [self showActionSheetWithTitle:item.title actionTitles:@[@"Y", @"N"] atIndexPath:indexPath selectCallback:^(NSString *actionTitle) {
            SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
            config.appPayUseQrCode = [actionTitle isEqualToString:@"Y"];
            [SLDPayByPaymentInterface updateConfig:config];
            
            kSettingDict[item.title] = actionTitle;
            [kSettingDict writeToFile:kStorePath atomically:NO];
            item.content = actionTitle;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
    } else if ([item.title isEqualToString:@"PaymentMethodMenuColor"]) {
        ColorSettingViewController *vc = [[ColorSettingViewController alloc] init];
        vc.title = item.title;
        vc.colorDict = item.colorDict;
        __weak typeof(self) weakSelf = self;
        vc.saveColorSettingHandler = ^(NSString * _Nonnull lightHexStr, NSString * _Nonnull darkHexStr) {
            SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
            config.paymentMethodMenuColor = [SLDPayByPaymentColor colorWithLightColor:colorWithHexString(lightHexStr) darkColor:colorWithHexString(darkHexStr)];
            [SLDPayByPaymentInterface updateConfig:config];
            
            kSettingDict[item.title] =@{
                @"lightColor": lightHexStr,
                @"darkColor": darkHexStr,
            };
            [kSettingDict writeToFile:kStorePath atomically:NO];
            item.colorDict = kSettingDict[item.title];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.title isEqualToString:@"PaymentMethodTextColor"]) {
        ColorSettingViewController *vc = [[ColorSettingViewController alloc] init];
        vc.title = item.title;
        vc.colorDict = item.colorDict;
        __weak typeof(self) weakSelf = self;
        vc.saveColorSettingHandler = ^(NSString * _Nonnull lightHexStr, NSString * _Nonnull darkHexStr) {
            SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
            config.paymentMethodTextColor = [SLDPayByPaymentColor colorWithLightColor:colorWithHexString(lightHexStr) darkColor:colorWithHexString(darkHexStr)];
            [SLDPayByPaymentInterface updateConfig:config];
            
            kSettingDict[item.title] =@{
                @"lightColor": lightHexStr,
                @"darkColor": darkHexStr,
            };
            [kSettingDict writeToFile:kStorePath atomically:NO];
            item.colorDict = kSettingDict[item.title];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([item.title isEqualToString:@"PrimaryColor"]) {
        ColorSettingViewController *vc = [[ColorSettingViewController alloc] init];
        vc.title = item.title;
        vc.colorDict = item.colorDict;
        __weak typeof(self) weakSelf = self;
        vc.saveColorSettingHandler = ^(NSString * _Nonnull lightHexStr, NSString * _Nonnull darkHexStr) {
            SLDPayByPaymentConfig *config = [SLDPayByPaymentConfig defaultConfig];
            config.primaryColor = [SLDPayByPaymentColor colorWithLightColor:colorWithHexString(lightHexStr) darkColor:colorWithHexString(darkHexStr)];
            [SLDPayByPaymentInterface updateConfig:config];
            
            kSettingDict[item.title] =@{
                @"lightColor": lightHexStr,
                @"darkColor": darkHexStr,
            };
            [kSettingDict writeToFile:kStorePath atomically:NO];
            item.colorDict = kSettingDict[item.title];
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
