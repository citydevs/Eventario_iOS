//
//  Opcciones.m
//  DejateCaer
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 04/04/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "Opcciones.h"
#import "AppDelegate.h"
@implementation Opcciones
{
    AppDelegate *delegate;
    double radio;
}
- (id)initWithFrame:(CGRect)frame
{
    UIImage *thumbImage = [UIImage imageNamed:@"slider2.png"];
    [[UISlider appearance] setThumbImage:thumbImage
                                forState:UIControlStateNormal];
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self inicio];
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpInside];
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpOutside];
        
        [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
        delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    }
    return self;
}
-(void)loadView{
   
   
    
    [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpInside];
    [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpOutside];
    [self inicio];
    [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
    delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];

}
- (IBAction)Aceptar:(id)sender {
    
    if (radio<1) {
        radio=0.05;
        delegate.user_radio=@"0.5";
    }else{
        delegate.user_radio=[NSString stringWithFormat:@"%.0f",radio];}
    [[NSNotificationCenter defaultCenter] postNotificationName:@"actualizar" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aceptar"  object:self];
    
}
-(IBAction)atras:(id)sender{
 [[NSNotificationCenter defaultCenter] postNotificationName:@"aceptar"  object:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
 */
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
-(void)inicio{
    UIImage *thumbImage = [UIImage imageNamed:@"slider2.png"];
    [[UISlider appearance] setThumbImage:thumbImage
                                forState:UIControlStateNormal];

     radio=[delegate.user_radio doubleValue];
    if (radio==0) {
       // radio=500;
    }
    if (radio>=1) {
        //radio=radio;
        _radiolbl.text= [NSString stringWithFormat:@"%.0f km.",radio];
    }
    else{
        _radiolbl.text=@"500 m.";
     //   _radiolbl.text= [NSString stringWithFormat:@"%f m.",radio];
	}

}
- (IBAction) slideRadioChangee:(UISlider *)sender {
    
     radio = [[NSString stringWithFormat:@" %.1f", [sender value]] doubleValue];
   
    if (radio==0) {
        radio=0.05;
        // delegate.user_radio=@"0.5";
    }
    if (radio>=0.1) {
        _radiolbl.text= [NSString stringWithFormat:@"%.0f km.",radio*10];
        radio=radio*10;

        
    }
    else if (radio==0.5)
    {
    _radiolbl.text=@"500";
    }
    else{
         _radiolbl.text=@"500 m.";
        // _radiolbl.text= [NSString stringWithFormat:@"%.0f m.",radio*10];
	}
    
    NSLog(@"%f",radio );
}

- (void) slidingStopped:(id)sender
{
    NSLog(@"stopped sliding");
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"actualizar" object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [self inicio];
}

-(void)willMoveToSuperview:(UIView *)newSuperview {
    UIImage *thumbImage = [UIImage imageNamed:@"slider2.png"];
    [[UISlider appearance] setThumbImage:thumbImage
                                forState:UIControlStateNormal];
    if (delegate.isOption) {
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpInside];
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpOutside];
        [self inicio];
        [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
        delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    }
}

-(void)didMoveToSuperview{
    
     delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    if ([delegate.user_radio isEqualToString:@"0.5"]) {
        _slide.value=0;
    }else
    {
    _slide.value=[delegate.user_radio doubleValue]/10;
    }
        if (delegate.isOption) {
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpInside];
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpOutside];
        [self inicio];
        [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
       
    }


}
-(IBAction)acerca:(id)sender{

    UIAlertView *acerca=[[UIAlertView alloc]initWithTitle:@"Acerca de Eventario" message:@"Eventario es una aplicación móvil que determina tu localización y te sugiere los eventos que la ciudad promueve. Al seleccionar un evento, la aplicación te muestra una descripción con detalles como la fecha, hora, lugar y precio, además de que te indica cómo llegar. Para encontrar actividades también puedes ingresar una dirección específica o usar la navegación en el mapa. La información de los eventos que encuentres la puedes compartir en Facebook y en Twitter, para así ayudar a promover las actividades que te parezcan más interesantes." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [acerca show];
}

-(IBAction)terminos:(id)sender{
    
    UIAlertView *terminos=[[UIAlertView alloc]initWithTitle:@"Términos de Uso" message:@"Esta aplicación es de código abierto, desarrollada durante el programa CódigoCDMX del LabPLC, puedes encontrar más información en www.eventario.mx" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [terminos show];
}

-(IBAction)creditos:(id)sender{
    
    UIAlertView *creditos=[[UIAlertView alloc]initWithTitle:@"Créditos" message:@"Eventario fué derrollado por Carlos Castellanos - iOS Developer \n Mike Morán - Android Developer \n Juan Carlos Sánchez - Ruby Developer \n en colaboración de Gabriela Olivera y Jóse Espinosa." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [creditos show];
}

@end
