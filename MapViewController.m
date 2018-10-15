//
//  MapViewController.m
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()
{
    NSMutableArray* matchingItems;
}

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager requestAlwaysAuthorization];
    
    [self.locationManager startUpdatingLocation];
    
    self.mapView.showsUserLocation = YES;
    self.mapView.showsUserLocation = YES;
}


- (IBAction)setMapType:(id)sender {
    switch (((UISegmentedControl*)sender).selectedSegmentIndex) {
        case 0:
            self.mapView.mapType = MKMapTypeStandard;
            break;
        case 1:
            self.mapView.mapType = MKMapTypeSatellite;
            break;
        case 2:
            self.mapView.mapType = MKMapTypeHybrid;
            break;
            
        default:
            break;
    }
    
}
- (IBAction)search:(id)sender {
    
    MKLocalSearchRequest *request =
    [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.textField.text;
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(21.1500, 79.0900);
    MKCoordinateRegion coordinate = MKCoordinateRegionMakeWithDistance(location, 5000, 5000);
    [request setRegion:coordinate];
    MKLocalSearch *search =
    [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse
                                         *response, NSError *error) {
        if (response.mapItems.count == 0)
            NSLog(@"No Matches");
        else
        {
            for (MKMapItem *item in response.mapItems)
            {
                NSLog(@"name = %@", item.name);
                NSLog(@"Phone = %@", item.phoneNumber);
                MKPointAnnotation *annotation =
                [[MKPointAnnotation alloc]init];
                annotation.coordinate = item.placemark.coordinate;
                annotation.title = item.name;
                [self.mapView addAnnotation:annotation];
                NSLog(@"%@",item.name);
            }
        }
    }];
    
}
@end
