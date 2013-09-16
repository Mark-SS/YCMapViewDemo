//
//  YCMapView.h
//  MKMapRouteDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface YCMapView : UIView <MKMapViewDelegate>

@property (nonatomic, strong) MKMapView *map; //地图框架

@property (nonatomic, strong) UIImageView *routeView; //路线图

@property (nonatomic, strong) NSArray *routes; //主要从地图中得到路线的坐标

@property (nonatomic, strong) UIColor *lineColor; //路线的颜色


@end
