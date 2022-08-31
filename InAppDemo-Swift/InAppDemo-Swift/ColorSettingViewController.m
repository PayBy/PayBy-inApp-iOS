//
//  ColorSettingViewController.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/15.
//

#import "ColorSettingViewController.h"
#import "SettingViewController.h"

@interface ColorSettingViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *lightColorTextField;
@property (weak, nonatomic) IBOutlet UIView *lightColorDisplayView;
@property (weak, nonatomic) IBOutlet UITextField *darkColorTextField;
@property (weak, nonatomic) IBOutlet UIView *darkColorDisplayView;
@end

@implementation ColorSettingViewController

- (instancetype)init {
    if (self = [super init]) {
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ColorSettingViewController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonAction)];
    
    self.lightColorTextField.text = self.colorDict[@"lightColor"];
    self.lightColorTextField.delegate = self;
    self.lightColorDisplayView.backgroundColor = colorWithHexString(self.colorDict[@"lightColor"]);
    self.darkColorTextField.text = self.colorDict[@"darkColor"];
    self.darkColorTextField.delegate = self;
    self.darkColorDisplayView.backgroundColor = colorWithHexString(self.colorDict[@"darkColor"]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:[string uppercaseString]];
    return NO;
}

- (void)saveButtonAction {
    [self.view endEditing:YES];
    
    NSString *lightHexStr = [[self.lightColorTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    NSString *darkHexStr = [[self.darkColorTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if (![lightHexStr hasPrefix:@"#"] ||
        ![darkHexStr hasPrefix:@"#"]) {
        [self showAlertWithMessage:@"Please enter # to start hexadecimal color"];
        return;
    }
    
    if (lightHexStr.length != 7 ||
        darkHexStr.length != 7) {
        [self showAlertWithMessage:@"Please enter a 6-digit hexadecimal color"];
        return;
    }
    
//    self.lightColorDisplayView.backgroundColor = colorWithHexString(lightHexStr);
//    self.darkColorDisplayView.backgroundColor = colorWithHexString(darkHexStr);
    
    if (self.saveColorSettingHandler) {
        self.saveColorSettingHandler(lightHexStr, darkHexStr);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)previewButtonAction:(id)sender {
    NSString *lightHexStr = [[self.lightColorTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    NSString *darkHexStr = [[self.darkColorTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    if (![lightHexStr hasPrefix:@"#"] ||
        ![darkHexStr hasPrefix:@"#"]) {
        [self showAlertWithMessage:@"Please enter # to start hexadecimal color"];
        return;
    }
    
    if (lightHexStr.length != 7 ||
        darkHexStr.length != 7) {
        [self showAlertWithMessage:@"Please enter a 6-digit hexadecimal color"];
        return;
    }
    
    self.lightColorDisplayView.backgroundColor = colorWithHexString(lightHexStr);
    self.darkColorDisplayView.backgroundColor = colorWithHexString(darkHexStr);
}

@end
