//
//  DDDownloadV.h
//  MyChat
//
//  Created by Siya9 on 30/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DDFileManager.h"
#import "RMDownloadIndicator.h"
#import "RMDisplayLabel.h"
@interface DDDownloadV : UIView

@property (nonatomic, strong) UIImageView * imgView;
@property (nonatomic, strong) RMDownloadIndicator * rmIndicator;
@property (nonatomic, strong) UIButton * btnAction;
@end
