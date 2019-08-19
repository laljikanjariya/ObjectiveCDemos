//
//  ViewController.m
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "PumpDBManager.h"
#import "FuelPump.h"
#import "XMLtoObject.h"
#import "RapidRMSPumpCartsVC.h"
#import "RapidOnSitePumpCartsVC.h"

#import "RapidRMSLiveUpdate.h"
#import "PumpSnycManager.h"

@interface ViewController () <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) NSFetchedResultsController * fuelPumpRC;
@property (nonatomic, weak) IBOutlet UITableView * tblFuelPumpList;
@property (nonatomic, weak) IBOutlet UITextField * txtCartId;

@property (nonatomic, weak) IBOutlet UILabel * lblKey;
@property (nonatomic, weak) IBOutlet UILabel * lblState;
@property (nonatomic, weak) IBOutlet UILabel * lblAmount;
@property (nonatomic, weak) IBOutlet UILabel * lblAmount_Limit;
@property (nonatomic, weak) IBOutlet UILabel * lblFuel;
@property (nonatomic, weak) IBOutlet UILabel * lblPrice;
@property (nonatomic, weak) IBOutlet UILabel * lblVolume;
@property (nonatomic, weak) IBOutlet UILabel * lblVolume_Limit;

@property (nonatomic, weak) IBOutlet UILabel * lblCartState;
@property (nonatomic, weak) IBOutlet UILabel * lblPaid;
@property (nonatomic, weak) IBOutlet UILabel * lblSpent;
@property (nonatomic, weak) IBOutlet UILabel * lblLimit;
@property (nonatomic, weak) IBOutlet UILabel * lblMode;

@property (nonatomic, weak) IBOutlet UICollectionView * colFuelPumpList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [PumpDBManager sharedPumpDBManager].managedObjectContext;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pumpStatusChange:) name:PumpStatusChangeNotification object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

-(IBAction)showRapidRMSPumpCart:(id)sender {
    RapidRMSPumpCartsVC * objRapidRMSPumpCartsVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"RapidRMSPumpCartsVC_sid"];
    
    [self.navigationController pushViewController:objRapidRMSPumpCartsVC animated:TRUE];
}
-(IBAction)showRapidOnSitePumpCart:(id)sender {
    RapidOnSitePumpCartsVC * objRapidOnSitePumpCartsVC =
    [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"RapidOnSitePumpCartsVC_sid"];
    
    [self.navigationController pushViewController:objRapidOnSitePumpCartsVC animated:TRUE];
}
-(IBAction)getCartDetail:(id)sender {
    if (self.txtCartId.text.length > 0) {
        [PumpSnycManager updateRapidOnSiteCart:self.txtCartId.text withComplitionHandler:^(id response) {
            [RapidRMSLiveUpdate addLiveUpdate];
        }];
        NSString * strPath = [[NSUserDefaults standardUserDefaults] objectForKey:@"OnSiteServerURL"];
        NSString * request = [NSString stringWithFormat:@"%@%@.Branch,XML",strPath,self.txtCartId.text];
        NSDictionary * dictPumps = [XMLtoObject parseXMLtoObjectfromURL:request];
        
        NSDictionary * dictPump = [dictPumps valueForKeyPath:@"Shofar.RapidOnSite_Pump"];
        self.lblKey.text = [NSString stringWithFormat:@"Pump # %@",dictPump[@"Key"]];
        self.lblState.text = [NSString stringWithFormat:@"State : %@",dictPump[@"State"]];
        self.lblAmount.text = [NSString stringWithFormat:@"Amount : %@",dictPump[@"Amount"]];
        self.lblAmount_Limit.text = [NSString stringWithFormat:@"Amount_Limit : %@",dictPump[@"Amount_Limit"]];
        self.lblFuel.text = [NSString stringWithFormat:@"Fuel : %@",dictPump[@"Fuel"]];
        self.lblPrice.text = [NSString stringWithFormat:@"Price : %@",dictPump[@"Price"]];
        self.lblVolume.text = [NSString stringWithFormat:@"Volume : %@",dictPump[@"Volume"]];
        self.lblVolume_Limit.text = [NSString stringWithFormat:@"Volume_Limit : %@",dictPump[@"Volume_Limit"]];
        
        NSDictionary * dictCart = [dictPumps valueForKeyPath:@"Shofar.Cart"];
        self.lblCartState.text = [NSString stringWithFormat:@"State : %@",dictCart[@"State"]];
        self.lblPaid.text = [NSString stringWithFormat:@"Paid : %@",dictCart[@"Paid"]];
        self.lblSpent.text = [NSString stringWithFormat:@"Spent : %@",dictCart[@"Spent"]];
        self.lblLimit.text = [NSString stringWithFormat:@"Limit : %@",dictCart[@"Limit"]];
        self.lblMode.text = [NSString stringWithFormat:@"Mode : %@",dictCart[@"Mode"]];
    }
}

