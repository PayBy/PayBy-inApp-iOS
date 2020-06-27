//
//  ViewController.m
//  INAPPDemo
//
//  Created by ice on 2020/6/23.
//  Copyright © 2020 ice. All rights reserved.
//

#import "ViewController.h"
#import "GPBRSA.h"
#import <SLDPayByPayment/SLDPayByPayment.h>
@interface ViewController ()<UITextFieldDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    

    // Do any additional setup after loading the view.
     UILabel *tltLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 20)];
        tltLbl.backgroundColor = [UIColor clearColor];
        tltLbl.text = @"InAPP- Demo";
        tltLbl.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:tltLbl];
        
        UITextField *tokenTxt = [self createTxtField:@"token"];
        tokenTxt.frame = CGRectMake(20, 140, CGRectGetWidth(self.view.bounds)-40, 44);
        tokenTxt.placeholder = @"token";
        tokenTxt.tag = 300;
        tokenTxt.text = @"f6e996e5-4530-4820-b99a-0b537fbf7589";
        [self.view addSubview:tokenTxt];
        
        UITextField *appID = [self createTxtField:@"appid："];
        appID.frame = CGRectMake(20, 140 + 44 +20, CGRectGetWidth(self.view.bounds)- 40, 44);
        appID.placeholder = @"appID";
        appID.text = @"20200510000000121";
        appID.tag = 200;
        appID.delegate = self;
        [self.view addSubview:appID];
        
        
        UITextField *partnerId = [self createTxtField:@"partnerId："];
        partnerId.frame = CGRectMake(20, appID.frame.origin.y + 44 + 20, CGRectGetWidth(appID.frame), 44);
        partnerId.placeholder = @"partnerId";
        partnerId.text = @"200000046800";
        partnerId.tag = 201;
        [self.view addSubview:partnerId];
        
        UITextField *deviceId = [self createTxtField:@"deviceId:"];
        deviceId.placeholder = @"deviceId";
        deviceId.text = @"deviceId123";
        deviceId.tag = 301;
        deviceId.userInteractionEnabled = NO;
        deviceId.frame = CGRectMake(20, partnerId.frame.origin.y + 44 + 20, CGRectGetWidth(appID.bounds), 44);
        [self.view addSubview:deviceId];
        
        UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        submitBtn.frame = CGRectMake(20, deviceId.frame.origin.y+ 44 + 20, CGRectGetWidth(partnerId.bounds), 35);
        submitBtn.backgroundColor = [UIColor redColor];
        [submitBtn setTitle:@"submit" forState:UIControlStateNormal];
        [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:submitBtn];
        [submitBtn addTarget:self action:@selector(submitOfOnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        
       
        // Do any additional setup after loading the view.
    }

    - (UITextField *)createTxtField:(NSString *)left {
        UITextField *txt = [[UITextField alloc]initWithFrame:CGRectZero];
        txt.textColor = [UIColor blackColor];
        txt.leftViewMode = UITextFieldViewModeAlways;
        UILabel *txtLbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 90, 44)];
        txtLbl.backgroundColor = [UIColor clearColor];
        txtLbl.textColor = [UIColor blackColor];
        txtLbl.text = left;
        txt.leftView = txtLbl;
        txt.delegate = self;
        txt.clearButtonMode = UITextFieldViewModeWhileEditing;
        txt.borderStyle = UITextBorderStyleRoundedRect;
        return txt;;
        
        
    }

    - (void)submitOfOnClick:(UIButton *)sender {
        [self.view endEditing:YES];
        UITextField *appIdTxt = [self.view viewWithTag:200];
        UITextField *partTxt = [self.view viewWithTag:201];
        UITextField *token = [self.view viewWithTag:300];
        UITextField *deviceIdTxt = [self.view viewWithTag:301];
        
        if(appIdTxt.text.length > 0 && partTxt.leftView > 0){

            NSString *sigin = [NSString stringWithFormat:@"iapAppId=%@&iapDeviceId=%@&iapPartnerId=%@&token=%@",appIdTxt.text,deviceIdTxt.text,partTxt.text,token.text];
            
            NSString *temgSig = [GPBRSA encryptString:sigin privateKey:privateKey];
          
            [SDLPayByPaymentInterface requestInApp:token.text DeviceId:deviceIdTxt.text Sign:temgSig PageOnViewContorller:self success:^(id  _Nonnull result) {
                if([result isKindOfClass:[NSString class]]){
                    [self alertView:result];
                }
            } fail:^(NSError * _Nonnull error) {
                [self alertView:error.userInfo[@"errorInfo"]];
            }];
        }
        
    }

    - (void)alertView:(NSString *)error{
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"info" message:error preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           
           // [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        [alert addAction:action];
        
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    - (void)notifyInfo:(NSNotification *)info {
        
        [self dismissViewControllerAnimated:YES completion:nil];
        NSLog(@"fsfsd== %@==",info.object);
        [self alertView: info.object[@"result"]];
    }


@end
