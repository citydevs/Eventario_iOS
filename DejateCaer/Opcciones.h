//
//  Opcciones.h
//  DejateCaer
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 04/04/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Opcciones : UIView
@property (weak, nonatomic) IBOutlet UIButton *Aceptar;
@property (weak, nonatomic) IBOutlet UISlider *slide;
@property (weak, nonatomic) IBOutlet UILabel *radiolbl;
-(IBAction)terminos:(id)sender;
-(IBAction)acerca:(id)sender;
@end
