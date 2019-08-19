//
//  ViewController.m
//  AddressBook
//
//  Created by Siya Infotech on 26/11/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "ViewController.h"
#import "AddressBookGeter.h"
#import <ContactsUI/ContactsUI.h>
#import "AppDelegate.h"

@interface ViewController ()<CNContactPickerDelegate,CNContactViewControllerDelegate>
{
    NSMutableArray * arrContectList;
    IBOutlet UITableView * tblContectList;
    AddressBookGeter * addresBook;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    addresBook =[AddressBookGeter addressBookContect:^(BOOL optestion, NSArray *array, NSError *error) {
        arrContectList = [[NSMutableArray alloc]initWithArray:array];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrContectList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    if ([[arrContectList objectAtIndex:indexPath.row] isKindOfClass:[NSDictionary class]]) {
        NSDictionary * dictContectinfo = [arrContectList objectAtIndex:indexPath.row];
        cell.textLabel.text = [dictContectinfo objectForKey:@"name"];
        cell.detailTextLabel.text = [dictContectinfo objectForKey:@"lname"];
    }
    else {
        CNContact * contect = [arrContectList objectAtIndex:indexPath.row];
        cell.textLabel.text = contect.familyName;
        cell.detailTextLabel.text = contect.givenName;
    }
    // Configure the cell...
    
    return cell;
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self showContectDetailView:[arrContectList objectAtIndex:indexPath.row]];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(IBAction)refrashContect:(id)sender{
    [AddressBookGeter addressBookContect:^(BOOL optestion, NSArray *array, NSError *error) {
        arrContectList = [[NSMutableArray alloc]initWithArray:array];
    }];
    [tblContectList reloadData];
}

-(IBAction)addnewContect:(id)sender{
    NSError * error = [[NSError alloc]init];
    NSMutableDictionary * dictContect = [[NSMutableDictionary alloc]init];
    [dictContect setObject:@"namePrefix" forKey:@"namePrefix"];
    [dictContect setObject:@"Lalji" forKey:@"givenName"];
    [dictContect setObject:@"Kanjariya" forKey:@"middleName"];
    [dictContect setObject:@"lal" forKey:@"familyName"];
    [dictContect setObject:@"previousFamilyName" forKey:@"previousFamilyName"];
    [dictContect setObject:@"nameSuffix" forKey:@"nameSuffix"];
    [dictContect setObject:@"Lalo" forKey:@"nickname"];
    [AddressBookGeter addContectToDefaultContectStoreContectInfo:dictContect withError:&error];
    [self refrashContect:nil];
}

-(IBAction)addnewContectWithUI:(id)sender{
//    CNContactPickerViewController * cnPicker = [[CNContactPickerViewController alloc]init];
//    cnPicker.delegate = self;
//    [self presentViewController:cnPicker animated:YES completion:nil];
    [self showContectDetailView:nil];
}

-(IBAction)selctContectWithUI:(id)sender{
    CNContactPickerViewController * cnPicker = [[CNContactPickerViewController alloc]init];
    cnPicker.delegate = self;
    [self presentViewController:cnPicker animated:YES completion:nil];
}

-(void)showContectDetailView:(CNContact *)contact{
    CNContactViewController * objContectView;
    if (contact) {
        objContectView = [CNContactViewController viewControllerForContact:contact];
        objContectView.allowsEditing = FALSE;
    }
    else {
        objContectView = [[CNContactViewController alloc]init];
        objContectView.allowsEditing = TRUE;
    }
    objContectView.delegate = self;
    [self presentViewController:objContectView animated:YES completion:nil];
}
#pragma mark - contect detail delegate -
- (void)contactViewController:(CNContactViewController *)viewController didCompleteWithContact:(nullable CNContact *)contact{
    [viewController dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - contect picker delegate -
- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContacts:(NSArray<CNContact*> *)contacts{
    arrContectList = [[NSMutableArray alloc]initWithArray:contacts];
    [tblContectList reloadData];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
@end
