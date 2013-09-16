//
//  YCViewController.m
//  YCMapViewDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import "YCViewController.h"
#import "YCAnnotationView.h"
#import "CLLocation+YCLocation.h"


//void bd_decrypt(double bd_lat, double bd_lon, double *gg_lat, double *gg_lon);

@interface YCViewController ()

@property (nonatomic, strong) YCMapAnnotation *annotation;
@property (nonatomic, assign) CLLocationCoordinate2D userLocation;
@property (nonatomic, assign) CLLocationCoordinate2D endLocation;

@end

@implementation YCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _urlArray = [[NSMutableArray alloc]initWithCapacity:3];
	// Do any additional setup after loading the view, typically from a nib.
    NSLog(@"11");
    _map.showsUserLocation = YES;
    
    _endLocation.longitude = 116.377097;
    _endLocation.latitude = 39.985815;
    _annotation = [[YCMapAnnotation alloc]initWithCoord:_endLocation];
    [_map addAnnotation:_annotation];
    
    //给MapView家一个手势
    UITapGestureRecognizer *mTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapPress:)];
    [_map addGestureRecognizer:mTap];
}

- (void)tapPress:(UIGestureRecognizer *)gesture
{
    CGPoint touchPoint = [gesture locationInView:gesture.view];
    CLLocationCoordinate2D touchMapCoordinate = [_map convertPoint:touchPoint toCoordinateFromView:_map];//这里touchMapCoordinate就是该点的经纬度了
    
    _endLocation = touchMapCoordinate;
    
    [_annotation setCoordinate:touchMapCoordinate];
    
    //显示所在地
    CLLocation *location = [[CLLocation alloc]initWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder  reverseGeocodeLocation:location completionHandler:
     ^(NSArray *placemarks, NSError *error) {
         for (CLPlacemark *placemark in placemarks)
         {
//             NSLog(@"placemark = %@",placemark.addressDictionary);
             self.endText.text = placemark.addressDictionary[@"Name"];
             
         }
     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark mapView delegate
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
   
    _userLocation = userLocation.coordinate;
    [_map setCenterCoordinate:userLocation.coordinate animated:YES];
    [_map setRegion:MKCoordinateRegionMake(userLocation.coordinate, MKCoordinateSpanMake(0.3f, 0.3f)) animated:YES];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    static NSString *kPin = @"pin";
    YCAnnotationView *annView = (YCAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:kPin];
    if (!annView) {
        annView = [[YCAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:kPin];
        [annView setDraggable:YES];
        annView.canShowCallout = YES;
    }
    return annView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
}

const double x_pi = 3.14159265358979324 * 3000.0 / 180.0;

void bd_encrypt(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon);
void bd_encrypt(double gg_lat, double gg_lon, double *bd_lat, double *bd_lon)
{
    double x = gg_lon, y = gg_lat;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    *bd_lon = z * cos(theta) + 0.0065;
    *bd_lat = z * sin(theta) + 0.006;
}


#pragma mark -
#pragma mark IBOutlet
- (IBAction)navigationBtn:(id)sender {
    if (_urlArray) {
        [_urlArray removeAllObjects];
    }
    UIActionSheet *acitonSheet = [[UIActionSheet alloc]init];
    [acitonSheet addButtonWithTitle:@"使用系统自带地图导航"];

    //高德地图
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *string = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=applicationName&backScheme=YCMap&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=1&style=2",_endLocation.latitude,_endLocation.longitude];
        NSURL *url = [NSURL URLWithString:string];
        NSLog(@"高德地图");
        [_urlArray addObject:url];
        [acitonSheet addButtonWithTitle:@"使用高德地图导航"];
    }
    
    //百度地图
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]) {
        
        CLLocation *cll = [[CLLocation alloc]initWithLatitude:_userLocation.latitude longitude:_userLocation.longitude];
        cll = [cll locationBaiduFromMars];
        CLLocation *cll2 = [[CLLocation alloc]initWithLatitude:_endLocation.latitude longitude:_endLocation.longitude];
        cll2 = [cll2 locationBaiduFromMars];
        NSString *string = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=driving",cll.coordinate.latitude,cll.coordinate.longitude,cll2.coordinate.latitude,cll2.coordinate.longitude,_endText.text];
        NSURL *url = [NSURL URLWithString:[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"百度地图");
        [_urlArray addObject:url];
        [acitonSheet addButtonWithTitle:@"使用百度地图导航"];
    }

    //google地图
    if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString *string = [NSString stringWithFormat:@"comgooglemaps://?saddr=%f,%f&daddr=%f,%f",_userLocation.latitude,_userLocation.longitude,_endLocation.latitude,_endLocation.longitude];
        NSString *url = [NSURL URLWithString:string];
        NSLog(@"google");
        [_urlArray addObject:url];
        [acitonSheet addButtonWithTitle:@"使用google地图导航"];
    }
   
    [acitonSheet addButtonWithTitle:@"取消"];
    acitonSheet.delegate = self;
    [acitonSheet showInView:self.view];
}

#pragma mark -
#pragma mark actionSheet Delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    NSLog(@"ind = %d, %d",buttonIndex,_urlArray.count);
    
    if (buttonIndex == _urlArray.count+1) {
        return ;
    }
    
    switch (buttonIndex) {
        case 0: {
            CLLocationCoordinate2D to = _endLocation;
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            toLocation.name = _endText.text;
            [MKMapItem openMapsWithItems:[NSArray arrayWithObjects:currentLocation, toLocation, nil]
                           launchOptions:[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeDriving,
                                                                              [NSNumber numberWithBool:YES], nil]
                                                                     forKeys:[NSArray arrayWithObjects:MKLaunchOptionsDirectionsModeKey,
                                                                              MKLaunchOptionsShowsTrafficKey, nil]]];
        }
            break;
        default: {
            [[UIApplication sharedApplication]openURL:_urlArray[buttonIndex-1]];
        }
            break;
    }
    
  
}



@end
