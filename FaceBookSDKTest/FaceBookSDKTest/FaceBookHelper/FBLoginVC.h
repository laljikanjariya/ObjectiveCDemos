//
//  FBLoginVC.h
//  FaceBookSDKTest
//
//  Created by Siya9 on 07/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupSuperVC.h"

typedef void (^FBLoginVCPost)(UIViewController * popUpVC);
typedef void (^FBLoginVCColse)(UIViewController * popUpVC);

@interface FBLoginVC : PopupSuperVC

@property (nonatomic, strong) FBLoginVCPost FBLoginVCPostblock;
@property (nonatomic, strong) FBLoginVCColse FBLoginVCColseblock;
+(instancetype)getViewFromStoryBoard;
@end
