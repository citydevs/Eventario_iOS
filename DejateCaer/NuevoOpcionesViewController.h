//
//  NuevoOpcionesViewController.h
//  DejateCaer
//
//  Created by Carlos Castellanos on 08/11/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NuevoOpcionesViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *Aceptar;
@property (weak, nonatomic) IBOutlet UISlider *slide;
@property (weak, nonatomic) IBOutlet UILabel *radiolbl;
-(IBAction)terminos:(id)sender;
-(IBAction)acerca:(id)sender;
@end
