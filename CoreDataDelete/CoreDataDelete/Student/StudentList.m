//
//  ViewController.m
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "StudentList.h"
#import "AddEditStudentVC.h"
@interface StudentList ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController * studentList;
@property (nonatomic, weak) IBOutlet UITableView * tblStudent;
@end

@implementation StudentList
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.studentList sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Students * student = [self.studentList objectAtIndexPath:indexPath];
    cell.textLabel.text = student.sname;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@,%@",student.surnameid.surname,[student.sid stringValue]];
    // Configure the cell...
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext deleteObject:[self.studentList objectAtIndexPath:indexPath]];
    }
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddEditStudentVC * addEditStudentVC =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"AddEditStudentVC_sid"];
    addEditStudentVC.objstudent = [self.studentList objectAtIndexPath:indexPath];
    [self.navigationController pushViewController:addEditStudentVC animated:YES];
}
-(IBAction)addNewStudent:(id)sender{
//    Students * newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
//    newStudent.sname = @"lalji";
//    [[DatabaseManager sharedinstanceDatabaseManager] saveContext];
//    self.studentList = nil;
//    [self.tblStudent reloadData];
    AddEditStudentVC * addEditStudentVC =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"AddEditStudentVC_sid"];
    
    [self.navigationController pushViewController:addEditStudentVC animated:YES];
}
#pragma mark - CoreData -
- (NSFetchedResultsController *)studentList {
    
    if (_studentList != nil) {
        return _studentList;
    }
    DatabaseManager * objDatabase = [DatabaseManager sharedinstanceDatabaseManager];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Students" inManagedObjectContext:objDatabase.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"sname" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _studentList = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:objDatabase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [_studentList performFetch:nil];
    _studentList.delegate = self;
    
    return _studentList;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.studentList]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblStudent beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.studentList]) {
        return;
    }
    
    UITableView *tableView = self.tblStudent;
    
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
    if (![controller isEqual:self.studentList]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblStudent insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblStudent deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.studentList]) {
        return;
    }
    [self.tblStudent endUpdates];
}
@end
