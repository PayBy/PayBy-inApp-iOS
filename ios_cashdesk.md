## Let paypage work on iOS  WKWebView

### Steps:

1. Implement`webView:decidePolicyForNavigationAction:decisionHandler:`method of the `WKNavigationDelegate` protocol  by your WKWebView.

2. UIApplication openURL to launch PayBy.

   
### Deeplink 
The deeplink is also supported to call the payby cashdesk not only int the system application such as SMS,browser,but also int the customer webview of third part application.

Now,Payby has supported two deeplinks,one is https://app.payby.com/open-iap-cashdesk ,and the other is payby://payment/open-iap-cashdesk。Both of them need four parameters,and they can be found in:https://github.com/PayBy/PayBy-inApp-Android#parameter-preparation.

The final deeplink may like as follows:

```
https://app.payby.com/open-iap-cashdesk?ft=xxx&iapAppId=xxx&iapPartnerId=xxx&iapSign=xxx&iapDeviceId=xxx.
```
**or**

```
payby://payment/open-iap-cashdesk?ft=xxx&iapAppId=xxx&iapPartnerId=xxx&iapSign=xxx&iapDeviceId=xxx
```

### Sample Code

1. Implement`webView:decidePolicyForNavigationAction:decisionHandler:`method of the `WKNavigationDelegate` protocol    and launch the payment app.

```Objective-C
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *url = navigationAction.request.URL;
    if ([self isPayByURL:url]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
            }];
        } else {
            [[UIApplication sharedApplication] openURL:url];
        }
        decisionHandler(WKNavigationActionPolicyCancel);
    }else{
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}
```

2. Find payment apps' url

```Objective-C
- (BOOL)isPayByURL:(NSURL *)url{
    return (([url.scheme isEqualToString:@"payby"] && [url.host isEqualToString:@"payment"]) || ([url.scheme 		isEqualToString:@"https"] && [url.host isEqualToString:@"app.payby.com"])) && [url.path isEqualToString:@"/open-iap-cashdesk"];
}

```
