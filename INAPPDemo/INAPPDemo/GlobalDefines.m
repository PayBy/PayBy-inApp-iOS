//
//  GlobalDefines.m
//  PayByPaymentDemo
//
//  Created by lengchuanxin on 2022/8/23.
//

#import "GlobalDefines.h"

static NSString * kEnvironment = @"SIM";
//static NSString * kEnvironment = @"UAT";
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
        return @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC60xaD1xcopQleZyLC9B0gMge/jOx9kwKbCFQOrRsa2IWoZXsbAgFdVdWpvsJ7g3d7nCBpsYVcgp150NsBparI3L9iRFKFUZfnRCrCRfK0uEJEWJt+pr0j8bp5j/tvAAijq3sfm2q3nNr9jd9QT5ssx5fIOaedZujhU8R/ixvit5dVdkUazkq9bvTkOWUSx8i3xNElaNjO0cVb2tqZ8eBhex88hgg4jWERS+rc/o3AVqcRf24m6X3MtC7K11uZ5NVa443B3gy67fx1h1f9O89k8nCnpVfaNVPCn5zwiMWtV/JIF+teBwk3n8YAUaWsHN3uimssLp2oqcPFP0lMYR4xAgMBAAECggEADBHbIIVi36NZ6ZlsK4At6YiR65QlKy+2OWHeXFxepetbJzf3LhWBFRCYjzDdy7EApSG/DlUDsqhVmCsgGwki8Xshei3Dzw0obS6APLDcL0TAMz4uPY50JcBWNchRjChKZpiLic02pcoic8MYrE2YTtpOOgdPhuHBJd2NklfgY1Mwzo86xCVdhGo8gZA43BZH8M7WA9F8IxSd8V7FHW/4b02i2j9j3EH5fN6o17r6jiwLl/8WEob5n6LqNc1lMv0RSmSOJtvL9EVnrGtmHARNJxQ1RQ6QjLrd4kWdavHApoeyS1mXZiDJCRcwyorYpcK2p9/vNzSM9VgBcqjBD0wB6QKBgQDl/i7QrTWehP4jTSd6H6YDgeLYY65WbKlF0L6QgvXrX+WSVkS/xD7oXoNGWcxjz8wcw8bW9dHdTbm8EA9GS5HQ8RR/mFAbxRhEnzgHVQ5Hz1K6sxvM1OYKK7hRRAPxAeeYPREyXz8Rf6vWBvYdbvWmRAKQcaXQFc1+W6DAILtLnwKBgQDP80VwmKNVpp55FaKj8pRJEyFJfuMFrLlONNjnhc69D7psYJ4G0BlmgimkfSkTvZhXB00VVz3Uk/yiVL54MziEgaP5CSZCN+Yq2SWvQZufUspgYlkTWMio7lz5pwGmlHEl+1AUT6tb2kg61+IM+o/LCgbCt2eJ3JEg2k9YrRhELwKBgG4D0XcGc7CZI0vVmz2ip/HjjpQ90mYK4knAGXfc/S+TFqiSVZ55jDHxC9B6IffYrWVRDOtEeRfoFyFreTMB8QVGXKzQOfmepQYmN1HikMsu0/70sCah7EwPL8LHyy7c32CGTZSP1QZU0Oi3OcFIk37t52AazNslor9/qvxca9s3AoGATSOqE62bkW9AhBxBe93FoiHljDT0lCtRhjBWcfQSD9Igzok8tbxGX99TAUColzkSpN4BezQkrJHE+pbDHSWrBoRsxjndplzEFgr9TrjguMZmakCxWFrr/LaHaNjJ5PhVzMggGZjAMU+U0bc5lKTx6Fisz1hnoR1f/LbfDj8PrGMCgYBwN4tUpPMEtGW9hP71o+y1QkVHof3rJRBjmvywoCEhlvgAc7N+wNQhkydznZ61tPL9J7UIktGpDAUffAxdRDgfQqnucetFFasIUMpIS8mnJKWaj/6kk/H5DN5WNwiwp8/aM0kx+IE8OnPs/+T2WA0zwRN9637jjjFHEJP5SvILMQ==";
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

@end
