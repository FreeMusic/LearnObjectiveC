//
//  XYMapVC.m
//  LearnObjectiveC
//
//  Created by 乐逍遥 on 2023/11/21.
//  Copyright © 2023 橘子. All rights reserved.
//

#import "XYMapVC.h"
#import <MapKit/MapKit.h>

@interface XYMapVC ()<MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *mapView;//

@end

@implementation XYMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.mapView];
    CLLocationCoordinate2D coords[5] = {0};
    coords[0] = CLLocationCoordinate2DMake(39.968, 116.260);
    coords[1] = CLLocationCoordinate2DMake(39.912, 116.324);
    coords[2] = CLLocationCoordinate2DMake(39.968, 116.373);
    coords[3] = CLLocationCoordinate2DMake(39.912, 116.439);
    coords[4] = CLLocationCoordinate2DMake(39.968, 116.490);
    MKPolyline *polyline = [MKPolyline polylineWithPoints:coords count:5];
    [self.mapView addOverlay:polyline];
}

- (MKMapView *)mapView {
    if (_mapView == nil){
        _mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
        _mapView.delegate = self;
//        MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(29.451234, 107.523456), MKCoordinateSpanMake(0.05, 0.05));
//        [_mapView setRegion:region];
    }
    
    return _mapView;
}

- (MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay {
    
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineView *polylineView = [[MKPolylineView alloc] initWithOverlay:overlay];
        polylineView.strokeColor = (__bridge UIColor *)([UIColor redColor].CGColor);
        polylineView.lineWidth = 2;
        return polylineView;
    }
    
    return nil;
}

@end
