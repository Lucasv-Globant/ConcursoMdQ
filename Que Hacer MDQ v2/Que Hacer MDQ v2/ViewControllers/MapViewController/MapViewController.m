//
//  MapViewController.m
//  Que Hacer MDQ v2
//
//  Created by Lucas on 4/14/15.
//  Copyright (c) 2015 Globant iOS MDQ. All rights reserved.
//

#import "MapViewController.h"



@interface MapViewController ()
@property (strong, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.mapView.delegate = self;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-38.0255351f,-57.531561f);
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1f,0.1f)) animated:YES];
    MKPointAnnotation* mkpa = [[MKPointAnnotation alloc] init];
    
    NSString* areaDescr = [Area getAreaSingularDescriptionById:self.activity.areaId];
    mkpa.title = [NSString stringWithFormat:@"%@:%@",areaDescr,self.activity.name];
    mkpa.subtitle = self.activity.desc;
    mkpa.coordinate = coord;
    [self.mapView addAnnotation:mkpa];
    [self.mapView selectAnnotation:mkpa animated:YES];
    
}

-(void)setupforSingleActivity:(Activity*)activity
{
    self.activity = activity;
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(-38.0109844f,-57.5357881f);
    [self.mapView setShowsUserLocation:YES];
    [self.mapView setRegion:MKCoordinateRegionMake(coord, MKCoordinateSpanMake(0.1f,0.1f)) animated:YES];
    MKPointAnnotation* mkpa = [[MKPointAnnotation alloc] init];
    
    NSString* areaDescr = [Area getAreaSingularDescriptionById:self.activity.areaId];
    mkpa.title = [NSString stringWithFormat:@"%@:%@",areaDescr,self.activity.name];
    mkpa.subtitle = self.activity.desc;
    mkpa.coordinate = coord;
    [self.mapView addAnnotation:mkpa];
    [self.mapView selectAnnotation:mkpa animated:YES];
//-38.0109844
//-57.5357881

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark MKMapView delegate methods
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{

}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    return nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
