//
//  DescripcionViewController.h
//  DejateCaer
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 13/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "GAITrackedViewController.h"

@interface DescripcionViewController : GAITrackedViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (nonatomic,retain) NSMutableDictionary *evento;
@property (strong, nonatomic) CLLocationManager *LocationManager;
@property (weak, nonatomic) IBOutlet UIImageView *imagen;














-(IBAction)regresar:(id)sender;
-(IBAction)twittear:(id)sender;
- (IBAction)postToFacebook:(id)sender;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
