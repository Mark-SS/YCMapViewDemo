//
//  YCAnnotationView.m
//  YCMapViewDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import "YCAnnotationView.h"

@implementation YCAnnotationView

- (id)initWithAnnotation:(id<MKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.frame = CGRectMake(0, 0, 50, 50);
        UIImage *image = [UIImage imageNamed:@"t_m_Pinche.png"];
        self.mapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.mapBtn.frame = CGRectMake(0, 0, image.size.width, image.size.height);
        [self.mapBtn setImage:image forState:UIControlStateNormal];
        [self addSubview:self.mapBtn];
    }
    
    return self;
}

@end
