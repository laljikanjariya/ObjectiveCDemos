//
//  MessageListCell.h
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMDownloadIndicator.h"

@protocol MidiaDownloadCellDelegate <NSObject>
    -(void)messageMediaDownloadwith:(id) response downloadError:(NSError *)error;
    -(void)showMessageDetailAt:(NSIndexPath *)indexPath;
@end

@interface MessageListCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * lblMessage;
@property (nonatomic, weak) IBOutlet UILabel * lblTime;
@property (nonatomic, weak) IBOutlet UIImageView * imgUser;
@property (nonatomic, weak) IBOutlet UIImageView * imgMessage;

@property (nonatomic, strong) RMDownloadIndicator * Indicator;
@property (nonatomic, weak) IBOutlet UIButton * btnDownload;
@property (nonatomic, weak) IBOutlet UIButton * btnShowDetail;
@property (nonatomic, weak) Messages * objMessage;
@property (nonatomic, weak) UITableView * objTableview;

@property (nonatomic, weak) IBOutlet NSLayoutConstraint * layImgHeight;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * layImgWidth;

@property (nonatomic, weak) id<MidiaDownloadCellDelegate> delegate;


@property (nonatomic, weak) IBOutlet UIView * viewIndicater;


-(void)setUpCellForMessage:(Messages *)objMessage;
@end
