//
//  YCAnnotationView.h
//  YCMapViewDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "YCMapAnnotation.h"

@interface YCAnnotationView : MKAnnotationView

@property (nonatomic, strong) UIButton *mapBtn; //大头针btn

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier;

@end
