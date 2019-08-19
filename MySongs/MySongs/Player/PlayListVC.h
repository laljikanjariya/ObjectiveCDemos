//
//  PlayListVC.h
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayLists.h"
#import "DatabaseManager.h"

@protocol ChangeCurrentPlayList <NSObject>
    -(void)changeCurrentPlayListToNew:(PlayLists *)selectedPlayList;
@end
@interface PlayListVC : UIViewController
@property (nonatomic ,weak) id <ChangeCurrentPlayList> delegate;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@end