-(void)pumpStatusChange:(NSNotification *)notification{
//    NSNumber * pumpIndex = @([[notification.userInfo valueForKey:@"PumpIndex"] integerValue]);
    NSString * strCartId = [notification.userInfo valueForKey:@"CartId"];
    NSString * strNewStatus = [notification.userInfo valueForKey:@"newStatus"];
    NSString * strOldStatus = [notification.userInfo valueForKey:@"oldStatus"];
    if ([strOldStatus.lowercaseString isEqualToString:@"authorized"] && [strNewStatus.lowercaseString isEqualToString:@"idle"]) {
        [self getCartFromServer:strCartId];
    }
    else if([strOldStatus.lowercaseString isEqualToString:@"dispensing"] && [strNewStatus.lowercaseString isEqualToString:@"idle"]){
        [self getCartFromServer:strCartId];
    }
}
-(void)getCartFromServer:(NSString *)strCartId{
    [PumpSnycManager updateRapidOnSiteCart:strCartId withComplitionHandler:^(id response) {
        [RapidRMSLiveUpdate addLiveUpdate];
    }];
}
#pragma mark - Table view data source -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSArray *sections = self.fuelPumpRC.sections;
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *sections = self.fuelPumpRC.sections;
    id <NSFetchedResultsSectionInfo> sectionInfo = sections[section];
    return sectionInfo.numberOfObjects;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PumpListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    [cell updateCellInformationFrom:(FuelPump *)[self.fuelPumpRC objectAtIndexPath:indexPath]];
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FuelPump * objFuelPump = (FuelPump *)[self.fuelPumpRC objectAtIndexPath:indexPath];
    if (objFuelPump.cart) {
        self.txtCartId.text = objFuelPump.cart;
        [self getCartDetail:nil];
    }
    else{
        self.txtCartId.text = @"";
    }
}
#pragma mark - CoreData Methods

- (NSFetchedResultsController *)fuelPumpRC {
    
    if (_fuelPumpRC != nil) {
        return _fuelPumpRC;
    }
    
    // Create and configure a fetch request with the Book entity.
    //   NSString *sortColumn=@"item_Desc";
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"FuelPump" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor * aSortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"pumpIndex" ascending:TRUE];
    NSArray *sortDescriptors = @[aSortDescriptor];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Create and initialize the fetch results controller.
    _fuelPumpRC = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    [_fuelPumpRC performFetch:nil];
    _fuelPumpRC.delegate = self;
    
    return _fuelPumpRC;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.fuelPumpRC]) {
        return;
    }
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tblFuelPumpList beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    if (![controller isEqual:self.fuelPumpRC]) {
        return;
    }
    
    UITableView *tableView = self.tblFuelPumpList;
    
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
    if (![controller isEqual:self.fuelPumpRC]) {
        return;
    }
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tblFuelPumpList insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tblFuelPumpList deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
        default:
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (![controller isEqual:self.fuelPumpRC]) {
        return;
    }
    [self.tblFuelPumpList endUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

@implementation PumpListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateCellInformationFrom:(FuelPump *)objFuelPump{
    self.lblPumpName.text = [NSString stringWithFormat:@"Pump # %@",objFuelPump.pumpIndex];
    self.lblState.text = [NSString stringWithFormat:@"Status : %@",objFuelPump.status];
    if ([objFuelPump.status.lowercaseString isEqualToString:@"authorized"]) {
        self.lblState.backgroundColor = [UIColor greenColor];
    }
    else if ([objFuelPump.status.lowercaseString isEqualToString:@"dispensing"]) {
        self.lblState.backgroundColor = [UIColor orangeColor];
    }
    else{
        self.lblState.backgroundColor = [UIColor clearColor];
    }
    self.lblAmount.text = [NSString stringWithFormat:@"Amount : %.3f",objFuelPump.amount.floatValue];
    self.lblAmountLimit.text = [NSString stringWithFormat:@"Amount Limit : %.2f",objFuelPump.amountLimit.floatValue];
    self.lblCart.text = [NSString stringWithFormat:@"Cart : %@",objFuelPump.cart];
    
    
    if (objFuelPump.amount.integerValue < objFuelPump.amountLimit.integerValue-0.1) {
        self.lblPumpName.textColor = [UIColor redColor];
    }
    else if (objFuelPump.amount.integerValue >= objFuelPump.amountLimit.integerValue-0.1 && objFuelPump.amount.integerValue != 0){
        self.lblPumpName.textColor = [UIColor greenColor];
    }
    else{
        self.lblPumpName.textColor = [UIColor grayColor];
    }
    
}
@end
