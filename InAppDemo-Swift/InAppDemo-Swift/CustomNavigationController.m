//
//  CustomNavigationController.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/17.
//

#import "CustomNavigationController.h"

@interface CustomNavigationController ()

@end

@implementation CustomNavigationController

- (instancetype)init {
    if (self = [super init]) {
        self = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CustomNavigationController"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.semanticContentAttribute = [UIView appearance].semanticContentAttribute;
    self.view.semanticContentAttribute = [UIView appearance].semanticContentAttribute;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
