//
//  POSelectUserOptionVC.h
//  PopUPSearch
//
//  Created by Siya9 on 07/07/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SelectUserOptionVC.h"
typedef void (^SelectionComplete)(NSArray * arrSelection);
typedef void (^SelectionColse)(UIViewController * popUpVC);

@interface POSelectUserOptionVC : PopupSuperVC

@property (nonatomic, strong) NSString * strkey;
@property (nonatomic, strong) NSString * strImgKey;
@property (nonatomic) float fltRowHeight;
@property (nonatomic) int intMiximumRowDisplay;

+(instancetype)setSelectionViewitem:(NSArray *)arrItem SelectionComplete:(SelectionComplete)selectionComplete SelectionColse:(SelectionColse)selectionColse;
@end
