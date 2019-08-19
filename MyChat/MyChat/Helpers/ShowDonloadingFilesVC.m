//
//  ShowDonloadingFilesVC.m
//  MyChat
//
//  Created by Siya9 on 19/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ShowDonloadingFilesVC.h"

@implementation ShowDonloadingFilesVC

//
//- (void)viewDidLoad {
//    // Do any additional setup after loading the view.
//    self.objDataDownloader = [DataDownloader sharedInstance];
//    
//    FileInfo * objFile1 = [DataDownloader addToDownloadUserImageWithUrl:@"http://raagtune.org//music/data/Hindi%20Movies/Refugee-(Sukhwinder%20Singh)/Jise%20Tu%20Na%20Mila-Sukhwinder%20Singh::Raag.Me::.mp3"];
//    CompletionHandler completionHandler1 = ^(id response, NSError *error) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"Download Done");
//            [_tblDownloadList reloadData];
//        });
//    };
//    [objFile1 addNewResponce:@"Lalji1" withComplication:completionHandler1];
//
//    FileInfo * objFile = [DataDownloader addToDownloadUserImageWithUrl:@"http://dl.gaana99.com/files/data/4605/01%20The%20Sound%20of%20Raaz%20-%20Raaz%20Reboot.mp3"];
//    CompletionHandler completionHandler = ^(id response, NSError *error) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            NSLog(@"Download Done");
//            [_tblDownloadList reloadData];
//        });
//    };
//    [objFile addNewResponce:@"Lalji" withComplication:completionHandler];
//}
//
//
//-(IBAction)backBtnTapped:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
//}
//
//
//#pragma mark - Table view data source -
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    // Return the number of rows in the section.
//    return self.objDataDownloader.arrDownloadList.count;
//}
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    
//    FileInfo * objFile = [self.objDataDownloader.arrDownloadList objectAtIndex:indexPath.row];
//    cell.textLabel.text = objFile.strName;
//    cell.detailTextLabel.text = @"0.0 %";
//    objFile.progressHandler = ^(float fltProgress){
//        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f %%",fltProgress*100];
//    };
//    return cell;
//}
//// Called after the user changes the selection.
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}



- (void)viewDidLoad {
    // Do any additional setup after loading the view.
    self.objDataDownloader = [DDFileManager sharedInstance];
    
    DDFileInfo * objFile1 = [DDFileManager addToDownloadUserImageWithUrl:@"http://raagtune.org//music/data/Hindi%20Movies/Refugee-(Sukhwinder%20Singh)/Jise%20Tu%20Na%20Mila-Sukhwinder%20Singh::Raag.Me::.mp3"];
    CompletionHandler completionHandler1 = ^(id response, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Download error %@",error.localizedDescription);
            }
            else{
                NSLog(@"Download Done");
                [_tblDownloadList reloadData];
            }
            [UIApplication sharedApplication].applicationIconBadgeNumber = 2;
        });
    };
    [objFile1 addNewResponce:@"Lalji1" withComplication:completionHandler1];
    [DDFileManager startDownloadForFile:objFile1];
    DDFileInfo * objFile = [DDFileManager addToDownloadUserImageWithUrl:@"http://dl.gaana99.com/files/data/4605/01%20The%20Sound%20of%20Raaz%20-%20Raaz%20Reboot.mp3"];
    CompletionHandler completionHandler = ^(id response, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (error) {
                NSLog(@"Download error %@",error.localizedDescription);
            }
            else{
                NSLog(@"Download Done");
                [_tblDownloadList reloadData];
            }
            [UIApplication sharedApplication].applicationIconBadgeNumber = 2;
        });
    };
    [objFile addNewResponce:@"Lalji" withComplication:completionHandler];
    [DDFileManager startDownloadForFile:objFile];
}


-(IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.objDataDownloader.arrDownloadList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    DDFileInfo * objFile = [self.objDataDownloader.arrDownloadList objectAtIndex:indexPath.row];
    cell.textLabel.text = objFile.strName;
    cell.detailTextLabel.text = @"0.0 %";
    objFile.progressHandler = ^(float fltProgress){
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2f %%",fltProgress*100];
    };
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DDFileInfo * objFile = [self.objDataDownloader.arrDownloadList objectAtIndex:indexPath.row];
    if (objFile.isDownloading) {
        [DDFileManager pushDownloadForFile:objFile];
    }
    else{
        [DDFileManager startDownloadForFile:objFile];
    }
}
@end
