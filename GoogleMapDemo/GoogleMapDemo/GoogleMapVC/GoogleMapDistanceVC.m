//
//  GoogleMapDistanceVC.m
//  GoogleMapDemo
//
//  Created by Siya9 on 15/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "GoogleMapDistanceVC.h"

@interface GoogleMapDistanceVC ()

@property (nonatomic, weak) IBOutlet UITableView * tblList;
@end

@implementation GoogleMapDistanceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tblList.estimatedRowHeight = 80;
    self.tblList.rowHeight = UITableViewAutomaticDimension;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark - Table view data source -


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.arrLocationInfo.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DistanceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DistanceCell" forIndexPath:indexPath];
    cell.lblFrom.text = self.arrLocationInfo[indexPath.row][@"start_address"];
    cell.lblTo.text = self.arrLocationInfo[indexPath.row][@"end_address"];
    
    NSString * strHours = self.arrLocationInfo[indexPath.row][@"duration"][@"text"];
    
    strHours = [strHours stringByReplacingOccurrencesOfString:@" hours" withString:@"h:"];
    strHours = [strHours stringByReplacingOccurrencesOfString:@" hour" withString:@"h:"];
    strHours = [strHours stringByReplacingOccurrencesOfString:@" mins" withString:@"m"];
    strHours = [strHours stringByReplacingOccurrencesOfString:@" min" withString:@"m"];
    strHours = [strHours stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString * strTime = [NSString stringWithFormat:@"%@ \n \n \n %@",strHours,self.arrLocationInfo[indexPath.row][@"distance"][@"text"]];
    cell.lblDistanceAndTime.text = strTime;
    return cell;
}
@end


#pragma mark - Cell -
@implementation DistanceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
