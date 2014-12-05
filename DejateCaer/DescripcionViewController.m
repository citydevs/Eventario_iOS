//
//  DescripcionViewController.m
//  DejateCaer
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 13/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "Mipin.h"
#import "DescripcionViewController.h"
#import "ViewController.h"
#import <Social/Social.h>
#import "AppDelegate.h"
#import "MapaViewController.h"
#import "ResenaViewController.h"
@interface DescripcionViewController ()

@end

@implementation DescripcionViewController
{
  //  MKMapView *mapa;
    AppDelegate *delegate;
    UIView *reseña;
    UIView *preciov;
    UIView *contactov;
    
    //Outlets
    UILabel *nombre;
    
    UILabel *categoria;
    UIImageView *img_cat;
    
    UILabel *horario;
    UIImageView *img_hora;
    
    UILabel *fecha;
    UIImageView *img_fecha;
    
    UILabel *direccion;
    
    UILabel *lugar;
    UIImageView *img_lugar;
    
    MKMapView *mapa;
    
    UILabel *precio;
    UIImageView* img_precio;
    UITextView *descripcion;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) tapped
{
    [self.view endEditing:YES];
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad

{
    
     self.screenName = @"Descripción de Evento";
    
 
  
    //declaramos un variable que nos servira como delegado
  
    delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    _imagen.image=[delegate.cacheImagenes objectForKey:[_evento objectForKey:@"imagen"]];
    _imagen.layer.cornerRadius = 30;
    _imagen.layer.masksToBounds = YES;
 
    
    

    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self     action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    
    [_scrollView addGestureRecognizer:tapScroll];
   

    _scrollView.backgroundColor=[UIColor whiteColor];
    [_scrollView setScrollEnabled:YES];
    
    
    //Localizamos al usuario
    _LocationManager = [[CLLocationManager alloc] init];
    _LocationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    _LocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [_LocationManager startUpdatingLocation];
    
    //[_btnEventos.titleLabel setFont:[UIFont fontWithName:@"NIISansLight" size:19]];
   // [_btnEventos.titleLabel setFont:[UIFont systemFontOfSize:10]];
    
    // Del objeto tomamos  el nombr del evento
    nombre=[[UILabel alloc]initWithFrame:CGRectMake(20, 20, 280, 100)];
    nombre.text=[_evento objectForKey:@"nombre"];
    nombre.numberOfLines=5;
    [nombre setFont:[UIFont fontWithName:@"Lato-Black" size:24]];
    [_scrollView addSubview:nombre];
   [nombre sizeToFit];
    nombre.frame=CGRectMake(19, 8, 288, nombre.frame.size.height);
   
    // DEbajo del texto del titulo coloco la categoria
    img_cat=[[UIImageView alloc]initWithFrame:CGRectMake(17, nombre.frame.size.height+5, 25, 25)];
    categoria=[[UILabel alloc]initWithFrame:CGRectMake(78, 100+5, 253, 22)];
    img_cat.image=[UIImage imageNamed:[_evento objectForKey:@"categoria"]];
    img_cat.frame=CGRectMake(17, nombre.frame.size.height+15, 25, 25);
    categoria.text=[_evento objectForKey:@"categoria"];
    categoria.textColor=[UIColor colorWithRed:(13/255.0) green:(77/255.0) blue:(236/255.0) alpha:1];
    [categoria setFont:[UIFont fontWithName:@"Lato-BlackItalic" size:16]];

    categoria.frame=CGRectMake(50, nombre.frame.size.height+15, 253, 22);
    [_scrollView addSubview:img_cat];
    [_scrollView addSubview:categoria];
    
    // divido con una linea quqe sera una view
    UIView *s1=[[UIView alloc]initWithFrame:CGRectMake(20, categoria.frame.origin.y +categoria.frame.size.height+10, 300, 1)];
    s1.backgroundColor=[UIColor colorWithRed:(13/255.0) green:(77/255.0) blue:(236/255.0) alpha:1];
    [_scrollView addSubview:s1];
    
    // DEspues de la linea vienen el horario y la fecha con imagenes
    
    img_hora=[[UIImageView alloc]initWithFrame:CGRectMake(20, s1.frame.origin.y+11, 25, 25)];
    img_hora.image=[UIImage imageNamed:@"hora.png"];
    
    [_scrollView addSubview:img_hora];
    // separa la hora de la fecha
    NSString *horasfin= [[_evento objectForKey:@"hora_fin"]
                      stringByReplacingOccurrencesOfString:@"2000-01-01T" withString:@""];
    
   horasfin=[ horasfin stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
    NSString *horas= [[_evento objectForKey:@"hora_inicio"]
                      stringByReplacingOccurrencesOfString:@"2000-01-01T" withString:@""];
    horas=[ horas stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
    
    horario=[[UILabel alloc]initWithFrame:CGRectMake(50, s1.frame.origin.y+11, 100, 25)];

    horario.text=[NSString stringWithFormat:@("%@ - %@"),horas,horasfin];
    [horario sizeToFit];
    
    [horario setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
    horario.textColor=[UIColor colorWithRed:(108/255.0) green:(108/255.0) blue:(108/255.0) alpha:1];
    
    [_scrollView addSubview:horario];
    
    img_fecha=[[UIImageView alloc]initWithFrame:CGRectMake(horario.frame.size.width+5+horario.frame.origin.x, s1.frame.origin.y+11, 25, 25)];
    img_fecha.image=[UIImage imageNamed:@"calendario.png"];
    [_scrollView addSubview:img_fecha];
    
    fecha=[[UILabel alloc]initWithFrame:CGRectMake(img_fecha.frame.size.width+5+img_fecha.frame.origin.x, s1.frame.origin.y+11, 100, 25)];
    [fecha setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
    fecha.textColor=[UIColor colorWithRed:(108/255.0) green:(108/255.0) blue:(108/255.0) alpha:1];

    NSArray* f1 = [[_evento objectForKey:@"fecha_inicio"] componentsSeparatedByString: @"-"];
    
    NSString* nf1 = [NSString stringWithFormat:@("%@/%@/%@"),[f1 objectAtIndex: 2],[self convertMonth:[f1 objectAtIndex: 1]],[f1 objectAtIndex: 0]];
    
    
    NSArray* f2 = [[_evento objectForKey:@"fecha_fin"] componentsSeparatedByString: @"-"];
    
    NSString* nf2 = [NSString stringWithFormat:@("%@/%@/%@"),[f2 objectAtIndex: 2],[self convertMonth:[f2 objectAtIndex: 1]],[f2 objectAtIndex: 0]];
    
    
    fecha.numberOfLines=2;
    fecha.text=[NSString stringWithFormat:@("%@ - %@"),nf1,nf2];
    [fecha sizeToFit];
    [_scrollView addSubview:fecha];
    
    //divido con otra linea azul S2
    
    
    UIView *s2=[[UIView alloc]initWithFrame:CGRectMake(20, fecha.frame.origin.y +fecha.frame.size.height+10, 300, 1)];
    
    s2.backgroundColor=[UIColor colorWithRed:(13/255.0) green:(77/255.0) blue:(236/255.0) alpha:1];
    [_scrollView addSubview:s2];
    
    // despues de la divicion va los datos del lugar
    
    img_lugar=[[UIImageView alloc]initWithFrame:CGRectMake(20, s2.frame.origin.y+11, 25, 25)];
    img_lugar.image=[UIImage imageNamed:@"marker.png"];
    [_scrollView addSubview: img_lugar];
    
    lugar=[[UILabel alloc]initWithFrame:CGRectMake(50, s2.frame.origin.y+11, 25, 25)];
     lugar.text=[_evento objectForKey:@"lugar"];
    [lugar setFont:[UIFont fontWithName:@"Lato-Bold" size:20]];
    [lugar sizeToFit];
    lugar.textColor=[UIColor colorWithRed:(13/255.0) green:(77/255.0) blue:(236/255.0) alpha:1];
    lugar.numberOfLines=3;
    lugar.frame=CGRectMake(50, s2.frame.origin.y+11, 250, lugar.frame.size.height);
   
    [_scrollView addSubview: lugar];
    
   
    // agrego la direccion debajo del venue
    direccion=[[UILabel alloc]initWithFrame:CGRectMake(50, lugar.frame.size.height+lugar.frame.origin.y +5, 250, 50)];
    direccion.text=[_evento objectForKey:@"direccion"];
    [direccion setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
    direccion.numberOfLines=5;
    direccion.textColor=[UIColor colorWithRed:(108/255.0) green:(108/255.0) blue:(108/255.0) alpha:1];
    [direccion sizeToFit];
    direccion.frame=CGRectMake(50, lugar.frame.size.height+lugar.frame.origin.y +5, 250, direccion.frame.size.height);
    
    
    [_scrollView addSubview:direccion];
    
    
    // checamos si viene el contacto ya sea un mail o telefono y lo ponemos debajo de la direccion
    int topMapa;
    if ([[_evento objectForKey:@"contacto"] isEqualToString:@"No disponible"]) {
     
        // no lo ponemos
        //checamos si tiene sitio web
        
        if ([[_evento objectForKey:@"pagina"] isEqualToString:@"No disponible"]) {
           // no lo ponemos
            topMapa=direccion.frame.size.height+direccion.frame.origin.y +5;
        }
        else{
        UIButton *web=[[UIButton alloc]initWithFrame:CGRectMake(50, direccion.frame.size.height+direccion.frame.origin.y +5, 100, 40)];
            [web setTitle:@"Visitar Sitio" forState:UIControlStateNormal];
            web.tintColor=[UIColor whiteColor];
            [web addTarget:self
                    action:@selector(web:)
          forControlEvents:UIControlEventTouchUpInside];
            web.backgroundColor=[UIColor blackColor];
            [_scrollView addSubview:web];
            topMapa=web.frame.size.height+web.frame.origin.y+5;
        }
    }
    else{
    // si tiene un contacto
        UILabel* contacto=[[UILabel alloc]initWithFrame:CGRectMake(50, direccion.frame.size.height+direccion.frame.origin.y +5, 300, 50)];
        [contacto setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
        contacto.numberOfLines=5;
        contacto.text=[_evento objectForKey:@"contacto"];
        contacto.textColor=[UIColor colorWithRed:(108/255.0) green:(108/255.0) blue:(108/255.0) alpha:1];
        [contacto sizeToFit];
        contacto.frame=CGRectMake(50, direccion.frame.size.height+direccion.frame.origin.y +5, 300, contacto.frame.size.height);
        [_scrollView addSubview:contacto];
        topMapa=contacto.frame.size.height+contacto.frame.origin.y +5;
        
        if ([[_evento objectForKey:@"pagina"] isEqualToString:@"No disponible"]) {
            // no lo ponemos
        }
        else{
            UIButton *web=[[UIButton alloc]initWithFrame:CGRectMake(50, contacto.frame.size.height+contacto.frame.origin.y +5, 100, 40)];
            [web addTarget:self
                           action:@selector(web:)
                 forControlEvents:UIControlEventTouchUpInside];
            [web setTitle:@"Visitar Sitio" forState:UIControlStateNormal];
            web.tintColor=[UIColor whiteColor];
            web.backgroundColor=[UIColor blackColor];
            [_scrollView addSubview:web];
            topMapa=web.frame.size.height+web.frame.origin.y+5;
        }
        
    
    }
    
    
    //Despues de esa sección viene el mapa
    mapa=[[MKMapView alloc]initWithFrame:CGRectMake(0, topMapa, 320, 150)];
    mapa.scrollEnabled=NO;
    UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(touchMap)];
    [mapa addGestureRecognizer:tapRec];
    [mapa setDelegate:self];
    [_scrollView addSubview:mapa];
    CLLocationCoordinate2D SCL;
    SCL.latitude = [[_evento objectForKey:@"latitud"] doubleValue];
    SCL.longitude = [[_evento objectForKey:@"longitud"]doubleValue];
    
    CGFloat newLat = [[_evento objectForKey:@"latitud"] doubleValue];
    CGFloat newLon = [[_evento objectForKey:@"longitud"]doubleValue];
    
    CLLocationCoordinate2D newCoord = {newLat, newLon};
    
    Mipin *annotationPoint = [[Mipin alloc] initWithTitle:[_evento objectForKey:@"nombre"] subtitle:[_evento objectForKey:@"direccion"] andCoordinate:newCoord tipo:@"" evento:0 lugar:[_evento objectForKey:@"lugar"] hora:[_evento objectForKey:@"hora"]];
    
    [mapa addAnnotation:annotationPoint];
    [mapa setShowsUserLocation:YES];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newCoord, 2000, 2000);
    [mapa setRegion:region animated:YES];
    
    
  //despues del mapa
    descripcion=[[UITextView alloc]initWithFrame:CGRectMake(20, 0, 280, 100)];
    descripcion.editable=FALSE;
    descripcion.text=[_evento objectForKey:@"descripcion"];
    [descripcion sizeToFit];
    if ([[_evento objectForKey:@"precio"] isEqualToString:@"No disponible"]) {
        descripcion.frame=CGRectMake(20, mapa.frame.size.height+mapa.frame.origin.y+10, 280, descripcion.frame.size.height);
    }
    else{
    
        img_precio=[[UIImageView alloc]initWithFrame:CGRectMake(20, mapa.frame.size.height+mapa.frame.origin.y+10, 25, 25)];
        img_precio.image=[UIImage imageNamed:@"dinero0.png"];
        [_scrollView addSubview:img_precio];
        precio=[[UILabel alloc]initWithFrame:CGRectMake(50, mapa.frame.size.height+mapa.frame.origin.y+10, 250, 100)];
        precio.text=[_evento objectForKey:@"precio"];
        [precio setFont:[UIFont fontWithName:@"Lato-Bold" size:15]];
        precio.numberOfLines=6;
        [precio sizeToFit];
        precio.frame=CGRectMake(50, mapa.frame.size.height+mapa.frame.origin.y+10, 250, precio.frame.size.height);
        [_scrollView addSubview:precio];
        descripcion.frame=CGRectMake(20, precio.frame.size.height+precio.frame.origin.y+10, 280, descripcion.frame.size.height);
    }
    [_scrollView addSubview: descripcion];
    
    [_scrollView setContentSize:CGSizeMake(320, descripcion.frame.size.height+descripcion.frame.origin.y+10)];
  

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(IBAction)regresar:(id)sender
{
   // [self dismissModalViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)twittear:(id)sender
{
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        NSString *cuerpo=[NSString stringWithFormat:@"Me gusta el evento:%@  @EventarioCDMX #EventarioApp %@",[_evento objectForKey:@"nombre"],[_evento objectForKey:@"url"]];
        [tweetSheet setInitialText:cuerpo];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
    
    else{
    
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No tiene una cuenta de Twitter configurada. Configurala en Ajustes -> Twitter -> Añadir Cuenta" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    
    }
}
- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText:[NSString stringWithFormat:@"Me gusta el evento:%@. #EventarioApp  #EventarioCDMX %@",[_evento objectForKey:@"nombre"],[_evento objectForKey:@"url"]]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
    
    else{
        
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No tiene una cuenta de Facebook configurada. Configurala en Ajustes -> Facebook -> Añadir Cuenta" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
        
    }
}

#pragma mark - MapView Delegate

- (MKAnnotationView *) mapView: (MKMapView *) mapView viewForAnnotation: (id<MKAnnotation>) annotation {
    
    /* if ([annotation isKindOfClass:[CalloutAnnotation class]]) {
     return nil;
     // NSLog(@"fue letrerito");
     }
     else{*/
    Mipin  *anotacion1 = (Mipin*)annotation;
    
    
    // Comprobamos si se trata de la anotación correspondiente al usuario.
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    MKAnnotationView *aView = [[MKAnnotationView alloc] initWithAnnotation:anotacion1 reuseIdentifier:@"pinView"];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [rightButton setTitle:annotation.title forState:UIControlStateNormal];
    [aView setRightCalloutAccessoryView:rightButton];
    
    // [aView setBackgroundColor:[UIColor colorWithRed:(243/255.0) green:(23/255.0) blue:(52/255.0) alpha:0.7]];
    
    aView.canShowCallout = YES;
    aView.enabled = YES;
    aView.centerOffset = CGPointMake(0, -20);
    aView.tag=anotacion1.id_event;
    aView.draggable = YES;
    UIImage *imagen;
    if ([anotacion1.tipo isEqualToString:@"ubicacion"]) {
        imagen = [UIImage imageNamed:@"yo.png"];
    }
    else{
        imagen = [UIImage imageNamed:@"pin3.png"];
    }
    
    aView.image = imagen;
    //\\-------------------------------------------------------------------------------///
    // Establecemos el tamaño óptimo para el Pin
    //\\-------------------------------------------------------------------------------///
    
    if ([anotacion1.tipo isEqualToString:@"ubicacion"]) {
        CGRect frame = aView.frame;
        frame.size.width = 43;
        frame.size.height = 71;
        aView.frame = frame;
    }
    else{
        CGRect frame = aView.frame;
        frame.size.width = 50;
        frame.size.height = 40;
        aView.frame = frame;
        
    }
    
    
    return aView;
    //}
    
    
}

-(void)touchMap{
    
    MapaViewController *mapa2;
     if ([delegate.alto intValue] < 568)
     {
     mapa2 = [[self storyboard] instantiateViewControllerWithIdentifier:@"mapa2"];
     
     }
     
     else
     {
    
    mapa2 = [[self storyboard] instantiateViewControllerWithIdentifier:@"mapa"];
    
     }
    
    //mapa= [[self storyboard] instantiateViewControllerWithIdentifier:@"mapa"];//[[MapaViewController alloc]init];
    mapa2.latitud=[_evento objectForKey:@"latitud"];
    mapa2.longitud=[_evento objectForKey:@"longitud"];
    mapa2.nombre=[_evento objectForKey:@"nombre"];
    
    [self presentViewController:mapa2 animated:YES completion:NULL];
}


-(IBAction)web:(id)sender
{
   
    ResenaViewController *resena1 ;
    resena1 = [[self storyboard] instantiateViewControllerWithIdentifier:@"resena"];
    resena1.texto=[_evento objectForKey:@"pagina"];
    [self presentViewController:resena1 animated:YES completion:NULL];
    
    
}

-(NSString *)convertMonth:(NSString *)numero{

    NSString *mes;
    if([numero isEqualToString:@"01"]){
    mes=@"Ene";
    }
    else if([numero isEqualToString:@"02"]){
        mes=@"Feb";
    }
    else if([numero isEqualToString:@"03"]){
        mes=@"Mar";
    }
    else if([numero isEqualToString:@"04"]){
        mes=@"Abr";
    }
    else if([numero isEqualToString:@"05"]){
        mes=@"May";
    }
    else if([numero isEqualToString:@"06"]){
        mes=@"Jun";
    }
    else if([numero isEqualToString:@"07"]){
        mes=@"Jul";
    }
    else if([numero isEqualToString:@"08"]){
        mes=@"Ago";
    }
    else if([numero isEqualToString:@"09"]){
        mes=@"Sep";
    }
    else if([numero isEqualToString:@"10"]){
        mes=@"Oct";
    }
    else if([numero isEqualToString:@"11"]){
        mes=@"Nov";
    }
    else if([numero isEqualToString:@"12"]){
        mes=@"Dic";
    }
    else{
        mes=numero;
    }
    return mes;

}



@end
