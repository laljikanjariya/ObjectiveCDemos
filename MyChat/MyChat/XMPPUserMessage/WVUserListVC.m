//
//  WVUserListVC.m
//  WebVisionXMPPMessage
//
//  Created by Siya9 on 23/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "WVUserListVC.h"
//#import "XMPPUpdateManager.h"

#import <CoreData/CoreData.h>
#import "XMPPUserCoreDataStorageObject.h"

#import "DDLog.h"

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_INFO;
#endif
@interface WVUserListVC () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController * usersListRC;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, weak) IBOutlet UITableView * tblUserList;
@property (nonatomic, weak) IBOutlet UIView * indicater;
@end


@implementation WVUserListVC
- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [[ChatUpdateManager sharedInstance] managedObjectContext_roster];

    // Do any additional setup after loading the view.
}

-(IBAction)AddNewUser:(id)sender {
    self.usersListRC = nil;
    [self.tblUserList reloadData];
//    [[ChatUpdateManager sharedInstance] sendMessage:@"asdasdasdasdasda" toUserId:@""];
//    [[XMPPUpdateManager sharedInstance] connectWith:@"Lalji" andPassword:@""];
}

#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSArray *sections = self.usersListRC.sections;
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *sections = self.usersListRC.sections;
    id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userList" forIndexPath:indexPath];
    XMPPUserCoreDataStorageObject * userData = [self.usersListRC objectAtIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",userData.displayName];
    return cell;
}

#pragma mark - CoreData Methods

- (NSFetchedResultsController *)usersListRC {
    
    if (_usersListRC == nil)
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"XMPPUserCoreDataStorageObject"
                                                  inManagedObjectContext:self.managedObjectContext];

        
        NSSortDescriptor *sd1 = [[NSSortDescriptor alloc] initWithKey:@"sectionNum" ascending:YES];
        NSSortDescriptor *sd2 = [[NSSortDescriptor alloc] initWithKey:@"displayName" ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sd1, sd2, nil];
        
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        [fetchRequest setEntity:entity];
        [fetchRequest setSortDescriptors:sortDescriptors];
        [fetchRequest setFetchBatchSize:10];
        
        _usersListRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                       managedObjectContext:self.managedObjectContext
                                                                         sectionNameKeyPath:@"sectionNum"
                                                                                  cacheName:nil];
        [_usersListRC setDelegate:self];
        
        
        NSError *error = nil;
        if (![_usersListRC performFetch:&error])
        {
            DDLogError(@"Error performing fetch: %@", error);
        }
    }
    
    return _usersListRC;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblUserList beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    
    UITableView *tableView = self.tblUserList;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //            if(tableView.contentOffset.y >= (tableView.contentSize.height - tableView.frame.size.height - 50)) {
            //                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //                    [tableView scrollToRowAtIndexPath:newIndexPath atScrollPosition:UITableViewScrollPositionNone animated:TRUE];
            //                });
            //            }
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
            if ([[tableView indexPathsForVisibleRows] indexOfObject:indexPath] != NSNotFound) {
                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            }
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblUserList insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblUserList deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    [self.tblUserList endUpdates];
}

@end
