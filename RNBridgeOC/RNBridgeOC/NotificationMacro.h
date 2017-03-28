//
//  NotificationMacro.h
//  RNBridgeOC
//
//  Created by Zero on 2017/3/27.
//  Copyright © 2017年 macbook. All rights reserved.
//

#ifndef NotificationMacro_h
#define NotificationMacro_h

#define Notif               [NSNotificationCenter defaultCenter]
#define NotificationAllRemoveFrom(obj)  [[NSNotificationCenter defaultCenter] removeObserver:obj];


#define kNotificationRNBackName @"kNotificationRNBackName"
#define kNotificationRNNextVCName @"kNotificationRNNextVCName"
//#define kNotificationRNPresentVCName @"kNotificationRNPresentVCName"

#define kNotificationRNBack(obj) [Notif postNotificationName:kNotificationRNBackName object:obj];

#define kNotificationRNNextVC(obj) [Notif postNotificationName:kNotificationRNNextVCName object:obj];

//#define kNotificationRNPresentVC(obj) [Notif postNotificationName:kNotificationRNPresentVCName object:obj];

#endif /* NotificationMacro_h */
