//
//  UserListCell.h
//  MyChat
//
//  Created by Siya9 on 16/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserListCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * lblUserName;
@property (nonatomic, weak) IBOutlet UILabel * lblMessageOrTime;
@property (nonatomic, weak) IBOutlet UILabel * lblUnreadMsgCount;
@property (nonatomic, weak) IBOutlet UIImageView * imgUser;
@end
