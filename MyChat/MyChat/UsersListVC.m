//
//  UsersListVC.m
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "UsersListVC.h"
#import "UserData.h"
#import "Messages.h"
#import "UsersMessagesVC.h"
#import "UserListCell.h"

@interface UsersListVC () <NSFetchedResultsControllerDelegate> {
    NSArray * arrStaticImages;
    NSArray * arrMessages;
}
@property (nonatomic, strong) NSFetchedResultsController * usersListRC;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, weak) IBOutlet UITableView * tblUsersList;
@property (nonatomic, strong) UsersMessagesVC * objUsersMessagesVC;
@property (nonatomic, weak) UserData * userMessage;
@end

@implementation UsersListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [ChatUpdateManager sharedInstance].managedObjectContext;
    
//    NSMutableArray * arrMessage = [NSMutableArray array];
//    [arrMessage addObject:@"Hiiiiiiiiiiiii"];
//    [arrMessage addObject:@"Hello"];
//    [arrMessage addObject:@"Are you ther ?."];
//    [arrMessage addObject:@"Fine."];
//    [arrMessage addObject:@"Hmmmmmmmmmm"];
//    [arrMessage addObject:@"Any Problrm ??????"];
//    [arrMessage addObject:@"GM"];
//    [arrMessage addObject:@"GN"];
//    [arrMessage addObject:@"SD"];
//    [arrMessage addObject:@"TC"];
//    [arrMessage addObject:@"Good Morning"];
//    
//    arrMessages = [[NSArray alloc]initWithArray:arrMessage];
//
//    
//    
//    NSMutableArray * arrImages = [NSMutableArray array];
//    [arrImages addObject:@"http://searchengineland.com/figz/wp-content/seloads/2015/01/google-slantg3-1920-800x450.jpg"];
//    [arrImages addObject:@"http://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/2324/skyline-buildings-new-york-skyscrapers.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/36487/above-adventure-aerial-air.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/5358/sea-beach-holiday-vacation.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/1848/nature-sunny-red-flowers.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/45911/peacock-plumage-bird-peafowl-45911.jpeg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/9574/pexels-photo.jpeg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/625/field-summer-sun-meadow.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/1341/blue-abstract-glass-balls.jpg"];
//    [arrImages addObject:@"https://static.pexels.com/photos/96920/pexels-photo-96920.jpeg"];
//    
//    arrStaticImages = [[NSArray alloc]initWithArray:arrImages];
//    
//    [self setData];
//    [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(ChangeUserStatus) userInfo:nil repeats:YES];

}
-(void)setData{
    if ([[LiveUpdateManager fetchEntityWithName:@"UserData" key:@"uID" value:@(1) shouldCreate:FALSE moc:self.managedObjectContext] firstObject] == nil) {
        [self setuserName:@"Lalji." Surname:@"Kanjariya." isActived:@(1) withUserid:@(1)];
        [self setuserName:@"Hiro" Surname:@"Patel" isActived:@(1) withUserid:@(2)];
        [self setuserName:@"Rajni" Surname:@"Vaniya" isActived:@(1) withUserid:@(3)];
        [self setuserName:@"Harsh" Surname:@"Patel" isActived:@(1) withUserid:@(4)];
        [self setuserName:@"Hitu" Surname:@"Chavda" isActived:@(1) withUserid:@(5)];
        [self setuserName:@"Vimal" Surname:@"Lakum" isActived:@(1) withUserid:@(6)];
    }
}
-(void)ChangeUserStatus{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Messages" inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    
    UserCurrentStatus userChanged = [ChatUpdateManager getRendomNumber:0 toMax:3].intValue;
    
    NSNumber * userId = [ChatUpdateManager getRendomNumber:2 toMax:[ChatUpdateManager countForEntity:@"UserData"].intValue];
    userId = @(2);
    UserData * userData = [[LiveUpdateManager fetchEntityWithName:@"UserData" key:@"uID" value:userId shouldCreate:false moc:self.managedObjectContext] firstObject];
    if (userData == nil) {
        NSLog(@"%ld",(long)[ChatUpdateManager countForEntity:@"UserData"].integerValue);
    }
    switch (userChanged) {
        case UserCurrentStatusOffLine: {
            userData.userStatus = @(UserCurrentStatusOffLine);
            break;
        }
        case UserCurrentStatusOnLine: {
            userData.userStatus = @(UserCurrentStatusOnLine);
            break;
        }
        case UserCurrentStatusIsTyping: {
            userData.userStatus = @(UserCurrentStatusIsTyping);
            break;
        }
    }
    [LiveUpdateManager saveContext:self.managedObjectContext];
}

