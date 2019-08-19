//
//  AppDelegate.h
//  PurchaseOrder
//
//  Created by Siya9 on 03/08/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

