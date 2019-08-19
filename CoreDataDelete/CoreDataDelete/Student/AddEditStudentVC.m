//
//  AddEditStudentVC.m
//  CoreDataDelete
//
//  Created by Siya Infotech on 21/10/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "AddEditStudentVC.h"
#import "SurnameListVC.h"

@interface AddEditStudentVC ()<SurnameSelectionDelegate>{
    IBOutlet UITextField * txtStudentName;
    IBOutlet UILabel * lblStudentSurname;
}
@end

@implementation AddEditStudentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.objstudent) {
        txtStudentName.text = self.objstudent.sname;
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)surname:(id)sender{
    SurnameListVC * objSurnameListVC =
    [[UIStoryboard storyboardWithName:@"Main"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"SurnameListVC_sid"];
    objSurnameListVC.Delegate = self;
    [self.navigationController pushViewController:objSurnameListVC animated:YES];
}

-(void)didSelectedSurname:(Surname *)objSurname {
    if (!self.objstudent) {
        self.objstudent = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
        self.objstudent.sid = [self getNextStudentId];
    }
    self.objstudent.surnameid = objSurname;
    [objSurname addSuridObject:self.objstudent];
}
-(IBAction)book:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)save:(id)sender{
    if (!self.objstudent) {
        self.objstudent = [NSEntityDescription insertNewObjectForEntityForName:@"Students" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
        self.objstudent.sid = [self getNextStudentId];
    }
    self.objstudent.sname = txtStudentName.text;
    [[DatabaseManager sharedinstanceDatabaseManager] saveContext];
    [self back:nil];
}
-(NSNumber *)getNextStudentId{
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Students" inManagedObjectContext:[DatabaseManager sharedinstanceDatabaseManager].managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:entity];
    
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObject:@"sid"]];
    
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
        NSInteger IDToCompare = [[dict valueForKey:@"sid"] integerValue];
        
        if (IDToCompare >= newID) {
            newID = IDToCompare + 1;
        }
    } 
    return [NSNumber numberWithInteger:newID];
}
@end
