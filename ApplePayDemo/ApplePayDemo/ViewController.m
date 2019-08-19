//
//  ViewController.m
//  ApplePayDemo
//
//  Created by Siya Infotech on 01/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "ViewController.h"
#import <PassKit/PassKit.h>
#import "ItemDetailVC.h"

@interface ViewController ()
{
    NSMutableArray * arrItemList;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    arrItemList = [[NSMutableArray alloc]init];
    NSMutableDictionary * dictItem = [[NSMutableDictionary alloc]init];
    [dictItem setObject:@"iGT" forKey:@"named"];
    [dictItem setObject:@"iOS Games by Tutorials" forKey:@"title"];
    [dictItem setObject:@"54.00" forKey:@"price"];
    [dictItem setObject:@"This book is for beginner to advanced iOS developers. Whether you are a complete beginner to making iOS games, or an advanced iOS developer looking to learn about Sprite Kit, you will learn a lot from this book!" forKey:@"description"];
    [arrItemList addObject:[dictItem mutableCopy]];
    
    [dictItem setObject:@"iOSApprentice" forKey:@"named"];
    [dictItem setObject:@"iOS Apprentice" forKey:@"title"];
    [dictItem setObject:@"54.50" forKey:@"price"];
    [dictItem setObject:@"The iOS Apprentice is a series of epic-length tutorials for beginners where you’ll learn how to build 4 complete apps from scratch." forKey:@"description"];
    [arrItemList addObject:[dictItem mutableCopy]];
    
    [dictItem setObject:@"RW_button_pack" forKey:@"named"];
    [dictItem setObject:@"Button Pack" forKey:@"title"];
    [dictItem setObject:@"9.99" forKey:@"price"];
    [dictItem setObject:@"A pack of Ray Wenderlich buttons!." forKey:@"description"];
    [arrItemList addObject:[dictItem mutableCopy]];
    
    [dictItem setObject:@"RW-Sticker" forKey:@"named"];
    [dictItem setObject:@"Sticker" forKey:@"title"];
    [dictItem setObject:@"2.99" forKey:@"price"];
    [dictItem setObject:@"A really cool sticker!" forKey:@"description"];
    [arrItemList addObject:[dictItem mutableCopy]];
    
    [dictItem setObject:@"rw-t-shirt" forKey:@"named"];
    [dictItem setObject:@"T-Shirt" forKey:@"title"];
    [dictItem setObject:@"14.99" forKey:@"price"];
    [dictItem setObject:@"Sport a stylish black t-shirt with a colorful mosaic iPhone design!" forKey:@"description"];
    [arrItemList addObject:[dictItem mutableCopy]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return arrItemList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary * dictItem = [arrItemList objectAtIndex:indexPath.row];
    cell.imageView.image =[UIImage imageNamed:[dictItem valueForKey:@"named"]];
    cell.textLabel.text = [dictItem valueForKey:@"title"];
    cell.detailTextLabel.text = [dictItem valueForKey:@"price"];
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemDetailVC * itemDetailVC =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"ItemDetailVC_SID"];
    itemDetailVC.dictItem = [arrItemList objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:itemDetailVC animated:YES];
//    [self performSegueWithIdentifier:@"itemDetailSeg" sender:indexPath];
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"itemDetailSeg"]) {
        ItemDetailVC * destinationVC = (ItemDetailVC *)segue.destinationViewController;
        destinationVC.dictItem = [arrItemList objectAtIndex:0];
    }
}
@end
