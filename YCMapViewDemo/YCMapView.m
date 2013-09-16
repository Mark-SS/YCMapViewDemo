//
//  YCMapView.m
//  MKMapRouteDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import "YCMapView.h"

@implementation YCMapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)showRouteFrom:(CLLocationCoordinate2D)staPoint
                   to:(CLLocationCoordinate2D)endPoint
{
    
    
}

//获取两点之间的路线
- (NSMutableArray *)calculateRouteFrom:(CLLocationCoordinate2D)staPoint
                                    to:(CLLocationCoordinate2D)endPoint
{
    
}

- (void)updateRouteView {
    [_map removeOverlays:_map.overlays];
    
    
}

@end

