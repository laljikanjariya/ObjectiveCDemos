//
//  UsersListVC.h
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, UserCurrentStatus) {
    UserCurrentStatusOffLine,
    UserCurrentStatusOnLine,
    UserCurrentStatusIsTyping,
};

@interface UsersListVC : UIViewController

@end
