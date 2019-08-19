//
//  ViewController.m
//  ExpandebleTableView
//
//  Created by Lalji on 11/07/19.
//  Copyright © 2019 Lalji. All rights reserved.
//

#import "ViewController.h"
#import "RIMExpandTableModel.h"

@interface ViewController ()<RIMExpandChangeTypeDelegate>{
    RIMExpandTableModel * model;
    IBOutlet UITableView * tableView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    model = [[RIMExpandTableModel alloc]initWithDelegate:self];
    [model addNewSection:@{@"Name":@"iOS"} isOpend:TRUE withSectionRowData:@[@{@"Name":@"Lalji"},@{@"Name":@"Harsh"},@{@"Name":@"Hitu"},@{@"Name":@"Rajni"},@{@"Name":@"Paras"}]];
    [model addNewSection:@{@"Name":@".Net"} isOpend:FALSE withSectionRowData:@[@{@"Name":@"Vishal"},@{@"Name":@"Abhi"},@{@"Name":@"Bimu"}]];

    // Do any additional setup after loading the view.
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [model numberOfSectionsInTableModel];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [model numberOfRowsInSection:section];
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    RIMExpandTableSectionModel * sectioObject = [model sectionAtIndex:section];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"hcell"];
    cell.textLabel.text = sectioObject.sectionData[@"Name"];
    cell.detailTextLabel.text = (sectioObject.isOpen)?@"Open":@"Close";
    return cell.contentView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    RIMExpandTableRowModel * rowData = [model rowAtIndexPath:indexPath];
    cell.textLabel.text = rowData.rowData[@"Name"];
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [model expandCollapseSection:indexPath.section];
}
-(IBAction)selectedSection:(UIButton *)sender {
    [model expandCollapseSection:1];
}

- (void)updateModelRowWillChangeContent {
    [tableView beginUpdates];
}
- (void)updateModelRowChangeType:(RIMExpandChangeType)type forIndexPaths:(nonnull NSArray<NSIndexPath *> *)arrIndexPath {
    switch (type) {
        case RIMExpandChangeTypeInsert:
            [tableView insertRowsAtIndexPaths:arrIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        case RIMExpandChangeTypeDelete:
            [tableView deleteRowsAtIndexPaths:arrIndexPath withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}
- (void)updateModelRowDidChangeContent {
    [tableView endUpdates];
}
@end
