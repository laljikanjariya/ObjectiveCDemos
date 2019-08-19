//
//  RapidRMSPumpCartsVC.h
//  PumpUpdateXML
//
//  Created by Siya9 on 10/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RapidRMSPumpCart;

@interface RapidRMSPumpCartsVC : UIViewController
@property (nonatomic, strong) NSString * cartID;
@end
@interface RMSPumpCartCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * lblAmount;
@property (nonatomic, weak) IBOutlet UILabel * lblAmountLimit;
@property (nonatomic, weak) IBOutlet UILabel * lblBalanceAmount;
@property (nonatomic, weak) IBOutlet UILabel * lblCartId;
@property (nonatomic, weak) IBOutlet UILabel * lblCartStatus;
@property (nonatomic, weak) IBOutlet UILabel * lblIsPaid;
@property (nonatomic, weak) IBOutlet UILabel * lblPrice;
@property (nonatomic, weak) IBOutlet UILabel * lblRegInvNum;
@property (nonatomic, weak) IBOutlet UILabel * lblTransactionType;

-(void)updateCellInformationFrom:(RapidRMSPumpCart *)objFuelPump;
@end