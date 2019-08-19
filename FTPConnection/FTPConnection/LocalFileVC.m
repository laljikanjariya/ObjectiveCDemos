//
//  LocalFileVC.m
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "LocalFileVC.h"
#import "ServerFileVC.h"

#import "ALToastView.h"

#import "FTPComunicacion.h"

@interface LocalFileVC ()

@property (nonatomic, strong) FTPControlerReadData * objFTPControlerReadData;
@property (nonatomic, strong) FTPControlerWriteData * objFTPControlerWriteData;
@property (nonatomic, strong) NSArray * arrDirectoryList;
@property (nonatomic, weak) IBOutlet UITableView * tblListFolter;

@property (nonatomic, weak) IBOutlet UIView * viewCopy;
@property (nonatomic, weak) IBOutlet UIView * viewPast;

@property (nonatomic, weak) IBOutlet UILabel * lblFullPath;
@property (nonatomic, weak) IBOutlet UILabel * lblFolderName;

@end

@implementation LocalFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.strCurrentDirectory) {
        self.strCurrentDirectory = [NSString stringWithFormat:@"%@/",NSHomeDirectory()];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"localPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadDirectory];
    [self.tblListFolter reloadData];
    NSString * strRootPath = [self.strCurrentDirectory stringByReplacingOccurrencesOfString:NSHomeDirectory() withString:@""];
    strRootPath = [strRootPath stringByReplacingOccurrencesOfString:@"//" withString:@"/"];
    
    self.lblFullPath.text = strRootPath;
    self.lblFolderName.text = strRootPath.lastPathComponent;
    if (self.isCopy) {
        self.viewPast.hidden = FALSE;
        self.viewCopy.hidden = TRUE;
    }
    else{
        self.viewPast.hidden = TRUE;
        self.viewCopy.hidden = FALSE;
    }
}
-(void)loadDirectory{
    self.arrDirectoryList = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.strCurrentDirectory error:NULL];
}
-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:TRUE];
}
-(IBAction)home:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:TRUE];
}
-(IBAction)btnCreateFolderTapped:(id)sender {
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Folder Name"
                                                                              message: @"Input username and password"
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,namefield.text];
        [[NSFileManager defaultManager] createDirectoryAtPath:strDirectory withIntermediateDirectories:TRUE attributes:nil error:nil];
        [self loadDirectory];
        [self.tblListFolter reloadData];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(IBAction)btnCopyTapped:(id)sender {
    NSIndexPath * indPath = [self.tblListFolter indexPathForSelectedRow];
    if (indPath) {
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indPath.row]];
        [[NSUserDefaults standardUserDefaults] setObject:strDirectory forKey:@"localPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self viewWillAppear:TRUE];
    }
}
-(IBAction)btnDeleteTapped:(id)sender {
    NSIndexPath * indPath = [self.tblListFolter indexPathForSelectedRow];
    if (indPath) {
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indPath.row]];
        [[NSFileManager defaultManager] removeItemAtPath:strDirectory error:nil];
        [self loadDirectory];
        [self.tblListFolter reloadData];
    }
    else if (self.arrDirectoryList.count==0){
        [[NSFileManager defaultManager] removeItemAtPath:self.strCurrentDirectory error:nil];
        [self.navigationController popViewControllerAnimated:TRUE];
    }
}

-(IBAction)btnUploadTapped:(id)sender {    
    NSIndexPath * indPath = [self.tblListFolter indexPathForSelectedRow];
    if (indPath) {
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indPath.row]];
        [[NSUserDefaults standardUserDefaults] setObject:strDirectory forKey:@"localPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        ServerFileVC * objServerFileVC =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ServerFileVC_sid"];
        objServerFileVC.isPastFromLocal = TRUE;
        [self.navigationController pushViewController:objServerFileVC animated:TRUE];
    }
}



-(IBAction)btnPastTapped:(id)sender {
    if (self.isPastFromServer) {
        NSString * strServerPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"serverPath"];
        self.objFTPControlerReadData = [FTPControlerReadData downloadFileTo:strServerPath filePath:[NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,strServerPath.lastPathComponent] userID:self.FTPUserName userPassword:self.FTPPassword forDelegate:self];
    }
    else{
        NSString * strSouPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"localPath"];
        NSString * strSouFolder = [strSouPath stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@",strSouPath.lastPathComponent] withString:@""];
        
        if (![strSouFolder isEqualToString:self.strCurrentDirectory]) {
            NSString * strDestination = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,strSouPath.lastPathComponent];
            [[NSFileManager defaultManager]copyItemAtPath:strSouPath toPath:strDestination error:nil];
            [self loadDirectory];
            [self.tblListFolter reloadData];
        }
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"localPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self viewWillAppear:TRUE];
    }
}
-(IBAction)backToServerView:(id)sender {
    NSArray<UIViewController *> * arrVC = self.navigationController.viewControllers;
    for (int i = arrVC.count - 1; i >=0; i --) {
        if ([arrVC[i] isKindOfClass:[ServerFileVC class]]) {
            UIViewController * objVC = arrVC[i];
            [self.navigationController popToViewController:objVC animated:TRUE];
        }
    }
}
-(void)uploadFileTo:(NSString *)strPath;{
    UINavigationController * objNav = self.navigationController;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"serverPath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self backToServerView:nil];
    [ALToastView toastInView:objNav.topViewController.view withText:@"Download Complited"];
}

-(BOOL)isCopy {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"localPath"] || self.isPastFromServer) {
        return TRUE;
    }
    return FALSE;
}
#pragma mark - Table view data source -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrDirectoryList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.arrDirectoryList[indexPath.row];
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indexPath.row]];
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:strDirectory isDirectory:&isDirectory];
    if (fileExistsAtPath && isDirectory) {
        LocalFileVC * objLocalFileVC =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"LocalFileVC_sid"];
        objLocalFileVC.strCurrentDirectory = [NSString stringWithFormat:@"%@/",strDirectory];
        objLocalFileVC.isPastFromServer = self.isPastFromServer;
        [self.navigationController pushViewController:objLocalFileVC animated:TRUE];
    }
}
-(NSString *)FTPUserName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FTPuser"];
}
-(NSString *)FTPPassword{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FTPpassword"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
