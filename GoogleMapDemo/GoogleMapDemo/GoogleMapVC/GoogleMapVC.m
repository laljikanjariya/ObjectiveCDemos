//
//  GoogleMapVC.m
//  GoogleMapDemo
//
//  Created by Siya9 on 12/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "GoogleMapVC.h"
#import "GoogleMapDistanceVC.h"

@import GoogleMaps;

#define GOOGLE_API_KEY @"AIzaSyDkAVxPQVXg9_eBKfkBOUD0MIi1GTYuqeE"


#pragma mark - GMMarker GMUClusterItem protocol -



@interface GoogleMapVC ()<GMUClusterManagerDelegate, GMSMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *NewCurrentLocation;
@end

static const double kCameraLatitude = 23.02705;
static const double kCameraLongitude = 72.50713;

@implementation GoogleMapVC
{
    GMSMapView *mapView;
    GMUClusterManager *_clusterManager;
    NSArray * arrDistance;
    IBOutlet UIButton * btnDistance;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self addGooglemapInView];
}

-(void)viewWillAppear:(BOOL)animated{
    if (_isShowLocation) {
        [self startLocationSearch];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)setArrLocations:(NSArray *)arrLocations {
    _arrLocations = arrLocations;
    [self resertMarkers];
}

#pragma mark - Get Current Location -
-(void)startLocationSearch{
    _locationManager = [CLLocationManager new];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestAlwaysAuthorization];
    }
    [_locationManager startMonitoringSignificantLocationChanges];
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager*)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
        case kCLAuthorizationStatusNotDetermined: {
            NSLog(@"User still thinking..");
        } break;
        case kCLAuthorizationStatusDenied: {
            NSLog(@"User hates you");
        } break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways: {
            [_locationManager startMonitoringSignificantLocationChanges];
            [_locationManager startUpdatingLocation]; //Will update location immediately
        } break;
        default:
            break;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (!self.NewCurrentLocation) {
        self.NewCurrentLocation = [locations lastObject];
        [self resertMarkers];
    }
    if (locations && [self.NewCurrentLocation distanceFromLocation:[locations lastObject]] > 2) {
        [self resertMarkers];
        self.NewCurrentLocation = [locations lastObject];
    }
}


#pragma mark - Google Map -
-(void)addGooglemapInView{
    [GMSServices provideAPIKey:GOOGLE_API_KEY];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:kCameraLatitude
                                                            longitude:kCameraLongitude
                                                                 zoom:0];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.myLocationEnabled = FALSE;
    mapView.settings.compassButton = TRUE;
    mapView.frame = self.view.bounds;
    [self.view addSubview:mapView];
    [self.view bringSubviewToFront:btnDistance];
    
    if (self.anotationType == GMDrowPathMultiplePoint) {
        id<GMUClusterAlgorithm> algorithm = [[GMUNonHierarchicalDistanceBasedAlgorithm alloc] init];
        id<GMUClusterIconGenerator> iconGenerator = [[GMUDefaultClusterIconGenerator alloc] init];
        id<GMUClusterRenderer> renderer =
        [[GMUDefaultClusterRenderer alloc] initWithMapView:mapView
                                      clusterIconGenerator:iconGenerator];
        _clusterManager =
        [[GMUClusterManager alloc] initWithMap:mapView algorithm:algorithm renderer:renderer];
        
        [_clusterManager setDelegate:self mapDelegate:self];
    }
}

-(IBAction)ShowDistanceInformation:(id)sender {
    GoogleMapDistanceVC * objGoogleMapDistanceVC =
    [[UIStoryboard storyboardWithName:@"GoogleMapSB" bundle:NULL] instantiateViewControllerWithIdentifier:@"GoogleMapDistanceVC_sid"];
    objGoogleMapDistanceVC.arrLocationInfo = arrDistance;
    [self.navigationController pushViewController:objGoogleMapDistanceVC animated:TRUE];
}
#pragma mark GMUClusterManagerDelegate

- (void)clusterManager:(GMUClusterManager *)clusterManager didTapCluster:(id<GMUCluster>)cluster {
    GMSCameraPosition *newCamera =
    [GMSCameraPosition cameraWithTarget:cluster.position zoom:mapView.camera.zoom + 1];
    GMSCameraUpdate *update = [GMSCameraUpdate setCamera:newCamera];
    [mapView moveCamera:update];
}

#pragma mark GMSMapViewDelegate

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    GMLocation *poiItem = marker.userData;
    if (poiItem != nil) {
        NSLog(@"Did tap marker for cluster item %@", poiItem.name);
        marker.title = @"Lalji";
        return TRUE;
    } else {
        NSLog(@"Did tap a normal marker");
        return FALSE;
    }
}

