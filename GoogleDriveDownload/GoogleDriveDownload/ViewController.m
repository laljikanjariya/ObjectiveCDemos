//
//  ViewController.m
//  GoogleDriveDownload
//
//  Created by Siya-ios5 on 9/28/17.
//  Copyright © 2017 Siya-ios5. All rights reserved.
//

#import "ViewController.h"
#import "RapidGoogleDriveOperation.h"
#import "GoogleDriveFile.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray <GoogleDriveFile *> * arrFiles;
@property (nonatomic, strong) IBOutlet GIDSignInButton *signInButton;
@property (nonatomic, strong) RapidGoogleDriveOperation *gDOperation;
@property (nonatomic, weak) IBOutlet UITableView * tblEDIFiels;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gDOperation = [[RapidGoogleDriveOperation alloc] init];
    [self.gDOperation signIn:^(bool isSignIn, GIDGoogleUser *user, NSError *error) {
        if (isSignIn) {
            [self fetchFilesFromDrive];
            self.signInButton.hidden = true;
        }
        else{
            self.signInButton = [[GIDSignInButton alloc] init];
            [self.view addSubview:self.signInButton];
        }

    } withUIDelegate:self];
}
-(void)fetchFilesFromDrive{
    [self.gDOperation googleDriveFiles:^(NSError *error, NSMutableArray <GoogleDriveFile *>*files) {
        self.arrFiles = files;
        [self.tblEDIFiels reloadData];
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrFiles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EDIFilesCell *cell = (EDIFilesCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    GoogleDriveFile * file = self.arrFiles[indexPath.row];
    cell.lblEDIName.text = file.name;
    
    cell.btnDownload.tag = indexPath.row;
    cell.btnOpen.tag = indexPath.row;
    
    switch (file.status) {
        case 0:
            cell.lblEDIStatus.text = @"Not Download";
            cell.btnDownload.hidden = FALSE;
            cell.btnOpen.hidden = TRUE;
            break;
        case 1:
            cell.lblEDIStatus.text = @"Downloading";
            cell.btnDownload.hidden = TRUE;
            cell.btnOpen.hidden = TRUE;
            break;
        case 2:
            cell.lblEDIStatus.text = @"Downloaded";
            cell.btnDownload.hidden = TRUE;
            cell.btnOpen.hidden = FALSE;
            break;
        case 3:
            cell.lblEDIStatus.text = @"Error In Downloding";
            cell.btnDownload.hidden = FALSE;
            cell.btnOpen.hidden = TRUE;
            break;
        default:
            break;
    }
    
    return cell;
}
-(IBAction)btnDownload:(UIButton *)sender {
    
    GoogleDriveFile * file = self.arrFiles[sender.tag];
    [file downloadFor:self.gDOperation.service responce:^(bool isDownload) {
        [self.tblEDIFiels reloadData];
    }];
    [self.tblEDIFiels reloadData];
}
-(IBAction)btnOpen:(UIButton *)sender {
    
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
@implementation EDIFilesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
