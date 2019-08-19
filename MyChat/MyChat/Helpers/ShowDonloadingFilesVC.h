//
//  ShowDonloadingFilesVC.h
//  MyChat
//
//  Created by Siya9 on 19/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowDonloadingFilesVC : UIViewController
//@property (nonatomic, weak) DataDownloader * objDataDownloader;
@property (nonatomic, weak) DDFileManager * objDataDownloader;
@property (nonatomic, weak) IBOutlet UITableView * tblDownloadList;
@end
