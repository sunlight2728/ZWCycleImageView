//
//  ZWHelper.m
//  ZWCycleImageView
//
//  Created by liam on 2017/2/13.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

#import "ZWHelper.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonDigest.h>
#import <CoreLocation/CoreLocation.h>
#import <sys/sysctl.h>
#import <sys/utsname.h>

static ZWHelper *sharedZWHelper;
NSString *const kInitVector = @"42511           ";
size_t const kKeySize = kCCKeySizeAES128;


@implementation ZWHelper


+ (id) shareSharedZWHelper {

    @synchronized ([ZWHelper class]) {
        if (sharedZWHelper == nil) {
            sharedZWHelper = [[ZWHelper alloc] init];
        }
    }
    return sharedZWHelper;
}

+ (void)cancelSharedZWHelperAct
{
    sharedZWHelper = [[ZWHelper alloc] init];
}



////调整label的frame高度，使他变高适应文字高度,maxH为零时不限高度
//+ (void)resizeLabel:(UILabel *)label maxHeight:(CGFloat)maxH{
//    if (label == nil || label.text.length ==0) {
//        return;
//    }
//    CGSize labelSize ;
//    NSDictionary *attribute = @{NSFontAttributeName: label.font};
//    
//    labelSize = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width,11111) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    
//    CGRect labelFrame = label.frame;
//    if (labelSize.height < labelFrame.size.height) {
//        return;
//    }else{
//        if (maxH > 0. && labelSize.height <= maxH) {
//            labelSize.height = maxH;
//        }
//        labelFrame.size.height = labelSize.height;
//        label.frame = labelFrame;
//    }
//}

////获取当前屏幕显示的viewcontroller
//+ (UIViewController *)getCurrentVC
//{
//    UIViewController *result = nil;
//    
//    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
//    if (window.windowLevel != UIWindowLevelNormal)
//    {
//        NSArray *windows = [[UIApplication sharedApplication] windows];
//        for(UIWindow * tmpWin in windows)
//        {
//            if (tmpWin.windowLevel == UIWindowLevelNormal)
//            {
//                window = tmpWin;
//                break;
//            }
//        }
//    }
//    
//    UIView *frontView = [[window subviews] objectAtIndex:0];
//    id nextResponder = [frontView nextResponder];
//    
//    if ([nextResponder isKindOfClass:[UIViewController class]])
//        result = nextResponder;
//    else
//        result = window.rootViewController;
//    
//    return result;
//}





+ (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    return destinationDateNow;
}




//匹配中国邮政编码：[1-9]\d{5}(?!\d)
//评注：中国邮政编码为6位数字
+ (BOOL) isValidZipcode:(NSString*)value
{
    const char *cvalue = [value UTF8String];
    long len = strlen(cvalue);
    if (len != 6) {
        return FALSE;
    }
    for (int i = 0; i < len; i++)
    {
        if (!(cvalue[i] >= '0' && cvalue[i] <= '9'))
        {
            return FALSE;
        }
    }
    return TRUE;
}


