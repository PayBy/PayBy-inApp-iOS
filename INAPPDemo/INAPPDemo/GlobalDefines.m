//
//  GlobalDefines.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/23.
//

#import "GlobalDefines.h"

//static NSString * kEnvironment = @"SIM";
static NSString * kEnvironment = @"UAT";
//static NSString * kEnvironment = @"REL";

@implementation GlobalDefines

+ (NSString *)appId {
    if ([kEnvironment isEqualToString:@"UAT"]) {
        return @"20200510000000121";
    } else if ([kEnvironment isEqualToString:@"REL"]) {
        return @"20200520000000031";
    }
    return @"20210502000000391";
}

+ (NSString *)partnerId {
    if ([kEnvironment isEqualToString:@"UAT"]) {
        return @"200000046800";
    } else if ([kEnvironment isEqualToString:@"REL"]) {
        return @"200000001902";
    }
    return @"200000323656";
}

+ (NSString *)privateKey {
    if ([kEnvironment isEqualToString:@"UAT"]) {
        return @"MIIEuwIBADANBgkqhkiG9w0BAQEFAASCBKUwggShAgEAAoIBAGb15DRJv454PnIHrmL3ku1LdpLt1J7GXl33m8BW5AH1FIZs1avRaR5jxeTpG/dURCQD25dGqrzDi4NPEWomlYj/hN8q+6cfL72CuIgllY4qvmNfDkWKFmsB6GrkRcMUufpeiMeDAA7BF2u15gtqON1bNfrhxDyWdbDBgiNky2NXR7EvwmtmM/MYDcBbCyk2k67RhXG1ytXsvksLmWXxkE9aENQHfB+Kg7ZCpnXyjBpaHXBxahSfEiaIT8MImVjR0tZ4u7vV3R1rBsl5EdOf6F75CA8gKD+Z4nKcDqnM4s4ILeRULHDT3fcTnCVZR4x0cXPQyD4GhXD3DhMn3yTufn0CAwEAAQKCAQBjOX/W4GfqbnmHvV1TZVLEu2Ank2rAJV5WYsVIZLTSKhXAwuxc7LDIp9DUnc7k2eHdb5ZVwLXUuwMd5bpbuZmM8Otlg3AJDGYe1fbuxoHOA+V9sOL5I24dbDZHpXyR18yvvCFHXTlV/sKKfD+aKqFounlYMfHDjiEX2jWH1KCqN/6Uxepd6zYbFkVJ1L9x/6VwXKR6IBX4EBDxAIZ5VmFGQq0B2/tguWlx4XJyOzbUEGEiegRKAS/ONbPUirzvHp6aNS7yrzfk29DdWgVCwV1ni3TT+OAICcxAE0IdexxY9JSuYnQlVw45RZ+WLlkfA/S3oDtbusBveew/OBzbvleFAoGBAKxXZZUAixJl/tfSAdzh0+u0AoLyAPz4XswCiu8PwICAGml/67ThRZJR7VsHUc21n8SoU8VTtcsYSEmA6NIdSVmvoIzKyMGzSpuD5RTPAwXVWT+rOrKzDvNJelsbg2CtD5UZoCg6m0bXeIrEEmO7xFeYHO7zg5o+ADWPVsKGVdbnAoGBAJjwo1STnxDPWwrP4T1UY0t42kQtyZz8jsgIH2vv8Mpua6N3uX1hv5TxpYUBiBuVv0p9kEM+f+jjf48l7FxWINxfS4z9b/KV8pgOPDyeYQBZhk+BBS0KYH7SKrYFcKKZZdmWYAGif8RzI9mQNLKYToQH88PGyLL0gIQUsO7A3ab7AoGAY+Nv9DHRaYOGds64165oZyf5gK4FlpnaUAJ1RmRp3dDh/h3vnvImoc0sdmNCralEhfZOP4PqTWGwnDHEP+xLlFjwBEqQm3xwlLyYrTvi86GZzgZPyj1wP+Bps565wfHsoy2sH0UAtMm0izFjuzyca2y18GVh9KdU9bYzwiGcZScCgYAbxARDBJHqQVrr+ZWQxtNIDmbB3fYuVAOv+RmLRQJYHffYs5GvW6GmbsB4BzEooOUbpvQb4SrjovmziVUB5nkMyRg0PoamaeajCGKTNsWxhI9Hu8quxKWEIK+0YAR04JiHCi/f3BqKFcU6aF3I1rHacn8k2d/x7UWvtPnyPn1/JQKBgBbKAGGrrLdjucsRUhRKYtZ3ba9n7t9D2q8+ggwTPbmdOyZGo6hHNwsSO8jSmLfAF03UAGVPkflJ2y/FWY0cM3DgtqCZcnAJY+Fh+eFWoHWkxomMEGSMnPLawfx4TNnElyWWD11zlXjsX/1gBKYPxxluFKCNebOKU3iKoZyXpi82";
    } else if ([kEnvironment isEqualToString:@"REL"]) {
        return @"MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCVU/CBfEcOSG1m7T4CwBedFF7mjuzYXgcsW+py6fPV75YsK/NEevwbudxTmOQMjeLGDmBen0qMVgvrd5LetzWdUih8VIsjtu8kZr1hgr6bb79X/w5OonUJgIES4L7mgAAi4rng8msFSHHyvomDrP8KVzNWJNEC32MouavXfIX3/rn8n/XX8URH+/NnlzZ5w51Tj3gEZOdTwtbrKOwKKVPF4zm0pMZQHyfqIKDwmYXGZhS2Et+Za1YDVAV/lXVSU9pjL5DL9HwkxLG1XJnwe5ZHo2tI7X4SP6O/fA7R7SPIkrGwjrDMBxi43J5QhfJ8ZH2xXdETECxtA46GX7Izj5i/AgMBAAECggEAPTSwiYJU5YfOP7fSCPKPOzUUSNAgR/cSXZ43FG7MIM4Y8XX6OgFmwD6IDkPGhVbKsn9GBMKpnafPLu5N5reVZCw+p+dHOJZMotDxorwiQDenZ/wE8zonWoOvY/t2g6fHZoUjxw3Vy86L1gE/ABeyWZywUAi7GsBRNmoUAzjo+GJxr8U7EJOjR/7TOHdA/m5e/4ZPHuRlRTt46uJgD35oOOm+BhJsupvdEgkVr4DqCg/pdcDSgIxBFs5WD0a5afbTTrKYzpF8oj9Zgaw7JpwIfFxC6U6ulsUrJRpEA08JB3XQ1WGRNHiyLf9DFEBMF2fIRMzeDkoa8WcOQizUZc6YAQKBgQDGzYPWrqJQ7YqnFId2/Ae33J04I4v5KE2qQqumxKvBr0isr6jsH0LC6BAKvYsU4c1m+OkOXXqpV3BiXVwgnn2sg2VsZvrZqgzB+OIiiAJgBOb/A0cw7Q1Z1vYVpB5aYg+DBW/FwMzbZPtahPbQTlS1uEL4lKujI6Kn8emtiqaOvwKBgQDASm8GxBJva7q1B6d0alFHK01e/hJR0iv7LIvhgrog0aTCH5tca6z00dJMz7U+JRjiI5w3Hi3+xgHlmdblf2Y01fSTRtGdkHdwQCtIIV3x9q2QElLpxQoD0hhKDmLh9uzGJiH2U8Wyu6ZlZzswNhF2KQzKPp16Gaa9vajAYSN2AQKBgQC3a5JCFqmnpSKR+PzrKKkuWBuuWg2g+jB98DlTCo21i7WvrfpasJT2Iwn5/ts9jv/mC61rFZBAgW4tMxn29oPZEPoYxAKZpK1Uof5yAa6/TIabrjiWyX/R7eTqHpvqpCLPrcpsV/AqU8ccwyS9GChL6Q/RLcoWIKDH9wi0lwIJHQKBgQCrCInAht2u5S9onapATeCFYOqst2gsBri/7Ftu9gv/7PiTAfH6PnvUNlzLnWQkJnL/kZT9IYbfudcuFaui7bJHBJdJ+A+yCjFyUmEtAyDAexzdrK6651uFEnYwSKODQVJQ3NIQe2q5E1dpkmx+8ViOtOx/ZzpCxFYfJnbWxo/4AQKBgCjzZC8LDyXFuPG4zV0t4dCEL9IphyVCfX9kxE73mdaL0PZqWxp2DhNW4s+fWifiBaDnfNNqYtu1T3JNiBcTDSI9+g7JwwKN1HyBH1S44cjs1j4lggh6tVyhyI+Gg3Wb3w7vuP4MzrthkcJKa04GogOQ/MUUbxEU14BNYwLbAEdo";
    }
    return @"MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQDC01L+MtGQ7kGhdBnKzBzUDJktFxXozc+K6ipzIA5tqeabYpCBdrc1Vg80ZZnR6SDmiVpIAoC8BlXgXP157CyVpMlAElQ+amPQ0tngXrSsFfufZ/CHB+fyjqBCeymywOt3ipMFQP8P03jAcQflDGArkiquwQFhbO+f7lsqMB0Cd207EuLBZY2uNy/KVcrExRvLXkKTe/nrP74fAJzGjxplluDrRiEIkOhlZuvfeUyoRd5cha4IGcsmElUFUzsg8z5uEqX/g7ggnqMxXHDKCZoVzUrmms8hJprxAkDl0L0i2qL4xvCBirpBDHIxYSpu4ukB3n8K2mVcQmDvDhwIdux3AgMBAAECggEBALLTfDs9dCR+vRkwUzhVMCTnR3Ye2Ypt1xGgLMStaPD54WVBDHj4+eNoEd67X3xQa1WQP6EXQwjTG+IsGLHfuXDF57/60v7TcrlLwJb09wt5xhOkOSAIfruidLFxEW41LCz2skpBRZ1GM3EYjvGL8X4s1SbAm77MWgrHo0BPF2GZmHpb1Gaj6uAjj2AzcRyMD+ozgTVaTFFGcgMLI97UCtZyGCPrBCjyaRGlKdmIF1FRgLs/izMIYTdteORIt7XGWj5ar8jcHmgO46/5RBeU80LpDrtF9GO2RInfCP0gvRLpD62+s/M/NQ1vM++87hYc5PfG7uKesq3FQHhMGqH9FOECgYEA7m4cbQAbsGPhsO7ticSlhEDkbDODpDO0lEmEipv4acEjxdk8qkV/xPQ4ICZGJjtp9fFqWrLzSM7vSOU5YUyVNEK7hAE5Xnel6c60uMCdgzUjFtewT8690fy5YJ9jamap5fT+fcMz2GP91wad8vqRCgDr2vE7czq9KqWfSrHRoWcCgYEA0S6hDcy59xRaaJ0ZyEAEcFUQwSx5aSm3Pygyf89FUZcAgsBZQegcMulH+Xkkx4JcBCUoyd82+j/A2Kq1vHjKDHKETDLh6AhnXlTiTV1gwdZK3Fw2j3gngqmmhunuYCedol3YHEKLomMtgUaZeB5//30YP/UeFBobdjnazBYpInECgYEAr8vuF4wp3j92y58O8zJTm5TBFupQmIQrE9605AImAcuPFbSbnyvJDi3HKCUwOcY61UTf1un0qO0yzrt8ODpgFH1ThvvkEbwET8TBySrzuCc4rQHxFJbprGc7Q3uhsHTrtgqSjaWcl2L6aU2OrfWDdS3CuNZ+r/JSQZyGO2uqlecCgYEAziS+sMPFrHnRUvEnPFHiTfV2yngSuhFTNhleEthnfq1p4nC+RZYBXCbLOE4rcbXFCoy4MqEYI+v6F0u8R51duICOYi1utWS6wZqzXfyc4slVAu6ZEjAd98VKiAA3W2kPDriexdLKmuBUMucpTNf52gUkhbsAxlyoHY2MUr2wEfECgYEAhN5VA+nTwFACc1AYcqXGtwNih1Qeger1+wmwWtYxKgUK9LVtJlMzIpR96ubWtO06kFHHG2Dq+ykC51RrzWKVkKn6gIgXmBWosgUneyOtoQzjZ8tpgtmCDuZyusiJOgf9hNilSmb9HqUsNXLyfPI2KQQHHXIZjOJWL2lunosRo7c=";
}

+ (NSString *)placeOrderUrl {
    if ([kEnvironment isEqualToString:@"UAT"]) {
        return @"https://uat.test2pay.com/sgs/api/acquire2/placeOrder";
    } else if ([kEnvironment isEqualToString:@"REL"]) {
        return @"https://api.payby.com/sgs/api/acquire2/placeOrder";
    }
    return @"https://sim.test2pay.com/sgs/api/acquire2/placeOrder";
}

+ (NSString *)environment {
    return kEnvironment;
}

+ (void)setEnvironment:(NSString *)environment {
    kEnvironment = environment;
}

@end
