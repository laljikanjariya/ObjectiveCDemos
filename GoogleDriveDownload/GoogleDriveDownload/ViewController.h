//
//  ViewController.h
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/28/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GTLRDrive.h>
#import <Google/SignIn.h>
#import "GTMSessionFetcher.h"
@interface ViewController : UIViewController


@end

@interface EDIFilesCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * lblEDIName;
@property (nonatomic, weak) IBOutlet UILabel * lblEDIStatus;
@property (nonatomic, weak) IBOutlet UIButton * btnDownload;
@property (nonatomic, weak) IBOutlet UIButton * btnOpen;

@end
