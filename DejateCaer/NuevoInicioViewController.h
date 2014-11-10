//
//  NuevoInicioViewController.h
//  DejateCaer
//
//  Created by Carlos Castellanos on 08/11/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "GAITrackedViewController.h"
@interface NuevoInicioViewController : GAITrackedViewController  <UIGestureRecognizerDelegate,MKMapViewDelegate ,UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate,UITextFieldDelegate,UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) CLLocationManager *LocationManager;
@property (nonatomic, retain) IBOutlet MKMapView *mapa;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic,strong)   NSArray *eventos;
@property (nonatomic,strong)   NSArray *original;




@end
