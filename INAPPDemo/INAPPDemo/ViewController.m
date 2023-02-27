//
//  ViewController.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/1.
//

#import "ViewController.h"
#import "PlaceOrderViewController.h"
#import "SettingViewController.h"
#import "GPBRSA.h"
#import "GlobalDefines.h"
#import "HttpManager.h"
#import <SLDPayByPayment/SLDPayByPayment.h>
#import <Masonry/Masonry.h>
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *tokenBgView;
@property (weak, nonatomic) IBOutlet UITextField *tokenTextField;
@property (weak, nonatomic) IBOutlet UIView *appIdBgView;
@property (weak, nonatomic) IBOutlet UITextField *appIdTextField;
@property (weak, nonatomic) IBOutlet UIView *partnerIdBgView;
@property (weak, nonatomic) IBOutlet UITextField *partnerIdTextField;
@property (weak, nonatomic) IBOutlet UIView *deviceIdBgView;
@property (weak, nonatomic) IBOutlet UITextField *deviceIdTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Setting" style:UIBarButtonItemStylePlain target:self action:@selector(settingButtonAction)];
    
    self.tokenBgView.layer.cornerRadius = 4;
    self.tokenBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.tokenBgView.layer.borderWidth = 1;
    self.appIdBgView.layer.cornerRadius = 4;
    self.appIdBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.appIdBgView.layer.borderWidth = 1;
    self.partnerIdBgView.layer.cornerRadius = 4;
    self.partnerIdBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.partnerIdBgView.layer.borderWidth = 1;
    self.deviceIdBgView.layer.cornerRadius = 4;
    self.deviceIdBgView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.deviceIdBgView.layer.borderWidth = 1;
    
    self.tokenTextField.text = @"02c084e52e9740e693e6a9ac9d6801f8";
    self.appIdTextField.text = [GlobalDefines appId];
    self.appIdTextField.enabled = NO;
    self.partnerIdTextField.text = [GlobalDefines partnerId];
    self.partnerIdTextField.enabled = NO;
    self.deviceIdTextField.text = @"deviceId123";
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (IBAction)paymentButtonAction:(id)sender {
    [self.view endEditing:YES];
    NSString *sign = [NSString stringWithFormat:@"iapAppId=%@&iapDeviceId=%@&iapPartnerId=%@&token=%@", self.appIdTextField.text, self.deviceIdTextField.text, self.partnerIdTextField.text, self.tokenTextField.text];
    [SLDPayByPaymentInterface paymentInViewController:self withToken:self.tokenTextField.text sign:[GPBRSA encryptString:sign privateKey:[GlobalDefines privateKey]] deviceId:self.deviceIdTextField.text resultCallback:^(NSString * _Nonnull result) {
        NSLog(@"resultCallback: %@", result);
        if ([SLDPayByPaymentConfig defaultConfig].useDefaultResultPage == NO) {
            [self showAlertWithMessage:result];
        }
        
        if ([result isEqualToString:SLDPayByPaymentResultSuccess]) {
            // Do something
        } else if ([result isEqualToString:SLDPayByPaymentResultFail]) {
            // Do something
        } else if ([result isEqualToString:SLDPayByPaymentResultPaying]) {
            // Do something
        } else if ([result isEqualToString:SLDPayByPaymentResultCancel]) {
            // Do something
        }
    }];
}

- (IBAction)placeOrderAction:(id)sender {
    PlaceOrderViewController *vc = [[PlaceOrderViewController alloc] init];
    __weak typeof(self) weakSelf = self;
    vc.confirmHandler = ^(NSString * _Nonnull amount, NSString * _Nonnull subject, NSString * _Nullable customerId) {
        NSString *merchantOrderNo = [NSString stringWithFormat:@"M%.6d%.6d", arc4random_uniform(999999), arc4random_uniform(999999)];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"requestTime"] = @(floor([[NSDate date] timeIntervalSince1970] * 1000));
        
        NSMutableDictionary *paySceneParams = [NSMutableDictionary dictionary];
        paySceneParams[@"appId"] = [GlobalDefines appId];
        paySceneParams[@"iapDeviceId"] = weakSelf.deviceIdTextField.text;
        if (customerId.length > 0) {
            paySceneParams[@"customerId"] = customerId;
        }
        
        params[@"bizContent"] = @{
            @"merchantOrderNo": merchantOrderNo,
            @"subject": subject,
            @"totalAmount": @{
                @"currency": @"AED",
                @"amount": amount
            },
            @"paySceneCode": @"INAPP",
            @"paySceneParams": paySceneParams
        };

        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
        NSString *sign = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        [MBProgressHUD showHUDAddedTo:weakSelf.view animated:YES];
        [[HttpManager sharedManager] setValue:[GlobalDefines partnerId] forHTTPHeaderField:@"Partner-Id"];
        [[HttpManager sharedManager] setValue:[GPBRSA encryptString:sign privateKey:[GlobalDefines privateKey]] forHTTPHeaderField:@"sign"];
        [[HttpManager sharedManager] POST:[GlobalDefines placeOrderUrl] parameters:params success:^(id  _Nullable responseObject) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            NSString *tokenUrl = responseObject[@"body"][@"interActionParams"][@"tokenUrl"];
            if (tokenUrl) {
                weakSelf.tokenTextField.text = tokenUrl;
                [weakSelf paymentButtonAction:nil];
            }
        } failure:^(NSError * _Nonnull error) {
            [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
            [weakSelf showAlertWithMessage:error.localizedFailureReason];
        }];
    };
    [self presentViewController:vc animated:NO completion:nil];
}

- (void)settingButtonAction {
    SettingViewController *vc = [[SettingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end
