//
//  ParkingMap.h
//  ispark
//
//  Created by Natanel Partouche on 26/02/12.
//  Copyright (c) 2012 ECE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <MapKit/MKReverseGeocoder.h>
#import <CoreLocation/CoreLocation.h>

@interface ParkingMap : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, retain) NSMutableArray *allAnnotationsArray;
@property (retain, nonatomic) IBOutlet MKMapView *mapView;

-(void)loadDatas;

-(UIImage*)loadImages:(NSString*)logo;


@end