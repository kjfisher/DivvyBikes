//
//  DetailViewController.m
//  DivvyBikes
//
//  Created by Kristen L. Fisher on 5/30/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "DetailViewController.h"
#import <MapKit/MapKit.h>

@interface DetailViewController ()
@property (strong, nonatomic) MKPointAnnotation *bikeAnnotation;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.bikeAnnotation = [[MKPointAnnotation alloc] init];
    self.bikeAnnotation.coordinate = CLLocationCoordinate2DMake([self.bikesDictionary[@"latitude"] doubleValue],
                                                                [self.bikesDictionary[@"longitude"] doubleValue]);
    self.bikeAnnotation.title = self.bikesDictionary[@"stationName"];
    [self.mapView addAnnotation:self.bikeAnnotation];

    self.mapView.showsUserLocation = YES;

}



@end
