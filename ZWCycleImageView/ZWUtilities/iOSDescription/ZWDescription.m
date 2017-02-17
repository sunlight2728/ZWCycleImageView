//
//  ZWDescription.m
//  ZWCycleImageView
//
//  Created by liam on 2017/2/17.
//  Copyright © 2017年 http://blog.csdn.net/sun2728. All rights reserved.
//

/*
 权限列表
 
 */


#define ZW_SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

#import "ZWDescription.h"

@import CoreTelephony;  //联网

@import AssetsLibrary;  //相册功能 iOS 9之前
@import Photos;         //相册功能 iOS 8之后
@import AVFoundation;   //相机和麦克风权限
@import CoreLocation;   //由于iOS8.0之后定位方法的改变，需要在info.plist中进行配置；
@import AddressBook;    //iOS 9.0之前    检查是否有通讯录权限
@import Contacts;       //iOS 9.0及以后    检查是否有通讯录权限
@import EventKit;       //日历 备忘录权限
@import UserNotifications;   //iOS 10 推送

static ZWDescription *sharedZWDescription;

@implementation ZWDescription



+(id)SharedZWDescription {

    @synchronized ([ZWDescription class]) {
        if (sharedZWDescription == nil) {
            sharedZWDescription = [[ZWDescription alloc] init];
        }
    }
    return sharedZWDescription;
}



// open url 打开 网址
-(void)zwOpenUrl:(NSString *)strURL
{
    if (ZW_SYSTEM_VERSION >= 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL] options:@{UIApplicationOpenURLOptionsOpenInPlaceKey:@"1"} completionHandler:^(BOOL success) {
            // 回调
            if (!success) {
                
            }
        }];
    }else{
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:strURL]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
        }else{
            
        }
    }
    
}

//打开APP的系统功能 
-(void)zwOpenAppSetting
{
    if (ZW_SYSTEM_VERSION >= 10.0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{UIApplicationOpenURLOptionsOpenInPlaceKey:@"1"} completionHandler:^(BOOL SUCCESS){
            
        }];
    }else{
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

    }
}

// 应用启动后，检测应用中是否有联网权限
-(void)zwCTCellularDataDescription{
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    cellularData.cellularDataRestrictionDidUpdateNotifier =  ^(CTCellularDataRestrictedState state){
        //获取联网状态
        switch (state) {
            case kCTCellularDataRestricted:
                NSLog(@"Restricrted");
                break;
            case kCTCellularDataNotRestricted:
                NSLog(@"Not Restricted");
                break;
            case kCTCellularDataRestrictedStateUnknown:
                NSLog(@"Unknown");
                break;
            default:
                break;
        };
    };
    
}


//    查询应用是否有联网功能

-(void)zwCTCellularData{
    CTCellularData *cellularData = [[CTCellularData alloc]init];
    CTCellularDataRestrictedState state = cellularData.restrictedState;
    switch (state) {
        case kCTCellularDataRestricted:
            NSLog(@"Restricrted");
            break;
        case kCTCellularDataNotRestricted:
            NSLog(@"Not Restricted");
            break;
        case kCTCellularDataRestrictedStateUnknown:
            NSLog(@"Unknown");
            break;
        default:
            break;
    }
}



//  检查是否有相册权限  相册权限--iOS  8.0之后  导入头文件 @import Photos;
//                           iOS  9.0之前  导入头文件 @import AssetsLibrary;

-(void)zwPhotoDescription
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0){
        PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
        switch (photoAuthorStatus) {
            case PHAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                break;
            case PHAuthorizationStatusDenied:
                NSLog(@"Denied");
                break;
            case PHAuthorizationStatusNotDetermined:
                NSLog(@"not Determined");
                break;
            case PHAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                break;
            default:
                break;
        }
    
    }else{
    
    
        ALAuthorizationStatus status = [ALAssetsLibrary authorizationStatus];
        switch (status) {
            case ALAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                break;
            case ALAuthorizationStatusDenied:
                NSLog(@"Denied");
                break;
            case ALAuthorizationStatusNotDetermined:
                NSLog(@"not Determined");
                break;
            case ALAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                break;
                
            default:
                break;
        }
    }
}

//  获取相册权限
-(void)getZWPhotoDescription
{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
}


//    @import AVFoundation;   //相机和麦克风权限


