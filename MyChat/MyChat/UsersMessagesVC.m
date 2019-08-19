//
//  UsersMessagesVC.m
//  MyChat
//
//  Created by Siya9 on 11/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "UsersMessagesVC.h"
#import "MessageListCell.h"
#import "UsersListVC.h"
#import "ShowDonloadingFilesVC.h"
#import "ImageMessageDetailVC.h"

@interface UsersMessagesVC () <NSFetchedResultsControllerDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,MidiaDownloadCellDelegate> {
    NSArray * arrMessages;
    NSArray * arrImgMessages;
}
@property (nonatomic, strong) NSFetchedResultsController * userMessageRC;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, weak) IBOutlet UITableView * tblUserMessagesList;
@property (nonatomic, weak) IBOutlet UITextField * txtMessage;
@property (nonatomic, weak) IBOutlet UILabel * lblUserName;
@property (nonatomic, weak) IBOutlet UILabel * lblUserStatus;
@property (nonatomic, weak) IBOutlet NSLayoutConstraint * keyboardHeight;
@end

@implementation UsersMessagesVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [ChatUpdateManager sharedInstance].managedObjectContext;
    self.tblUserMessagesList.estimatedRowHeight = 70;
    [self observeKeyboard];
    [self setData];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    [self moveToLastRowWith:false];
    [self changeUserStatus];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setFromUser:(UserData *)fromUser{
    _fromUser = fromUser;
    [self changeUserStatus];
    self.userMessageRC = nil;
    [self.tblUserMessagesList reloadData];
}
#pragma mark - KeyBoard -
- (void)observeKeyboard {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSValue *kbFrame = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect keyboardFrame = [kbFrame CGRectValue];
    
    CGFloat height = keyboardFrame.size.height;

    self.keyboardHeight.constant = height;
    [self moveToLastRowWith:FALSE];
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    NSDictionary *info = [notification userInfo];
    NSTimeInterval animationDuration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    self.keyboardHeight.constant = 0;
    [UIView animateWithDuration:animationDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)changeUserStatus{
    self.lblUserName.text = [NSString stringWithFormat:@"%@ %@",self.fromUser.fName,self.fromUser.lName];
    if (self.fromUser.userStatus.integerValue == UserCurrentStatusIsTyping) {
        self.lblUserStatus.text = @"Typing.....";
    }
    else{
        if (self.fromUser.userStatus.integerValue == UserCurrentStatusOnLine) {
            self.lblUserStatus.text = @"Available";
        }
        else{
            self.lblUserStatus.text = [NSString stringWithFormat:@"Last seen %@",self.fromUser.lastActiveTime.dateAndTimeOfDate];
        }
    }
}
-(IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Add Attechment -
-(IBAction)addAttachment:(id)sender {
//    ShowDonloadingFilesVC * objShowDonloadingFilesVC =
//    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ShowDonloadingFilesVC_sid"];
//    
//    [self.navigationController pushViewController:objShowDonloadingFilesVC animated:TRUE];
    SelectUserOptionVC * selectUserOptionVC = [SelectUserOptionVC setSelectionViewitem:@[@"Image Galary",@"Image Camera",@"Video Galary"] OptionId:@(0) isMultipleSelectionAllow:false SelectionComplete:^(NSArray *arrSelection) {
        if ([arrSelection containsObject:@"Image Galary"] || [arrSelection containsObject:@"Image Camera"]) {
            [self addMessageWithType:2 ToUser:self.fromUser fromUser:self.toUser];
        }
        else{
            [self addMessageWithType:3 ToUser:self.fromUser fromUser:self.toUser];
        }
        
    } SelectionColse:^(UIViewController * popUpVC){
        [[popUpVC presentingViewController] dismissViewControllerAnimated:YES completion:NULL];
    }];
    selectUserOptionVC.isHideBorder = TRUE;
    [selectUserOptionVC presentViewControllerForviewConteroller:self sourceView:sender ArrowDirection:UIPopoverArrowDirectionUp];
}
-(void)showImagePickerViewforType:(UIImagePickerControllerSourceType)imageType withcameraCaptureMode:(UIImagePickerControllerCameraCaptureMode)cameraCaptureMode {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = imageType;
    picker.cameraCaptureMode = cameraCaptureMode;
    [self presentViewController:picker animated:YES completion:NULL];
}
#pragma mark - UITextFieldDelegate -

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self sendMessageTapped:nil];
    return YES;
}
#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSArray *sections = self.userMessageRC.sections;
    return sections.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *sections = self.userMessageRC.sections;
    id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
    static NSString *headerReuseIdentifier = @"HeaderView";
    
    MessageListCell *sectionHeaderView = (MessageListCell *)[tableView dequeueReusableCellWithIdentifier:headerReuseIdentifier forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    sectionHeaderView.lblTime.text = [NSString stringWithFormat:@"  %@  ",sectionInfo.name];
    sectionHeaderView.contentView.backgroundColor = [UIColor clearColor];

    return sectionHeaderView.contentView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *sections = self.userMessageRC.sections;
    id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
    return sectionInfo.numberOfObjects;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Messages * objMessage = [self.userMessageRC objectAtIndexPath:indexPath];
    MessageListCell *cell = [tableView dequeueReusableCellWithIdentifier:[self cellIndentifier:objMessage] forIndexPath:indexPath];
    cell.objTableview = tableView;
    cell.delegate = self;
    [cell setUpCellForMessage:objMessage];
    return cell;
}

