//
//  SurnameListVC.m
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "SurnameListVC.h"

@interface SurnameListVC ()<NSFetchedResultsControllerDelegate>
{
    IBOutlet UITextField * txtSurname;
}
@property (nonatomic, strong) NSFetchedResultsController * surnameList;
@property (nonatomic, weak) IBOutlet UITableView * tblSurname;

@end

@implementation SurnameListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = [self.surnameList sections];
    id <NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    Surname * surname = [self.surnameList objectAtIndexPath:indexPath];
    cell.textLabel.text = surname.surname;
    cell.detailTextLabel.text = @"";
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
        Surname * objSurname = [self.surnameList objectAtIndexPath:indexPath];
        [[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext deleteObject:objSurname];
    }
}

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.Delegate) {
        [self.Delegate didSelectedSurname:[self.surnameList objectAtIndexPath:indexPath]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(IBAction)addNewSurname:(id)sender{
    if (txtSurname.text.length==0) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Insert surname" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else if ([self isSurnameExis:txtSurname.text]){
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Olredy exit surname" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    else{
        Surname * newSurname = [NSEntityDescription insertNewObjectForEntityForName:@"Surname" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
        newSurname.surname = txtSurname.text;
//        newSurname.surid = [self getNextSurnameId];
        [[DatabaseManager sharedinstanceDatabaseManager] saveContext];
        txtSurname.text = @"";
    }
}
#pragma mark - CoreData -
- (NSFetchedResultsController *)surnameList {
    
    if (_surnameList != nil) {
        return _surnameList;
    }
    DatabaseManager * objDatabase = [DatabaseManager sharedinstanceDatabaseManager];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Surname" inManagedObjectContext:objDatabase.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Create the sort descriptors array.
    NSSortDescriptor *aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"surname" ascending:YES selector:@selector(caseInsensitiveCompare:)];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _surnameList = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:objDatabase.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [_surnameList performFetch:nil];
    _surnameList.delegate = self;
    
    return _surnameList;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.surnameList]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblSurname beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.surnameList]) {
        return;
    }
    
    UITableView *tableView = self.tblSurname;
    
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
    if (![controller isEqual:self.surnameList]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblSurname insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblSurname deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.surnameList]) {
        return;
    }
    [self.tblSurname endUpdates];
}

-(BOOL)isSurnameExis:(NSString *)strSurname{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Surname" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"surname == %@",[strSurname lowercaseString]];
    
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    
    NSArray *existingIDs = [[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (existingIDs.count>0) {
        return YES;
    }
    else{
        return NO;
    }
}


-(NSNumber *)getNextSurnameId{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Surname" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"surid"]];
    
    NSError *error = nil;
    
    NSArray *existingIDs = [[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    
    if (error != nil) {
        
        //
        //  TODO: Handle error.
        //
        
        NSLog(@"Error: %@", [error localizedDescription]);
    }
    
    NSInteger newID = 1;
    
    for (NSDictionary *dict in existingIDs) {
        NSInteger IDToCompare = [[dict valueForKey:@"surid"] integerValue];
        
        if (IDToCompare >= newID) {
            newID = IDToCompare + 1;
        }
    }
    return [NSNumber numberWithInteger:newID];
}
@end
