//
//  ViewController.m
//  FirstMapsApp
//
//  Created by Michael McChesney on 1/13/15.
//  Copyright (c) 2015 Max McChesney. All rights reserved.
//

#import "ViewController.h"
//#import <GoogleMaps/GoogleMaps.h>
//import CoreLocation

@interface ViewController ()

@end

@implementation ViewController
{
    GMSMapView *mapView_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    // ORIGINAL GOOGLE MAP SETTINGS
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:33.781896
                                                            longitude:-84.36612300000002
                                                                 zoom:16];
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;
    
    // Creates a marker in the center of the map.
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(33.781896, -84.36612300000002);
    marker.title = @"650 Virginia Ave";
    marker.snippet = @"Atlanta, GA";
    marker.map = mapView_;
    
    // MY CODE
    NSLog(@"User's location: %@", mapView_.myLocation);
    

    mapView_.settings.myLocationButton = YES;
    mapView_.settings.compassButton = YES;
    



    
    
    
    
    
}

#pragma mark - GMSMapViewDelegate

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate {
    NSLog(@"You tapped at %f,%f", coordinate.latitude, coordinate.longitude);
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
