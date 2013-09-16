//
//  YCMapAnnotation.m
//  YCMapViewDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import "YCMapAnnotation.h"

@implementation YCMapAnnotation

- (id)initWithCoord:(CLLocationCoordinate2D)coor
{
    if (self = [super init])
    {
        _coordinate = coor;
    }
    
    return self;
}


@end
