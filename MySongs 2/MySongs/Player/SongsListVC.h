//
//  SongsListVC.h
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayLists.h"

@interface SongsListVC : UIViewController <UITableViewDataSource,UITableViewDelegate>
{
    
}
@property (nonatomic,weak) PlayLists * selectedPlayList;
@property (nonatomic,weak) IBOutlet UITableView * tblList;
@property (nonatomic, strong) NSFetchedResultsController *itemDilspayPalyListRC;
@property (nonatomic) BOOL isEditing;
@end
