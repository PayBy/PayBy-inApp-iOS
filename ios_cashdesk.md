## Let paypage work on iOS  WKWebView

### Steps:

1. Implement`webView:decidePolicyForNavigationAction:decisionHandler:`method of the `WKNavigationDelegate` protocol  by your WKWebView.

2. UIApplication openURL to launch PayBy/Botim.

   

### Sample Code

1. Implement`webView:decidePolicyForNavigationAction:decisionHandler:`method of the `WKNavigationDelegate` protocol    and launch the payment app.

```Objective-C
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSURL *url = navigationAction.request.URL;
    if ([self isPayByURL:url] || [self isBotimURL:url]) {
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
    return [url.scheme isEqualToString:@"payby"] && [url.host isEqualToString:@"payment"] && [url.path isEqualToString:@"/open-iap-cashdesk"];
}
- (BOOL)isBotimURL:(NSURL *)url{
    return [url.scheme isEqualToString:@"https"] && [url.host isEqualToString:@"botim.me"] && [url.path isEqualToString:@"/botim/payby/open-iap-cashdesk"];
}
```
