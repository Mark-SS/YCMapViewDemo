//
//  YCViewController.h
//  YCMapViewDemo
//
//  Created by gongliang on 13-9-16.
//  Copyright (c) 2013年 gongliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface YCViewController : UIViewController <UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *map;

@property (weak, nonatomic) IBOutlet UITextField *endText;

@property (nonatomic, strong) NSMutableArray *urlArray;

@end
