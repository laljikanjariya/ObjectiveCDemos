//
//  RapidRMSPumpCartsVC.m
//  PumpUpdateXML
//
//  Created by Siya9 on 10/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "RapidRMSPumpCartsVC.h"
#import "PumpDBManager.h"
#import "RapidRMSPumpCart.h"

@interface RapidRMSPumpCartsVC ()<NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController * RMSPumpCartRC;
@property (nonatomic, weak) IBOutlet UITableView * tblRMSPumpCart;


@end

@implementation RapidRMSPumpCartsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [PumpDBManager sharedPumpDBManager].managedObjectContext;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSArray *sections = self.RMSPumpCartRC.sections;
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *sections = self.RMSPumpCartRC.sections;
    id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RMSPumpCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateCellInformationFrom:(RapidRMSPumpCart *)[self.RMSPumpCartRC objectAtIndexPath:indexPath]];
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - CoreData Methods

- (NSFetchedResultsController *)RMSPumpCartRC {
    
    if (_RMSPumpCartRC != nil) {
        return _RMSPumpCartRC;
    }
    
    // Create and configure a fetch request with the Book entity.
    //   NSString *sortColumn=@"item_Desc";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"RapidRMSPumpCart" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
//    if (self.cartID.length > 0) {
//        fetchRequest.predicate = [nsspredica]
//    }
    
    NSSortDescriptor * aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:FALSE];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _RMSPumpCartRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [_RMSPumpCartRC performFetch:nil];
    _RMSPumpCartRC.delegate = self;
    
    return _RMSPumpCartRC;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.RMSPumpCartRC]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblRMSPumpCart beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.RMSPumpCartRC]) {
        return;
    }
    
    UITableView *tableView = self.tblRMSPumpCart;
    
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
    if (![controller isEqual:self.RMSPumpCartRC]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblRMSPumpCart insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblRMSPumpCart deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.RMSPumpCartRC]) {
        return;
    }
    [self.tblRMSPumpCart endUpdates];
}

@end

@implementation RMSPumpCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateCellInformationFrom:(RapidRMSPumpCart *)objPumpCart {
    self.lblAmount.text = [NSString stringWithFormat:@"Amount : %.3f",objPumpCart.amount.floatValue];
    self.lblAmountLimit.text = [NSString stringWithFormat:@"AmountLimit : %.3f",objPumpCart.amountLimit.floatValue];
    self.lblBalanceAmount.text = [NSString stringWithFormat:@"BalanceAmount : %.3f",objPumpCart.balanceAmount.floatValue];
    self.lblCartId.text = [NSString stringWithFormat:@"CartId : %@",objPumpCart.cartId];
    self.lblCartStatus.text = [NSString stringWithFormat:@"CartStatus : %@",objPumpCart.cartStatus];
    self.lblIsPaid.text = [NSString stringWithFormat:@"IsPaid : %@",objPumpCart.isPaid];
    self.lblPrice.text = [NSString stringWithFormat:@"Price : %.3f",objPumpCart.price.floatValue];
    self.lblRegInvNum.text = [NSString stringWithFormat:@"RegInvNum : %@",objPumpCart.regInvNum];
    self.lblTransactionType.text = [NSString stringWithFormat:@"TransactionType : %@",objPumpCart.transactionType];
}
@end