-(NSString *)cellIndentifier:(Messages *)objMessage{
    NSString * strCellIndentifier = @"";
    if (objMessage.fromMsg.intValue == [ChatUpdateManager sharedInstance].userLoged.uID.intValue) {
        MessageType messageType = objMessage.messageType.intValue;
        switch (messageType) {
            case MessageTypeString:
                strCellIndentifier = @"messageList";
                break;
            case MessageTypeImage:
                strCellIndentifier = @"imgMessageList";
                break;
            case MessageTypeVideo:
                strCellIndentifier = @"imgMessageList";
                break;
            case MessageTypeAudio:
                strCellIndentifier = @"";
                break;
        }
    }
    else{
        MessageType messageType = objMessage.messageType.intValue;
        switch (messageType) {
            case MessageTypeString:
                strCellIndentifier = @"otherMessageList";
                break;
            case MessageTypeImage:
                strCellIndentifier = @"otherImgMessageList";
                break;
            case MessageTypeVideo:
                strCellIndentifier = @"otherImgMessageList";
                break;
            case MessageTypeAudio:
                strCellIndentifier = @"";
                break;
        }
    }
    return strCellIndentifier;
}

#pragma mark - MidiaDownloadCellDelegate -
-(void)messageMediaDownloadwith:(id) response downloadError:(NSError *)error{
    [self.tblUserMessagesList reloadRowsAtIndexPaths:@[response] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)showMessageDetailAt:(NSIndexPath *)indexPath{
    Messages * objMessage = [self.userMessageRC objectAtIndexPath:indexPath];
    ImageMessageDetailVC * imageMessageDetailVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ImageMessageDetailVC_sid"];
    imageMessageDetailVC.objMessages = objMessage;
    [self.navigationController pushViewController:imageMessageDetailVC animated:FALSE];
}
-(void)moveToLastRowWith:(BOOL)isAnimation{
//    if (self.userMessageRC.fetchedObjects.count > 0) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSInteger section = [self numberOfSectionsInTableView:self.tblUserMessagesList];
//            NSInteger row = [self tableView:self.tblUserMessagesList numberOfRowsInSection:section-1];
//            [self.tblUserMessagesList scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row-1 inSection:section-1] atScrollPosition:UITableViewScrollPositionBottom animated:isAnimation];
//        });
//    }
}

#pragma mark - Send Message -
-(IBAction)sendMessageTapped:(id)sender {
    if (self.txtMessage.text.length > 0) {
        [ChatUpdateManager addNewStringMessage:self.txtMessage.text ToUser:self.fromUser fromUser:self.toUser isSent:@(1) isSeeen:@(0) moc:self.managedObjectContext];
        self.txtMessage.text =@"";
        [self setReplayToUser];
    }
}

-(void)setReplayToUser{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        int messageType = [[ChatUpdateManager getRendomNumber:1 toMax:3] intValue];
        [self addMessageWithType:messageType ToUser:self.toUser fromUser:self.fromUser];
    });
}
-(void)addMessageWithType:(int)msgType ToUser:(UserData *)toUser fromUser:(UserData *)fromUser{
    switch (msgType) {
        case 1:
            [ChatUpdateManager addNewStringMessage:[arrMessages objectAtIndex:[self getRendomNumber:0 toMax:(int)arrMessages.count].intValue] ToUser:toUser fromUser:fromUser isSent:@(1) isSeeen:@(0) moc:self.managedObjectContext];
            break;
        case 2:
            [ChatUpdateManager addNewImageMessage:[arrImgMessages objectAtIndex:[ChatUpdateManager getRendomNumber:0 toMax:(int)arrImgMessages.count].intValue] ToUser:toUser fromUser:fromUser isSent:@(1) isSeeen:@(0) moc:self.managedObjectContext];
            break;
        case 3:
            
//            [ChatUpdateManager addNewVideoMessage:@"http://www.steppublishers.com/sites/default/files/stepteen2.mp4" ToUser:toUser fromUser:fromUser isSent:@(1) isSeeen:@(0) moc:self.managedObjectContext];
            [ChatUpdateManager addNewVideoMessage:@"http://cdn.ql.vc/upload_file/Videos/MP4/New%20Bollywood%20Mp4%20Videos%20(2016)/Ek%20Kahani%20Julie%20Ki%20(2016)%20Mp4%20Videos/O%20Re%20Piya%20-%20Ek%20Kahani%20Julie%20Ki%20-%20MP4.mp4" ToUser:toUser fromUser:fromUser isSent:@(1) isSeeen:@(0) moc:self.managedObjectContext];
            break;
            
        default:
            NSLog(@"messageType %d",msgType);
            break;
    }
}

