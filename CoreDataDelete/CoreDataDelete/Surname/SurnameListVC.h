//
//  SurnameListVC.h
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseManager.h"
@protocol SurnameSelectionDelegate <NSObject>
    -(void)didSelectedSurname:(Surname *)objSurname;
@end

@interface SurnameListVC : UIViewController
@property (nonatomic, weak) id<SurnameSelectionDelegate> Delegate;
@end
