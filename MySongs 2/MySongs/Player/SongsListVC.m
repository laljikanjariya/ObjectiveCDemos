//
//  SongsListVC.m
//  MySongs
//
//  Created by Siya Infotech on 25/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "SongsListVC.h"
#import "DatabaseManager.h"
#import "Constants.h"

@interface SongsListVC () <NSFetchedResultsControllerDelegate>
{
    IBOutlet UITextField * txtSongName;
}
@property (nonatomic, strong) NSFetchedResultsController *itemPlayingPalyListRC;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;

@end

@implementation SongsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [DatabaseManager sharedInstance].managedObjectContext;
    if (!self.isEditing) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(nextSongPlay:) name:PLAYER_CHANGE_NEXT_SONG object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(prevSongPlay:) name:PLAYER_CHANGE_PREV_SONG object:nil];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UITextFieldDelegate -

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    self.itemDilspayPalyListRC = nil;
    [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:string]];
    [self.tblList reloadData];
    return NO;
}
- (BOOL)textFieldShouldClear:(UITextField *)textField{               // called when clear button pressed. return NO to ignore (no notifications)
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

-(void)setSelectedPlayList:(PlayLists *)selectedPlayList {
    self.itemDilspayPalyListRC = nil;
    _selectedPlayList = selectedPlayList;
    [self.tblList reloadData];
}
-(void)nextSongPlay:(NSNotification *)notification {
    [self playSongWithNextPrev:1 withManageContextID:notification.object];
}
-(void)prevSongPlay:(NSNotification *)notification {
    [self playSongWithNextPrev:-1 withManageContextID:notification.object];
}
-(void)playSongWithNextPrev:(int)value withManageContextID:(NSManagedObjectID *) objectID{

    Songs * currentSonf = [self.managedObjectContext objectWithID:objectID];
    NSIndexPath * indexPath = [self.itemPlayingPalyListRC indexPathForObject:currentSonf];
    int number = (indexPath.row + value);
    if (number < 0 || number >= [self numberofObjectInCurrentPlayingList]) {
        number = 0;
    }
    NSIndexPath * nextSongIndexPath = [NSIndexPath indexPathForRow:number inSection:indexPath.section];
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYER_CHANGE_SONG object:[self.itemPlayingPalyListRC objectAtIndexPath:nextSongIndexPath]];
    [self sendActivity:@"1" withMessage:@"Change Current playing song"];
    if ([self.itemPlayingPalyListRC isEqual:self.itemDilspayPalyListRC]) {
        [self.tblList reloadRowsAtIndexPaths:@[indexPath,nextSongIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
-(void)sendActivity:(NSString *)isSucces withMessage:(NSString *)strMessage{
    NSDictionary * dictActivity = @{@"isSeccue":isSucces,@"message":strMessage};
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYER_SHOW_ACTIVITY object:dictActivity];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSArray *sections = [self.itemDilspayPalyListRC sections];
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *sections = [self.itemDilspayPalyListRC sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
    
}
- (NSInteger)numberofObjectInCurrentPlayingList {
    // Return the number of rows in the section.
    NSArray *sections = [self.itemPlayingPalyListRC sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:0];
    return [sectionInfo numberOfObjects];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Songs * songInfo = [self.itemDilspayPalyListRC objectAtIndexPath:indexPath];
    cell.textLabel.text = songInfo.name;
    NSString * strDuration;
    NSNumber * time = songInfo.duration;
    if ([time floatValue] > 0) {
        int mm = (int)[time floatValue]/60;
        int ss = (int)[time floatValue] - (mm*60);
        strDuration = [NSString stringWithFormat:@"Duration :%.2d:%.2d",mm,ss];
    }
    else {
        [NSString stringWithFormat:@"Duration :--:--"];
    }
    NSString * strSongName = [[NSUserDefaults standardUserDefaults] valueForKey:PLAYER_CURRENT_PLAYING_SONG_NAME];
    
    if ([songInfo.name isEqualToString:strSongName]) {
        cell.imageView.image = [UIImage imageNamed:@"play_btn.png"];
    }
    else {
        cell.imageView.image = [UIImage imageNamed:@"stop_btn.png"];
    }
    cell.detailTextLabel.text = strDuration;
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Songs * songInfo = [self.itemDilspayPalyListRC objectAtIndexPath:indexPath];
        [QueryManager deleteObject:songInfo withContext:self.managedObjectContext isSave:YES];
    }
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Songs * sonfInfo = [self.itemDilspayPalyListRC objectAtIndexPath:indexPath];
    _itemPlayingPalyListRC = self.itemDilspayPalyListRC;
    [self playSongWithNextPrev:0 withManageContextID:sonfInfo.objectID];
}

#pragma mark - CoreData Methods
- (NSFetchedResultsController *)itemDilspayPalyListRC {
    
    if (_itemDilspayPalyListRC != nil) {
        return _itemDilspayPalyListRC;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Songs" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    if (self.isEditing) {
        if (txtSongName.text.length>0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@",txtSongName.text];
            [fetchRequest setPredicate:predicate];
        }
    }
    else {
        if (txtSongName.text.length>0) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@ AND ANY palylist = %@",txtSongName.text,self.selectedPlayList];
            [fetchRequest setPredicate:predicate];
        }
        else if (self.selectedPlayList) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY palylist = %@",self.selectedPlayList];
            [fetchRequest setPredicate:predicate];
        }
    }
    // Create the sort descriptors array.
    NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    _itemDilspayPalyListRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    [_itemDilspayPalyListRC performFetch:nil];
    _itemDilspayPalyListRC.delegate = self;
    if (!_itemPlayingPalyListRC) {
        _itemPlayingPalyListRC = _itemDilspayPalyListRC;
    }
    return _itemDilspayPalyListRC;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.itemDilspayPalyListRC] && ![self.itemPlayingPalyListRC isEqual:self.itemDilspayPalyListRC]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblList beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.itemDilspayPalyListRC] && ![self.itemPlayingPalyListRC isEqual:self.itemDilspayPalyListRC]) {
        return;
    }
    
    UITableView *tableView = self.tblList;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
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
    if (![controller isEqual:self.itemDilspayPalyListRC] && ![self.itemPlayingPalyListRC isEqual:self.itemDilspayPalyListRC]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblList insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblList deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.itemDilspayPalyListRC] && ![self.itemPlayingPalyListRC isEqual:self.itemDilspayPalyListRC]) {
        return;
    }
    [self.tblList endUpdates];
}
@end
