//
//  GoogleMapVC.h
//  GoogleMapDemo
//
//  Created by Siya9 on 12/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <Google-Maps-iOS-Utils/GMUMarkerClustering.h>

typedef NS_ENUM(NSInteger, GooglMapDrow)
{
    GMDrowPathTowPointRoute,
    GMDrowPathMultiplePoint,
};
typedef NS_ENUM(NSInteger, GMMarkerType)
{
    GMMarkerTypeCurrent = 1,
    GMMarkerTypeSource,
    GMMarkerTypeDestination,
    GMMarkerTypeVia,
    GMMarkerTypeOther,
};
@interface GoogleMapVC : UIViewController
@property (nonatomic, strong) NSArray * arrLocations;
@property (nonatomic) GooglMapDrow anotationType;
@property (nonatomic) BOOL isShowLocation;
@end


@interface GMLocation : NSObject<GMUClusterItem>

@property (nonatomic) CLLocationCoordinate2D position;
@property (nonatomic) GMMarkerType markerType;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * detail;
-(instancetype)initWithTitle:(NSString *)strTitle detailMessage:(NSString *) strDetail Latitude:(float)latitude Longitude:(float)longitude;


+(instancetype)getSourceLocationFrom:(NSArray <GMLocation *> *)arrLocations;
+(instancetype)getDestinationLocationFrom:(NSArray <GMLocation *> *)arrLocations;
+(NSArray <GMLocation *> *)getViaLocationFrom:(NSArray <GMLocation *> *)arrLocations;
+(NSArray <GMLocation *> *)getLocationsLocationType:(GMMarkerType)type From:(NSArray <GMLocation *> *)arrLocations;

@end