-(void)setuserName:(NSString *)strname Surname:(NSString *)sName isActived:(NSNumber *)isActive withUserid:(NSNumber *)uID{
    UserData * save = (UserData *)[[LiveUpdateManager fetchEntityWithName:@"UserData" key:@"uID" value:uID shouldCreate:YES moc:[ChatUpdateManager sharedInstance].managedObjectContext] firstObject];
    save.fName = strname;
    save.lName = sName;
    save.uID = uID;
//    save.pImage = [arrStaticImages objectAtIndex:[ChatUpdateManager getRendomNumber:0 toMax:(int)arrStaticImages.count].intValue];
    save.pImage = @"http://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg";
    save.userStatus = isActive;
    save.lastActiveTime = [NSDate date];
    [LiveUpdateManager saveContext:self.managedObjectContext];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    UserListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"userList" forIndexPath:indexPath];
    UserData * userData = [self.usersListRC objectAtIndexPath:indexPath];
    cell.lblUserName.text = [NSString stringWithFormat:@"%@ %@",userData.fName,userData.lName];
    if ([[userData.pImage getUserProfileImagePath] isFileExist]) {
        NSString * strImagePath = [userData.pImage getUserProfileImagePath];
        
        UIImage *thumbNail = [[UIImage alloc]initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:strImagePath]]];

        cell.imgUser.image = thumbNail;
    }
    else{
        cell.imgUser.image = [UIImage imageNamed:@"user_default.png"];
        DDFileInfo * objFile = [DDFileManager addToDownloadUserImageWithUrl:userData.pImage];
        CompletionHandler completionHandler = ^(id response, NSError *error) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [tableView reloadRowsAtIndexPaths:@[response] withRowAnimation:UITableViewRowAnimationAutomatic];
            });
        };
        [objFile addNewResponce:indexPath withComplication:completionHandler];
        [DDFileManager startDownloadForFile:objFile];
    }
    int count = (int)userData.myUnreadMessages.count;
    cell.lblUnreadMsgCount.hidden = TRUE;
    if (count > 0) {
        cell.lblUnreadMsgCount.text = [NSString stringWithFormat:@"%d",count];
        cell.lblUnreadMsgCount.hidden = FALSE;
    }

    if (userData.userStatus.integerValue == UserCurrentStatusIsTyping) {
        cell.lblMessageOrTime.text = @"Typing.....";
        cell.lblMessageOrTime.textColor = [UIColor colorWithRed:0.271 green:0.916 blue:0.000 alpha:1.000];
        cell.lblUnreadMsgCount.backgroundColor = [UIColor colorWithRed:0.365 green:0.859 blue:0.294 alpha:1.000];
    }
    else{
        if (userData.userStatus.integerValue == UserCurrentStatusOnLine) {
            cell.lblMessageOrTime.text = userData.lastMessage.stringMessage;
            cell.lblMessageOrTime.textColor = [UIColor colorWithRed:0.000 green:0.638 blue:1.000 alpha:1.000];
            cell.lblUnreadMsgCount.backgroundColor = [UIColor colorWithRed:0.365 green:0.859 blue:0.294 alpha:1.000];
        }
        else{
            cell.lblMessageOrTime.text = [NSString stringWithFormat:@"Last seen %@",userData.lastActiveTime.dateAndTimeOfDate];
            cell.lblMessageOrTime.textColor = [UIColor colorWithRed:0.879 green:0.345 blue:0.000 alpha:1.000];
            cell.lblUnreadMsgCount.backgroundColor = [UIColor colorWithRed:0.859 green:0.365 blue:0.294 alpha:1.000];
        }
    }
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UserData * fromUser = [self.usersListRC objectAtIndexPath:indexPath];
    if (!self.objUsersMessagesVC) {
        self.objUsersMessagesVC =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"UsersMessagesVC_sid"];
        if ([ChatUpdateManager sharedInstance].userLoged == nil) {
            [ChatUpdateManager sharedInstance].userLoged = [[LiveUpdateManager fetchEntityWithName:@"UserData" key:@"uID" value:@(1) shouldCreate:FALSE moc:self.managedObjectContext] firstObject];
        }
        self.objUsersMessagesVC.toUser = [ChatUpdateManager sharedInstance].userLoged;
    }
    self.objUsersMessagesVC.fromUser= fromUser;
    self.userMessage = fromUser;
    [self.navigationController pushViewController:self.objUsersMessagesVC animated:TRUE];
}

#pragma mark - CoreData Methods

- (NSFetchedResultsController *)usersListRC {
    
    if (_usersListRC != nil) {
        return _usersListRC;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserData" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSPredicate *isDisplayInPosPredicate = [NSPredicate predicateWithFormat:@"uID > 1"];
    [fetchRequest setPredicate:isDisplayInPosPredicate];
//
    NSSortDescriptor * aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastActiveTime" ascending:TRUE];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _usersListRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [_usersListRC performFetch:nil];
    _usersListRC.delegate = self;
    return _usersListRC;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblUsersList beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    if (self.objUsersMessagesVC && [self.userMessage isEqual:anObject]) {
        self.objUsersMessagesVC.fromUser = self.userMessage;
    }
    UITableView *tableView = self.tblUsersList;
    
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
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblUsersList insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblUsersList deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.usersListRC]) {
        return;
    }
    [self.tblUsersList endUpdates];
}

@end