//判断是否为中国手机号
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    //    号段参考
    //    http://baike.baidu.com/view/781667.htm
    
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog ( @"%@" , currentLanguage);
    /**
     * 手机号码
     */
    //    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    //    2G号段（GSM网络）有134x（0-8）、135、136、137、138、139、150、151、152、158、159、182、183、184。
    //    3G号段（TD-SCDMA网络）有157、187、188
    //    3G上网卡 147
    //    4G号段 178
    
    //    NSString * CM = @"^1(  34[0-8] |  (3[5-9]  |  5[017-9]  |  8[012789]  )\\d)\\d{7}$";
    //    中国电信手机号码开头数字
    //    2G/3G号段（CDMA2000网络）133、153、180、181、189
    //    4G号段 177
    
    //    NSString * CU = @"^1(3[0-2]|5[256]|8[56]|7[7])\\d{8}$";
    //    中国联通手机号码开头数字
    //    2G号段（GSM网络）130、131、132、155、156
    //    3G上网卡145
    //    3G号段（WCDMA网络）185、186
    //    4G号段 176
    
    
    
    //    NSString * NumberMore = @"^1(3[0-2]|5[256]|8[56]|7[7])\\d{8}$";
    
    //    补充
    //    145  147  1700  1705  1709  1349
    //    14号段以前为上网卡专属号段，如中国联通的是145，中国移动的是147等等。
    //    170号段为虚拟运营商专属号段，170号段的 11 位手机号前四位来区分基础运营商，其中 “1700” 为中国电信的转售号码标识，“1705” 为中国移动，“1709” 为中国联通。
    //    卫星通信 1349
    
    NSString * NumberBig = @"^1([345]|[78])\\d{9}$";
    
    
    NSPredicate *regextestBig = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", NumberBig];
    
    if ([regextestBig evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^([\u4e00-\u9fa5_A-Za-z]){1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
    
    
}



//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,16}+$";  //——————字母、数字，6~16位
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//密码
+ (BOOL) validateBankCardNo:(NSString *)cardNumber
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{1,20}+$";  //——————字母、数字，6~16位
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:cardNumber];
}

//定位是否可用

+ (BOOL)isLocationUse
{
    if ([CLLocationManager locationServicesEnabled] &&
        
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined|| [CLLocationManager authorizationStatus] ==kCLAuthorizationStatusAuthorizedWhenInUse) ){
            //定位功能可用，开始定位
            return YES;
            
        }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied)
    {
        //        NSLog(@"定位功能不可用，提示用户或忽略");
        return NO;
    }
    
    return NO;
}






//昵称
+ (BOOL) validateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}


//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}


//证件号码，各种证件
+ (BOOL) validateCertificateNO: (NSString *)CertificateNO
{
    BOOL flag;
    if (CertificateNO.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:CertificateNO];
}












+ (NSString *)encryptAES:(NSString *)content key:(NSString *)key {
    
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    NSUInteger dataLength = contentData.length;
    
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t encryptSize = dataLength + kCCBlockSizeAES128;
    
    void *encryptedBytes = malloc(encryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          encryptedBytes,
                                          encryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [[NSData dataWithBytesNoCopy:encryptedBytes length:actualOutSize] base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    }
    free(encryptedBytes);
    return nil;
}


+ (NSString *)decryptAES:(NSString *)content key:(NSString *)key {
    
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:content options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSUInteger dataLength = contentData.length;
    
    char keyPtr[kKeySize + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    size_t decryptSize = dataLength + kCCBlockSizeAES128;
    
    void *decryptedBytes = malloc(decryptSize);
    size_t actualOutSize = 0;
    
    NSData *initVector = [kInitVector dataUsingEncoding:NSUTF8StringEncoding];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kKeySize,
                                          initVector.bytes,
                                          contentData.bytes,
                                          dataLength,
                                          decryptedBytes,
                                          decryptSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [[NSString alloc] initWithData:[NSData dataWithBytesNoCopy:decryptedBytes length:actualOutSize] encoding:NSUTF8StringEncoding];
    }
    free(decryptedBytes);
    return nil;
}



-(NSString *)ZWMD5WithString:(NSString *)string
{
    const char *ptr = [string UTF8String];
    unsigned char md5Buffer[16];
    CC_MD5(ptr, (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], md5Buffer);
    NSString *output = [[NSString alloc] initWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                        md5Buffer[0], md5Buffer[1], md5Buffer[2], md5Buffer[3], md5Buffer[4], md5Buffer[5],
                        md5Buffer[6], md5Buffer[7], md5Buffer[8], md5Buffer[9], md5Buffer[10], md5Buffer[11],
                        md5Buffer[12], md5Buffer[13], md5Buffer[14], md5Buffer[15]];
    
    return output;
}











@end



