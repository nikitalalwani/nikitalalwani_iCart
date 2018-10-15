//
//  MapViewController.h
//  iCart
//
//  Created by Globallogic on 24/02/16.
//  Copyright © 2016 Globallogic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property(strong,nonatomic)CLLocationManager* locationManager;
- (IBAction)setMapType:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)search:(id)sender;


@end
