//
//  NuevoOpcionesViewController.m
//  DejateCaer
//
//  Created by Carlos Castellanos on 08/11/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "NuevoOpcionesViewController.h"
#import "AppDelegate.h"
@interface NuevoOpcionesViewController ()

@end

@implementation NuevoOpcionesViewController
{
    AppDelegate *delegate;
    double radio;
}
- (void)viewDidLoad {
    
    
    UIImage *thumbImage = [UIImage imageNamed:@"slider2.png"];
    [[UISlider appearance] setThumbImage:thumbImage
                                forState:UIControlStateNormal];
    
        // Initialization code
       [self inicio];
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpInside];
        [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpOutside];
        
        [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
        delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
       [super viewDidLoad];

    // Do any additional setup after loading the view.
}/*
-(void)loadView{
    
    
    
    [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpInside];
    [_slide addTarget:self action:@selector(slidingStopped:)forControlEvents:UIControlEventTouchUpOutside];
    [self inicio];
    [[NSUserDefaults standardUserDefaults] stringForKey:@"nombre"];
    delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
}*/
- (IBAction)Aceptar:(id)sender {
    
    if (radio<1) {
        radio=0.05;
        delegate.user_radio=@"0.5";
    }else{
        delegate.user_radio=[NSString stringWithFormat:@"%.0f",radio];}
    [[NSNotificationCenter defaultCenter] postNotificationName:@"actualizar" object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"aceptar"  object:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (radio<1) {
        radio=0.05;
        delegate.user_radio=@"0.5";
    }else{
        delegate.user_radio=[NSString stringWithFormat:@"%.0f",radio];}
}

- (void) slidingStopped:(id)sender
{
    NSLog(@"stopped sliding");
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"actualizar" object:nil];
}
/*
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
    
    
}*/
-(IBAction)acerca:(id)sender{
    
    UIAlertView *acerca=[[UIAlertView alloc]initWithTitle:@"Acerca de Eventario" message:@"Eventario es una aplicación móvil que determina tu localización y te sugiere los eventos que la ciudad promueve. Al seleccionar un evento, la aplicación te muestra una descripción con detalles como la fecha, hora, lugar y precio, además de que te indica cómo llegar. Para encontrar actividades también puedes ingresar una dirección específica o usar la navegación en el mapa. La información de los eventos que encuentres la puedes compartir en Facebook y en Twitter, para así ayudar a promover las actividades que te parezcan más interesantes." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [acerca show];
}

-(IBAction)terminos:(id)sender{
    
    UIAlertView *terminos=[[UIAlertView alloc]initWithTitle:@"Términos de Uso" message:@"Esta aplicación es de código abierto,desarrollada por @CityDevs , puedes encontrar más información en www.eventario.mx o en www.citydevs.mx" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [terminos show];
}

-(IBAction)creditos:(id)sender{
    
    UIAlertView *creditos=[[UIAlertView alloc]initWithTitle:@"Créditos" message:@"Eventario fué derrollado por Carlos Castellanos - iOS Developer \n Mike Morán - Android Developer \n Juan Carlos Sánchez - Ruby Developer \n en colaboración de Gabriela Olivera, Jóse Espinosa y Sandra Barrón ." delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
    [creditos show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)viewDidAppear:(BOOL)animated{
    
    [self viewDidLoad];
}



@end
