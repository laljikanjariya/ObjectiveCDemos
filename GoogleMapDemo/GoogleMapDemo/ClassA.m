//
//  ClassA.m
//  GoogleMapDemo
//
//  Created by Siya9 on 16/03/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import <MessageUI/MessageUI.h>
#import <GoogleMaps/GoogleMaps.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ClassA : GMSPolyline {
}

-(void)methodA;

@end

@interface ClassB : UIView {
}

-(void)methodB;

@end

@interface MyPolyline : NSObject {
    ClassA *a;
    ClassB *b;
}

-(void)methodA;
-(void)methodB;

@end




- (void)addMarkers
{
    if([array count] > 0){
        
        [mapView_ clear];
        GMSMutablePath *path = [GMSMutablePath path];
        GMSMutablePath *currentPath = [GMSMutablePath path];
        
        for (int i = 0; i < [array count]; i++) {
            
            CheckPoints *cp = [array objectAtIndex:i];
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(cp.getLatitude , cp.getLongitude);
            GMSMarker *marker = [GMSMarker markerWithPosition:position];
            //  GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = position;
            NSLog( @"%d", cp.getState );
            NSLog( @"%f", cp.getLatitude);
            NSLog( @"%f", cp.getLongitude );
            NSLog( @"%@", cp.getDesp );
            marker.title = cp.getDesp;
            
            NSString *tmpLat = [[NSString alloc] initWithFormat:@"%f", position.latitude];
            NSString *tmpLong = [[NSString alloc] initWithFormat:@"%f", position.longitude];
            marker.snippet = [NSString stringWithFormat:@"%@ %@", tmpLat,tmpLong];
            UIColor *color;
            GMSPolyline *polyline ;
            if (cp.getState ==0) {
                color = [UIColor greenColor];
                [path addLatitude:cp.getLatitude longitude:cp.getLongitude];
            } else {
                color = [UIColor redColor];
            }
            if(i > [array indexOfObject:array.lastObject] -2){
                [currentPath addLatitude:cp.getLatitude longitude:cp.getLongitude];
            }
            polyline = [GMSPolyline polylineWithPath:path];
            polyline.geodesic = YES;
            polyline.strokeWidth = 5.f;
            // polyline.strokeColor = [UIColor redColor];
            GMSStrokeStyle *solidRed = [GMSStrokeStyle solidColor:[UIColor redColor]];
            GMSStrokeStyle *solidRGreen = [GMSStrokeStyle solidColor:[UIColor greenColor]];
            polyline.spans = @[[GMSStyleSpan spanWithStyle:solidRed segments:[array count]-1],
                               [GMSStyleSpan spanWithStyle:solidRGreen segments:2]];
            marker.icon = [GMSMarker markerImageWithColor:color];
            marker.map = mapView_;
            polyline.map = mapView_;
        }
        
    }
}