-(void)resertMarkers{
    [mapView clear];
    [_clusterManager clearItems];
    
    for (GMLocation * location in self.arrLocations) {
        [self addMarkerAt:location];
    }
    if (self.isShowLocation && self.NewCurrentLocation) {
        GMLocation * currentLocation = [[GMLocation alloc]initWithTitle:@"Current Location" detailMessage:@"" Latitude:self.NewCurrentLocation.coordinate.latitude Longitude:self.NewCurrentLocation.coordinate.longitude];
        currentLocation.markerType = GMMarkerTypeCurrent;
        [self addMarkerAt:currentLocation];
    }
    if (self.anotationType == GMDrowPathTowPointRoute && self.arrLocations.count >= 2) {
        [self drawRoute];
    }
    else{
        [_clusterManager cluster];
        [_clusterManager setDelegate:self mapDelegate:self];
    }
    [self focusMapToShowAllMarkers];
}
-(void)addMarkerAt:(GMLocation *)location{
    if (self.anotationType == GMDrowPathTowPointRoute) {
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.position = location.position;
        marker.title = location.name;
        marker.snippet = location.detail;
        
        if (self.anotationType == GMDrowPathMultiplePoint)
            marker.icon = [UIImage imageNamed:@"GMmarker.png"];
        else{
            if (location.markerType == GMMarkerTypeSource)
                marker.icon = [UIImage imageNamed:@"GMSourceLocation.png"];
            else if (location.markerType == GMMarkerTypeDestination)
                marker.icon = [UIImage imageNamed:@"GMDestinationLocation.png"];
            else
                marker.icon = [UIImage imageNamed:@"GMmarker.png"];
        }
        if (location.markerType == GMMarkerTypeCurrent)
            marker.icon = [UIImage imageNamed:@"GMCurrentLocation.png"];
        marker.map = mapView;
    }
    else{
        [_clusterManager addItem:location];
    }
}

- (void)focusMapToShowAllMarkers
{
    GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] init];
    for (GMLocation *marker in self.arrLocations)
        bounds = [bounds includingCoordinate:marker.position];
    [mapView animateWithCameraUpdate:[GMSCameraUpdate fitBounds:bounds withPadding:50.0f]];
}

#pragma mark - Drow User Route -

- (void)drawRoute
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self fetchPolylineWithLocations:self.arrLocations];
    });
}

- (void)fetchPolylineWithLocations:(NSArray <GMLocation *> *) arrLocations
{
    GMLocation * origin = [GMLocation getSourceLocationFrom:arrLocations];
    GMLocation * destination = [GMLocation getDestinationLocationFrom:arrLocations];
    
    NSString *originString = [NSString stringWithFormat:@"%f,%f", origin.position.latitude, origin.position.longitude];
    NSString *destinationString = [NSString stringWithFormat:@"%f,%f", destination.position.latitude, destination.position.longitude];
    
    NSString * strRequest = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@",originString, destinationString];
    if (arrLocations) {
        NSMutableArray * componets = [NSMutableArray array];
        NSArray * getViaLocation = [GMLocation getViaLocationFrom:arrLocations];
        for (GMLocation *marker in getViaLocation){
            [componets addObject:[NSString stringWithFormat:@"%f,%f",marker.position.latitude,marker.position.longitude]];
        }
        strRequest = [NSString stringWithFormat:@"%@&waypoints=optimize:true|%@",strRequest,[componets componentsJoinedByString:@"|"]];
    }
    else{
        strRequest = [NSString stringWithFormat:@"%@&mode=driving",strRequest];
    }
    [self drawRouteForWithStringURL:strRequest];
}
-(void)drawRouteForWithStringURL:(NSString *)strUrl{
    NSURL *directionsUrl = [NSURL URLWithString:[strUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSData * data = [NSData dataWithContentsOfURL:directionsUrl];
    NSError * error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if(error)
        return;
    
    NSArray *routesArray = [json objectForKey:@"routes"];
    
    if ([routesArray count] > 0)
    {
        NSDictionary *routeDict = [routesArray objectAtIndex:0];
        arrDistance = [routeDict objectForKey:@"legs"];
        btnDistance.hidden = FALSE;
        NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
        NSString *points = [routeOverviewPolyline objectForKey:@"points"];
        GMSPath *path = [GMSPath pathFromEncodedPath:points];
        GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
        polyline.strokeWidth = 2.0f;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if(polyline)
                polyline.map = mapView;
        });
    }
}

@end

#pragma mark - GMMarker Information Class -


@implementation GMLocation
-(instancetype)initWithTitle:(NSString *)strTitle detailMessage:(NSString *) strDetail Latitude:(float)latitude Longitude:(float)longitude {
    self.name = strTitle;
    self.detail = strDetail;
    self.position = CLLocationCoordinate2DMake(latitude, longitude);
    self.markerType = GMMarkerTypeOther;
    return self;
}
+(instancetype)getSourceLocationFrom:(NSArray <GMLocation *> *)arrLocations{
    return [[GMLocation getLocationsLocationType:GMMarkerTypeSource From:arrLocations] firstObject];
}
+(instancetype)getDestinationLocationFrom:(NSArray <GMLocation *> *)arrLocations{
    return [[GMLocation getLocationsLocationType:GMMarkerTypeDestination From:arrLocations] firstObject];
}
+(NSArray <GMLocation *> *)getViaLocationFrom:(NSArray <GMLocation *> *)arrLocations{
    return [GMLocation getLocationsLocationType:GMMarkerTypeVia From:arrLocations];
}
+(NSArray <GMLocation *> *)getLocationsLocationType:(GMMarkerType)type From:(NSArray <GMLocation *> *)arrLocations {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"markerType = %d",type];
    return [arrLocations filteredArrayUsingPredicate:predicate];
}
-(NSString *)description{
    return [NSString stringWithFormat:@"name %@",self.name];
}
@end