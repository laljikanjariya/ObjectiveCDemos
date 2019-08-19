//
//  ViewController.m
//  GoogleMapDemo
//
//  Created by Siya9 on 12/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "GoogleMapVC.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewDidAppear:(BOOL)animated {
    GoogleMapVC * ovjGoogleMapVC =
    [[UIStoryboard storyboardWithName:@"GoogleMapSB" bundle:NULL] instantiateViewControllerWithIdentifier:@"GoogleMapVC_sid"];
    
    ovjGoogleMapVC.isShowLocation = TRUE;
    ovjGoogleMapVC.anotationType = GMDrowPathTowPointRoute;
    ovjGoogleMapVC.view.frame = self.view.bounds;
    [self.view addSubview:ovjGoogleMapVC.view];
    [self addChildViewController:ovjGoogleMapVC];
    NSMutableArray * arrLocations = [NSMutableArray array];
    
    GMLocation * testLocation = [[GMLocation alloc] initWithTitle:@"Home Ahmedabad" detailMessage:@"Starling city, bopal, ahmedabad" Latitude:23.03989 Longitude:72.46520];
    testLocation.markerType = GMMarkerTypeSource;
    [arrLocations addObject:testLocation];
    
    GMLocation * sourceLocation =[[GMLocation alloc] initWithTitle:@"Home Kalyanpur" detailMessage:@"Jam kalyanpur" Latitude:22.01968198 Longitude:69.4038105];
    sourceLocation.markerType = GMMarkerTypeDestination;
    [arrLocations addObject:sourceLocation];
    
    GMLocation * via1Location = [[GMLocation alloc] initWithTitle:@"Rajkot" detailMessage:@"Hospital Chowk, Rajkot" Latitude:22.30405591 Longitude:70.80175638];
    via1Location.markerType = GMMarkerTypeVia;
    [arrLocations addObject:via1Location];
    
    GMLocation * via2Location = [[GMLocation alloc] initWithTitle:@"Jamnagar" detailMessage:@"Sat rasta circle, Rajkot" Latitude:22.47072515 Longitude:70.05679965];
    via2Location.markerType = GMMarkerTypeVia;
    [arrLocations addObject:via2Location];
    
    GMLocation * via3Location = [[GMLocation alloc] initWithTitle:@"Khambhadiya" detailMessage:@"Sat rasta circle, Rajkot" Latitude:22.19886883 Longitude:69.62707758];
    via3Location.markerType = GMMarkerTypeVia;
    [arrLocations addObject:via3Location];
    
    
    ovjGoogleMapVC.arrLocations = arrLocations;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
