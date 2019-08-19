//
//  ViewController.m
//  TableViewSelection
//
//  Created by Siya9 on 25/07/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "RapidWebServiceConnection.h"
#import "POItemListData.h"

typedef void (^ UIAlertActionHandler)(UIAlertAction *action);


@interface ViewController ()

@property (nonatomic, strong) RapidWebServiceConnection *getPOListDataWC;
@property (nonatomic, strong) POItemListData * pOItemListData; //ServerData
@property (nonatomic, weak) IBOutlet UITableView *tblPOList;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getPOListData];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getPOListData{
    
    NSMutableDictionary *itemparam = [NSMutableDictionary dictionary];
    [itemparam setValue:@(1) forKey:@"BranchId"];
    [itemparam setValue:@(1) forKey:@"UserId"];
//    [itemparam setValue:@"OPN00001" forKey:@"OpenOrderNo"];

    CompletionHandler completionHandler = ^(id response, NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self getPOListDataResponse:response error:error];
        });
    };
//    GetOpenPurchaseOrderData06302016
//    GetPOList06292017
    self.getPOListDataWC = [[RapidWebServiceConnection alloc] initWithRequest:@"https://rapidrmseast-rapidrmsmodulewise.azurewebsites.net/WcfService/Service.svc/" actionName:@"GetPOList06292017" params:itemparam completionHandler:completionHandler];
}

- (void)getPOListDataResponse:(id)response error:(NSError *)error
{
    if (response != nil)
    {
        if ([response isKindOfClass:[NSDictionary class]]) {
            if ([[response  valueForKey:@"IsError"] intValue] == 0)
            {
                self.pOItemListData = [[POItemListData alloc]initWithDictionary:[self objectFromJsonString:[response valueForKey:@"Data"]]];

                [self.tblPOList reloadData];
            }
            else {
                UIAlertActionHandler rightHandler = ^ (UIAlertAction *action){
                    NSString * filePath = [[NSBundle mainBundle] pathForResource:@"POModelJSON" ofType:@"txt"];

                    NSString * strJson = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];

                    self.pOItemListData = [[POItemListData alloc]initWithDictionary:[self objectFromJsonString:strJson]];
                    
                    [self.tblPOList reloadData];

                };
                [self popupAlertFromVC:self title:@"Purchase Order" message:[response valueForKey:@"Data"] buttonTitles:@[@"OK"] buttonHandlers:@[rightHandler]];
            }
        }
        
    }
}

#pragma mark - Table view data source -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.pOItemListData.pOItemDetail.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UIView * sele = [UIView new];
    sele.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView =sele;
    // Configure the cell...
    POItemDetail * item = self.pOItemListData.pOItemDetail[indexPath.row];
    cell.textLabel.text = item.itemInfo.itemName;
    return cell;
}
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    POItemDetail * item = self.pOItemListData.pOItemDetail[indexPath.row];
    NSLog(@"POItemDetail * item %@",item);
}
-(id)objectFromJsonString:(NSString *)jsonString {
    NSError *error;
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    if (! jsonData) {
        return nil;
    }
    return [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:&error];
}
- (void)popupAlertFromVC:(UIViewController*)viewController title:(NSString *)title  message:(NSString *)message buttonTitles:(NSArray*)buttonTitles buttonHandlers:(NSArray*)buttonHandlers
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title
                                                                   message:message
                                                            preferredStyle:UIAlertControllerStyleAlert];
    for (int i = 0; i< buttonTitles.count; i++)
    {
        UIAlertAction* action = [UIAlertAction actionWithTitle:buttonTitles[i] style:UIAlertActionStyleDefault
                                                       handler: buttonHandlers[i]];
        [alert addAction:action];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [viewController presentViewController:alert animated:TRUE completion:nil];
        
    });
}
@end
