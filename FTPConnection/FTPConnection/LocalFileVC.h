//
//  LocalFileVC.h
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocalFileVC : UIViewController
@property (nonatomic, strong) NSString * strCurrentDirectory;
@property (nonatomic) BOOL isPastFromServer;
@end
