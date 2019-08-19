//
//  ServerFileVC.m
//  FTPConnection
//
//  Created by Siya9 on 06/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ServerFileVC.h"
#import "LocalFileVC.h"
#import "ALToastView.h"

#import "FTPComunicacion.h"

@interface ServerFileVC ()

@property (nonatomic, strong) FTPControlerCteareDIR * objFTPControlerCteareDIR;
@property (nonatomic, strong) FTPControlerReceiveList * objFTPReceivedList;
@property (nonatomic, strong) FTPControlerWriteData * objFTPControlerWriteData;
@property (nonatomic, strong) NSArray * arrDirectoryList;
@property (nonatomic, weak) IBOutlet UITableView * tblListFolter;

@property (nonatomic, weak) IBOutlet UIView * viewCopy;
@property (nonatomic, weak) IBOutlet UIView * viewPast;

@property (nonatomic, weak) IBOutlet UILabel * lblFullPath;
@property (nonatomic, weak) IBOutlet UILabel * lblFolderName;


@end

@implementation ServerFileVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!self.strCurrentDirectory) {
        self.strCurrentDirectory = [[NSUserDefaults standardUserDefaults] objectForKey:@"FTPurl"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"serverPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    self.objFTPReceivedList = [FTPControlerReceiveList listOfDirectoryWith:self.strCurrentDirectory userID:self.FTPUserName userPassword:self.FTPPassword forDelegate:self];
}
-(void)receiveList:(NSArray *)arrDirectory {
    self.arrDirectoryList = arrDirectory.copy;
    [self.tblListFolter reloadData];
    [_objFTPReceivedList stopOpretion];
}
-(void)updateStatus:(FTPControler *)objFTPController WithError:(NSString *)error{
    [ALToastView toastInView:self.view withText:error];
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
        self.objFTPControlerCteareDIR = [FTPControlerCteareDIR createDirectoryWith:self.strCurrentDirectory directoryName:namefield.text userID:@"Siya9" userPassword:@"l" forDelegate:self];
        [self loadDirectory];
        [self.tblListFolter reloadData];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)createDirectory:(BOOL)isCreated {
    if (isCreated) {
        [self loadDirectory];
        [self.tblListFolter reloadData];
    }
    [_objFTPControlerCteareDIR stopOpretion];
}
-(IBAction)btnCopyTapped:(id)sender {
    NSIndexPath * indPath = [self.tblListFolter indexPathForSelectedRow];
    if (indPath) {
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indPath.row][@"kCFFTPResourceName"]];
        [[NSUserDefaults standardUserDefaults] setObject:strDirectory forKey:@"serverPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self viewWillAppear:TRUE];
        LocalFileVC * objLocalFileVC =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"LocalFileVC_sid"];
        objLocalFileVC.isPastFromServer = TRUE;
        [self.navigationController pushViewController:objLocalFileVC animated:TRUE];
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
-(IBAction)btnDownload:(id)sender {
    NSIndexPath * indPath = [self.tblListFolter indexPathForSelectedRow];
    if (indPath) {
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indPath.row][@"kCFFTPResourceName"]];
        [[NSUserDefaults standardUserDefaults] setObject:strDirectory forKey:@"serverPath"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self viewWillAppear:TRUE];
        LocalFileVC * objLocalFileVC =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"LocalFileVC_sid"];
        objLocalFileVC.isPastFromServer = TRUE;
        [self.navigationController pushViewController:objLocalFileVC animated:TRUE];
    }
}
-(IBAction)btnPastTapped:(id)sender {
    if (self.isPastFromLocal) {
        NSString * strLocalPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"localPath"];
        NSString * strServerPath = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,strLocalPath.lastPathComponent];

        self.objFTPControlerWriteData = [FTPControlerWriteData uploadFileToFTPPath:strServerPath fileLocalPath:strLocalPath userID:@"Siya9" userPassword:@"l" forDelegate:self];
    }
}
-(IBAction)backToLocalView:(id)sender {
    NSArray<UIViewController *> * arrVC = self.navigationController.viewControllers;
    for (int i = arrVC.count - 1; i >=0; i --) {
        if ([arrVC[i] isKindOfClass:[LocalFileVC class]]) {
            UIViewController * objVC = arrVC[i];
            [self.navigationController popToViewController:objVC animated:TRUE];
        }
    }
}
-(void)uploadFileTo:(NSString *)strPath;{
    UINavigationController * objNav = self.navigationController;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"localPath"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self backToLocalView:nil];
    [ALToastView toastInView:objNav.topViewController.view withText:@"Upload Complited"];
}

-(BOOL)isCopy {
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"serverPath"] || self.isPastFromLocal) {
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
    cell.textLabel.text = self.arrDirectoryList[indexPath.row][@"kCFFTPResourceName"];
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([self.arrDirectoryList[indexPath.row][@"kCFFTPResourceType"] intValue] == 4) {
        NSString * strDirectory = [NSString stringWithFormat:@"%@%@",self.strCurrentDirectory,self.arrDirectoryList[indexPath.row][@"kCFFTPResourceName"]];
        ServerFileVC * objLocalFileVC =
        [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"ServerFileVC_sid"];
        objLocalFileVC.strCurrentDirectory = [NSString stringWithFormat:@"%@/",strDirectory];
        objLocalFileVC.isPastFromLocal = self.isPastFromLocal;
        [self.navigationController pushViewController:objLocalFileVC animated:TRUE];
    }
}
-(NSString *)FTPUserName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FTPuser"];
}
-(NSString *)FTPPassword{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FTPpassword"];
}
@end