-(void)checkAVstatusDescription
{
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
//    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    
    switch (AVstatus) {
        case AVAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case AVAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case AVAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case AVAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
}

-(void)getAVstatusDescription
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {//相机权限
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {//麦克风权限
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
}


// 检测定位权限
-(void)checkLocationDescription
{
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        NSLog(@"not turn on the location");
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    switch (CLstatus) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Authorized");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"AuthorizedWhenInUse");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
}

// 获取定位权限
-(void)getLocationDescription
{
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    [manager requestAlwaysAuthorization];//一直获取定位信息
    [manager requestWhenInUseAuthorization];//使用的时候获取定位信息
}

//  在代理方法中查看权限是否改变
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    switch (status) {
        case kCLAuthorizationStatusAuthorizedAlways:
            NSLog(@"Always Authorized");
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            NSLog(@"AuthorizedWhenInUse");
            break;
        case kCLAuthorizationStatusDenied:
            NSLog(@"Denied");
            break;
        case kCLAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case kCLAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    
}







//检测推送权限
-(void)checkNotificationDescription
{
    if (ZW_SYSTEM_VERSION >= 10.0) {
        [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge|UNAuthorizationOptionSound|UNAuthorizationOptionAlert|UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
            //在block中会传入布尔值granted，表示用户是否同意
            if (granted) {
                //如果用户权限申请成功，设置通知中心的代理
//                [UNUserNotificationCenter currentNotificationCenter].delegate = self;
                //通知内容类
                UNMutableNotificationContent * content = [UNMutableNotificationContent new];
                //设置通知请求发送时 app图标上显示的数字
                content.badge = @2;
                //设置通知的内容
                content.body = @"这是iOS10的新通知内容：普通的iOS通知";
                //默认的通知提示音
                content.sound = [UNNotificationSound defaultSound];
                //设置通知的副标题
                content.subtitle = @"这里是副标题";
                //设置通知的标题
                content.title = @"这里是通知的标题";
                //设置从通知激活app时的launchImage图片
                content.launchImageName = @"lun";
                //设置5S之后执行
                UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
                UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"NotificationDefault" content:content trigger:trigger];
                //添加通知请求
                [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
                    
                }];
            }else{
                
            }
        }];
        
    }else{
        UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
        switch (settings.types) {
            case UIUserNotificationTypeNone:
                NSLog(@"None");
                break;
            case UIUserNotificationTypeAlert:
                NSLog(@"Alert Notification");
                break;
            case UIUserNotificationTypeBadge:
                NSLog(@"Badge Notification");
                break;
            case UIUserNotificationTypeSound:
                NSLog(@"sound Notification'");
                break;
                
            default:
                break;
        }
    }
}
-(void)getNotificationDescription
{
    if (ZW_SYSTEM_VERSION >= 10.0) {
        
    }else{
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}




//检查是否有通讯录权限
-(void)checkAddressBookDescription
{
    if (ZW_SYSTEM_VERSION >= 9.0) {
        CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        switch (status) {
            case CNAuthorizationStatusAuthorized:
            {
                NSLog(@"Authorized:");
            }
                break;
            case CNAuthorizationStatusDenied:{
                NSLog(@"Denied");
            }
                break;
            case CNAuthorizationStatusRestricted:{
                NSLog(@"Restricted");
            }
                break;
            case CNAuthorizationStatusNotDetermined:{
                NSLog(@"NotDetermined");
            }
                break;
                
                    }
    
    }else{

        ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
        switch (ABstatus) {
            case kABAuthorizationStatusAuthorized:
                NSLog(@"Authorized");
                break;
            case kABAuthorizationStatusDenied:
                NSLog(@"Denied'");
                break;
            case kABAuthorizationStatusNotDetermined:
                NSLog(@"not Determined");
                break;
            case kABAuthorizationStatusRestricted:
                NSLog(@"Restricted");
                break;
            default:
                break;
        }
    }
}

//获取通讯录权限
-(void)getAddressBookDescription
{
    if (ZW_SYSTEM_VERSION >= 9.0) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                
                NSLog(@"Authorized");
            }else{
                
                NSLog(@"Denied or Restricted");
            }
        }];
    }else{
    
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                NSLog(@"Authorized");
                CFRelease(addressBook);
            }else{
                NSLog(@"Denied or Restricted");
            }
        });
    }
}



//EKEntityTypeEvent,//日历
//EKEntityTypeReminder //备忘录

//  检测权限 并返回
+(EKAuthorizationStatus)authorizationStatusForEntityType:(EKEntityType)entityType
{
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case EKAuthorizationStatusDenied:
            NSLog(@"Denied'");
            break;
        case EKAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case EKAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
    return EKstatus;
}

-(void)checkEKEntityTypeDescription
{
    EKAuthorizationStatus EKstatus = [EKEventStore  authorizationStatusForEntityType:EKEntityTypeEvent];
    switch (EKstatus) {
        case EKAuthorizationStatusAuthorized:
            NSLog(@"Authorized");
            break;
        case EKAuthorizationStatusDenied:
            NSLog(@"Denied'");
            break;
        case EKAuthorizationStatusNotDetermined:
            NSLog(@"not Determined");
            break;
        case EKAuthorizationStatusRestricted:
            NSLog(@"Restricted");
            break;
        default:
            break;
    }
}

-(void)getEKEntityTypeDescription
{
    
    EKEventStore *store = [[EKEventStore alloc]init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            NSLog(@"Authorized");
        }else{
            NSLog(@"Denied or Restricted");
        }
    }];
//    __block void (^checkCalanderAuth)(void) = ^{
//        EKAuthorizationStatus authStatus = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
//        
//        if (EKAuthorizationStatusAuthorized == authStatus) {
//            //授权成功，执行后续操作
//        }else {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
////                checkCalanderAuth();
//            });
//        }
//    };
//    checkCalanderAuth();
}




@end
