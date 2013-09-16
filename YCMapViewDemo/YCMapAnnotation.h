//
//  YCMapAnnotation.h
//  YCMapViewDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface YCMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate; //针的位置信息
@property (nonatomic, copy) NSString *title; //针的标题
@property (nonatomic, copy) NSString *subtitle; //针的副标题

- (id)initWithCoord:(CLLocationCoordinate2D)coor;

@end
