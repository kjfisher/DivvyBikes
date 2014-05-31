//
//  ViewController.m
//  DivvyBikes
//
//  Created by Kristen L. Fisher on 5/30/14.
//  Copyright (c) 2014 Mobile Makers. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"
#import <MapKit/MapKit.h>

@interface ViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *bikeTableView;
@property NSArray *bikeArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://www.divvybikes.com/stations/json/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
    {
        NSDictionary *bikesDictionary= [NSJSONSerialization JSONObjectWithData:data
                                                                       options:NSJSONReadingAllowFragments
                                                                         error:&connectionError];
        self.bikeArray = bikesDictionary[@"stationBeanList"];

        NSLog(@"%@", self.bikeArray);
        [self.bikeTableView reloadData];

    }];

}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.bikeArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *bike = self.bikeArray[indexPath.row]; //self.bikeArray objectAtIndex: indexPath.row
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyCellID"];

    cell.textLabel.text = bike [@"stationName"];
    NSInteger availableBikes = [bike[@"availableBikes"] integerValue];
    NSInteger availableDocks = [bike[@"availableDocks"] integerValue];
    NSString * resultString = [NSString stringWithFormat:@"Bikes: %zd, Slots: %zd", availableBikes, availableDocks];
    cell.detailTextLabel.text = resultString;
    return cell;
}

#pragma mark - Segue Methods
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *selectedIndexPath = self.bikeTableView.indexPathForSelectedRow;
    NSDictionary *selectedLocation = [self.bikeArray objectAtIndex:selectedIndexPath.row];
    DetailViewController *eventDetails= segue.destinationViewController;
    eventDetails.bikesDictionary = selectedLocation;
}

//#pragma mark - UITableView Delegate
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//
//
//
//
//
//
//}

@end