-(NSNumber *)getRendomNumber:(int)min toMax:(int)max{
    int lowerBound = min;
    int upperBound = max;
    return @(lowerBound + arc4random() % (upperBound - lowerBound));
}

-(NSNumber *)getNewMessageId{
    NSNumber * intLastMessage = [self countForEntity:@"Messages"];
    return @(intLastMessage.intValue + 1);
}
-(NSNumber *)countForEntity:(NSString *)strEntity{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:strEntity inManagedObjectContext:self.managedObjectContext];
    fetchRequest.entity = entity;
    return @([LiveUpdateManager countForContext:self.managedObjectContext FetchRequest:fetchRequest]);
}


#pragma mark - CoreData Methods

- (NSFetchedResultsController *)userMessageRC {
    
    if (_userMessageRC != nil) {
        return _userMessageRC;
    }
    
    // Create and configure a fetch request with the Book entity.
    //   NSString *sortColumn=@"item_Desc";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Messages" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    
    NSPredicate *isDisplayInPosPredicate = [NSPredicate predicateWithFormat:@"(fromMsg == %@ AND toMsg == 1)OR(fromMsg == 1 AND toMsg == %@)",self.fromUser.uID,self.fromUser.uID];
    [fetchRequest setPredicate:isDisplayInPosPredicate];
    //
    NSSortDescriptor * aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sendTime" ascending:TRUE];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _userMessageRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:@"sectionKey" cacheName:nil];
    
    [_userMessageRC performFetch:nil];
    _userMessageRC.delegate = self;
    return _userMessageRC;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.userMessageRC]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblUserMessagesList beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.userMessageRC]) {
        return;
    }
    
    UITableView *tableView = self.tblUserMessagesList;
    
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
    if (![controller isEqual:self.userMessageRC]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblUserMessagesList insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblUserMessagesList deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.userMessageRC]) {
        return;
    }
    [self.tblUserMessagesList endUpdates];
}
-(void)setData{
    NSMutableArray * arrmessage = [NSMutableArray array];
    [arrmessage addObject:@"Hiiiiiiiiiiiii"];
    [arrmessage addObject:@"Hello"];
    [arrmessage addObject:@"Are you ther ?."];
    [arrmessage addObject:@"Fine."];
    [arrmessage addObject:@"Hmmmmmmmmmm"];
    [arrmessage addObject:@"Any Problrm ??????"];
    [arrmessage addObject:@"GM"];
    [arrmessage addObject:@"GN"];
    [arrmessage addObject:@"SD"];
    [arrmessage addObject:@"TC"];
    [arrmessage addObject:@"Good Morning"];
    
    arrMessages = [[NSArray alloc]initWithArray:arrmessage];
    
    NSMutableArray * arrImages = [NSMutableArray array];
    [arrImages addObject:@"http://searchengineland.com/figz/wp-content/seloads/2015/01/google-slantg3-1920-800x450.jpg"];
    [arrImages addObject:@"http://cdn.tutsplus.com/mobile/uploads/2013/12/sample.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/2324/skyline-buildings-new-york-skyscrapers.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/36487/above-adventure-aerial-air.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/5358/sea-beach-holiday-vacation.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/1848/nature-sunny-red-flowers.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/45911/peacock-plumage-bird-peafowl-45911.jpeg"];
    [arrImages addObject:@"https://static.pexels.com/photos/9574/pexels-photo.jpeg"];
    [arrImages addObject:@"https://static.pexels.com/photos/625/field-summer-sun-meadow.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/1341/blue-abstract-glass-balls.jpg"];
    [arrImages addObject:@"https://static.pexels.com/photos/96920/pexels-photo-96920.jpeg"];
    
    arrImgMessages = [[NSArray alloc]initWithArray:arrImages];
}
@end
