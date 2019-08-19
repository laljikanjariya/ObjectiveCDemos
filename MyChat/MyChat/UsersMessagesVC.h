//
//  UsersMessagesVC.h
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserData.h"
#import "Messages.h"

@interface UsersMessagesVC : UIViewController
@property (nonatomic, strong) UserData * fromUser;
@property (nonatomic, strong) UserData * toUser;
@end
