//
//  UPApiUrl.h
//  UAEPay
//
//  Created by yaoxh on 2019/9/11.
//  Copyright © 2019 yaoxiaohui. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const privateKey = @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC60xaD1xcopQleZyLC9B0gMge/jOx9kwKbCFQOrRsa2IWoZXsbAgFdVdWpvsJ7g3d7nCBpsYVcgp150NsBparI3L9iRFKFUZfnRCrCRfK0uEJEWJt+pr0j8bp5j/tvAAijq3sfm2q3nNr9jd9QT5ssx5fIOaedZujhU8R/ixvit5dVdkUazkq9bvTkOWUSx8i3xNElaNjO0cVb2tqZ8eBhex88hgg4jWERS+rc/o3AVqcRf24m6X3MtC7K11uZ5NVa443B3gy67fx1h1f9O89k8nCnpVfaNVPCn5zwiMWtV/JIF+teBwk3n8YAUaWsHN3uimssLp2oqcPFP0lMYR4xAgMBAAECggEADBHbIIVi36NZ6ZlsK4At6YiR65QlKy+2OWHeXFxepetbJzf3LhWBFRCYjzDdy7EApSG/DlUDsqhVmCsgGwki8Xshei3Dzw0obS6APLDcL0TAMz4uPY50JcBWNchRjChKZpiLic02pcoic8MYrE2YTtpOOgdPhuHBJd2NklfgY1Mwzo86xCVdhGo8gZA43BZH8M7WA9F8IxSd8V7FHW/4b02i2j9j3EH5fN6o17r6jiwLl/8WEob5n6LqNc1lMv0RSmSOJtvL9EVnrGtmHARNJxQ1RQ6QjLrd4kWdavHApoeyS1mXZiDJCRcwyorYpcK2p9/vNzSM9VgBcqjBD0wB6QKBgQDl/i7QrTWehP4jTSd6H6YDgeLYY65WbKlF0L6QgvXrX+WSVkS/xD7oXoNGWcxjz8wcw8bW9dHdTbm8EA9GS5HQ8RR/mFAbxRhEnzgHVQ5Hz1K6sxvM1OYKK7hRRAPxAeeYPREyXz8Rf6vWBvYdbvWmRAKQcaXQFc1+W6DAILtLnwKBgQDP80VwmKNVpp55FaKj8pRJEyFJfuMFrLlONNjnhc69D7psYJ4G0BlmgimkfSkTvZhXB00VVz3Uk/yiVL54MziEgaP5CSZCN+Yq2SWvQZufUspgYlkTWMio7lz5pwGmlHEl+1AUT6tb2kg61+IM+o/LCgbCt2eJ3JEg2k9YrRhELwKBgG4D0XcGc7CZI0vVmz2ip/HjjpQ90mYK4knAGXfc/S+TFqiSVZ55jDHxC9B6IffYrWVRDOtEeRfoFyFreTMB8QVGXKzQOfmepQYmN1HikMsu0/70sCah7EwPL8LHyy7c32CGTZSP1QZU0Oi3OcFIk37t52AazNslor9/qvxca9s3AoGATSOqE62bkW9AhBxBe93FoiHljDT0lCtRhjBWcfQSD9Igzok8tbxGX99TAUColzkSpN4BezQkrJHE+pbDHSWrBoRsxjndplzEFgr9TrjguMZmakCxWFrr/LaHaNjJ5PhVzMggGZjAMU+U0bc5lKTx6Fisz1hnoR1f/LbfDj8PrGMCgYBwN4tUpPMEtGW9hP71o+y1QkVHof3rJRBjmvywoCEhlvgAc7N+wNQhkydznZ61tPL9J7UIktGpDAUffAxdRDgfQqnucetFFasIUMpIS8mnJKWaj/6kk/H5DN5WNwiwp8/aM0kx+IE8OnPs/+T2WA0zwRN9637jjjFHEJP5SvILMQ==";
//生产
//static NSString *const pubKeyString = @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAoY221tbXlKE6rseAquXzxSzu4FHcMKDAj+XsEKCmfCZ/n6FEnWd3HWJpLADk7gTSLFTfqZc9/VLxm7zF7P+li1k3OXHO1h773Gi0m6EKWmxCcPNAp1UCwu4Qy+ESHWBt9ACwcij0MeVxJaS473rr+rk3JM9zNabeY9XOp7G92OOdip/sPBNgoCQvjnfrU9mhE42KqVm0RTAUkX22Wny1gauDDuUUCKNF/V6jlSSh0KOT3mRuu5I6s5fuIYt5xjBbei/CvWUwCCYO8Ism8NHNI/bxrRZwt35sg4tirxWxPrk2o4eOTn2Q1mnWtmYe+IG36ysKYHihHgidhN7Tc5J2ZQIDAQAB";


@interface GPBRSA : NSObject

// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
+ (NSString *)decryptString:(NSString *)str publicKey:(NSString *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

@end
