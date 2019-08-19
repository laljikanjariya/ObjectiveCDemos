//
//  ViewController.h
//  ImageDownloader
//
//  Created by Siya9 on 17/11/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


#pragma mark - Cell -
#import "RapidImage.h"
@interface ImageTestCell : UITableViewCell
@property (nonatomic, weak) IBOutlet RapidImage * imgView;
@end