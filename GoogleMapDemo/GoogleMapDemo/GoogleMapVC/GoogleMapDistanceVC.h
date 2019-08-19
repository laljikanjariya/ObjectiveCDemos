//
//  GoogleMapDistanceVC.h
//  GoogleMapDemo
//
//  Created by Siya9 on 15/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoogleMapDistanceVC : UIViewController
@property (nonatomic, strong) NSArray *arrLocationInfo;
@end


@interface DistanceCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel * lblFrom;
@property (nonatomic, weak) IBOutlet UILabel * lblTo;
@property (nonatomic, weak) IBOutlet UILabel * lblDistanceAndTime;
@end
