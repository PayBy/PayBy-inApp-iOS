//
//  PlaceOrderViewController.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/16.
//

#import "PlaceOrderViewController.h"

@interface PlaceOrderViewController ()
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *subjectTextField;
@property (weak, nonatomic) IBOutlet UITextField *customerIdTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYConstraint;
@property (nonatomic, assign, getter=isFirstAppear) BOOL firstAppear;
@end

@implementation PlaceOrderViewController

- (instancetype)init {
    if (self = [super init]) {
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"PlaceOrderViewController"];
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}

- (void)dealloc {
    [self removeObservers];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstAppear = YES;
//    self.cardView.backgroundColor = [UIColor whiteColor];
    self.cardView.layer.cornerRadius = 10;
    self.cardView.layer.masksToBounds = YES;
    self.cardView.alpha = 0;
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    self.amountTextField.keyboardType = UIKeyboardTypeDecimalPad;
    [self addObservers];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (self.isFirstAppear) {
        self.firstAppear = NO;
        [UIView animateWithDuration:0.25 animations:^{
            self.cardView.alpha = 1;
            self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
        }];
    }
}

- (void)dismissWithCompletion: (void (^ __nullable)(void))completion {
    [UIView animateWithDuration:0.25 animations:^{
        self.cardView.alpha = 0;
        self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0];
    } completion:^(BOOL finished) {
        [self dismissViewControllerAnimated:NO completion:completion];
    }];
}

- (void)addObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect keyboardEndFrame = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGFloat maxY = CGRectGetMaxY(self.cardView.frame);
    CGFloat topOffset = CGRectGetMinY(keyboardEndFrame) - CGRectGetHeight(self.cardView.frame) - 48;
    CGFloat margin = topOffset > 48 ? 48 : (CGRectGetMinY(keyboardEndFrame) - CGRectGetHeight(self.cardView.frame)) * 0.5;
    // 判断是否遮挡当前输入框，小于0遮挡，大于或等于0没有
    CGFloat map = floor(CGRectGetMinY(keyboardEndFrame) - maxY - margin);
    if (map < 0) {
        self.centerYConstraint.constant = map;
        
        [self.view setNeedsLayout];
        [UIView animateWithDuration:animationDuration animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSTimeInterval animationDuration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    self.centerYConstraint.constant = 0;
    [self.view setNeedsLayout];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Tips" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:confirmAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)cancelButtonAction:(id)sender {
    [self.view endEditing:YES];
    [self dismissWithCompletion:nil];
}

- (IBAction)confirmButtonAction:(id)sender {
    [self.view endEditing:YES];
    NSString *amount = [self.amountTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *subject = [self.subjectTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *customerId = [self.customerIdTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if (amount.length < 1) {
        [self showAlertWithMessage:@"Please enter amount"];
        return;
    }
    
    if (subject.length < 1) {
        [self showAlertWithMessage:@"Please enter subject"];
        return;
    }
    
    [self dismissWithCompletion:^{
        if (self.confirmHandler) {
            self.confirmHandler(amount, subject, customerId);
        }
    }];
}

@end
