//
//  ViewController.h
//  PumpUpdateXML
//
//  Created by Siya9 on 08/02/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end


@class FuelPump;

@interface PumpListCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * lblPumpName;
@property (nonatomic, weak) IBOutlet UILabel * lblState;
@property (nonatomic, weak) IBOutlet UILabel * lblAmount;
@property (nonatomic, weak) IBOutlet UILabel * lblAmountLimit;
@property (nonatomic, weak) IBOutlet UILabel * lblVolume;
@property (nonatomic, weak) IBOutlet UILabel * lblCart;

-(void)updateCellInformationFrom:(FuelPump *)objFuelPump;
@end