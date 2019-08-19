//
//  AppDelegate.h
//  Localizetion
//
//  Created by Siya9 on 30/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AppLan)
{
    AppLanBase,
    AppLanArabic
};
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

-(NSString *)strGetFromKey:(NSString *)strKey;
@end

