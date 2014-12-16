//
//  FututroViewController.m
//  DejateCaer
//
//  Created by Carlos Castellanos on 13/11/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "FututroViewController.h"
#define SCROLL_UPDATE_DISTANCE          .80

#import "eventCell.h"
#import "SinEventoTableViewCell.h"
#import "DescripcionViewController.h"
#import "AppDelegate.h"
#import "Mipin.h"
#import "CustomCalloutAnnotation.h"
@interface FututroViewController ()
@property (strong, nonatomic)   UITapGestureRecognizer  *tapMapViewGesture;
@property (strong, nonatomic)   UITapGestureRecognizer  *tapTableViewGesture;
@end

@implementation FututroViewController

{
    
    //  NSArray *eventos;
    NSString *currentLatitud;
    NSString *currentLongitud;
    NSString *radio;
    NSString *radio_anterior;
    int moviendo;
    BOOL isEmpty;
    
    BOOL isArrow;  //diseño
    UIView *flechas; //diseño
    UITapGestureRecognizer* tapFlechas;//diseño
    UIButton *encuentrame;//diseño
    UIButton *herramientas;//diseño
    UITextField *buscar;//diseño
    UIView *contenedor_flotante;
    UIView *vista_auxiliar;
    UIButton *bucar_aqui;
    
    
    UITapGestureRecognizer* tapDetails;//diseño
    UITapGestureRecognizer* tapRecMap;
    UIView *opcciones;
    // UIView *vista_atras;
    
    AppDelegate *delegate;
    CLLocationCoordinate2D initialLocation;
    
    //Vista de Loading que se presenta mientras se hace la peticion
    UIView *loading;
    UIActivityIndicatorView *spinner;
    
    CLLocationCoordinate2D posicionAux;
}
@synthesize mapa,LocationManager,eventos;




- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad
{
    /********************************************/
    /* Código para  analytics                   */
    /********************************************/
    
    self.screenName = @"Lista de eventos y Mapa";
    
    //variable para contar las veces que se mueve el mapa
    moviendo=0;
    
    
    UIButton *buscame = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [buscame addTarget:self
                action:@selector(getCurrentLocation:)
      forControlEvents:UIControlEventTouchUpInside];
    
    // buscame.tintColor=[UIColor blackColor];
    [buscame setImage:[UIImage imageNamed:@"flecha.png"]  forState:UIControlStateNormal];
    buscame.frame = CGRectMake(mapa.frame.size.width-30, mapa.frame.size.height-30, 30, 30);
    buscame.backgroundColor=[UIColor clearColor];
    
    [mapa addSubview:buscame];
    
    UIButton *todos = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [todos addTarget:self
              action:@selector(filtrar:)
    forControlEvents:UIControlEventTouchUpInside];
    [todos setImage:[UIImage imageNamed:@"pin3.png"]  forState:UIControlStateNormal];
    todos.frame = CGRectMake(5, 5, 30, 30);
    todos.tag=0;
    todos.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:todos];
    UIView *separador=[[UIView alloc]initWithFrame:CGRectMake(39, 10, 1, 24)];
    separador.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador];
    
    UIButton *cine = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [cine addTarget:self
             action:@selector(filtrar:)
   forControlEvents:UIControlEventTouchUpInside];
    cine.tintColor=[UIColor blackColor];
    cine.tag=1;
    [cine setImage:[UIImage imageNamed:@"Cine.png"]  forState:UIControlStateNormal];
    cine.frame = CGRectMake(45, 5, 30, 30);
    cine.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:cine];
    UIView *separador2=[[UIView alloc]initWithFrame:CGRectMake(79, 10, 1, 24)];
    separador2.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador2];
    
    UIButton *Teatro = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Teatro addTarget:self
               action:@selector(filtrar:)
     forControlEvents:UIControlEventTouchUpInside];
    Teatro.tintColor=[UIColor blackColor];
    Teatro.tag=2;
    [Teatro setImage:[UIImage imageNamed:@"Teatro.png"]  forState:UIControlStateNormal];
    Teatro.frame = CGRectMake(85, 5, 30, 30);
    Teatro.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:Teatro];
    UIView *separador3=[[UIView alloc]initWithFrame:CGRectMake(119, 10, 1, 24)];
    separador3.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador3];
    
    
    UIButton *Infantiles = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Infantiles addTarget:self
                   action:@selector(filtrar:)
         forControlEvents:UIControlEventTouchUpInside];
    Infantiles.tintColor=[UIColor blackColor];
    Infantiles.tag=3;
    [Infantiles setImage:[UIImage imageNamed:@"Infantiles.png"]  forState:UIControlStateNormal];
    Infantiles.frame = CGRectMake(125, 5, 30, 30);
    Infantiles.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:Infantiles];
    UIView *separador4=[[UIView alloc]initWithFrame:CGRectMake(159, 10, 1, 24)];
    separador4.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador4];
    
    UIButton *Cultura = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [Cultura addTarget:self
                action:@selector(filtrar:)
      forControlEvents:UIControlEventTouchUpInside];
    Cultura.tag=4;
    Cultura.tintColor=[UIColor blackColor];
    [Cultura setImage:[UIImage imageNamed:@"Cultura.png"]  forState:UIControlStateNormal];
    Cultura.frame = CGRectMake(165, 5, 30, 30);
    Cultura.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:Cultura];
    UIView *separador5=[[UIView alloc]initWithFrame:CGRectMake(199, 10, 1, 24)];
    separador5.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador5];
    
    UIButton *musica = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [musica addTarget:self
               action:@selector(filtrar:)
     forControlEvents:UIControlEventTouchUpInside];
    musica.tag=5;
    musica.tintColor=[UIColor blackColor];
    [musica setImage:[UIImage imageNamed:@"Música.png"]  forState:UIControlStateNormal];
    musica.frame = CGRectMake(205, 5, 30, 30);
    musica.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:musica];
    UIView *separador6=[[UIView alloc]initWithFrame:CGRectMake(239, 10, 1, 24)];
    separador6.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador6];
    
    UIButton *aprendizaje = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [aprendizaje addTarget:self
                    action:@selector(filtrar:)
          forControlEvents:UIControlEventTouchUpInside];
    aprendizaje.tag=6;
    aprendizaje.tintColor=[UIColor blackColor];
    [aprendizaje setImage:[UIImage imageNamed:@"Aprendizaje.png"]  forState:UIControlStateNormal];
    aprendizaje.frame = CGRectMake(245, 5, 30, 30);
    aprendizaje.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:aprendizaje];
    UIView *separador7=[[UIView alloc]initWithFrame:CGRectMake(279, 10, 1, 24)];
    separador7.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador7];
    
    UIButton *tecnologia = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [tecnologia addTarget:self
                   action:@selector(filtrar:)
         forControlEvents:UIControlEventTouchUpInside];
    tecnologia.tag=7;
    tecnologia.tintColor=[UIColor blackColor];
    [tecnologia setImage:[UIImage imageNamed:@"Tecnología.png"]  forState:UIControlStateNormal];
    tecnologia.frame = CGRectMake(285, 5, 30, 30);
    tecnologia.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:tecnologia];
    UIView *separador8=[[UIView alloc]initWithFrame:CGRectMake(319, 10, 1, 24)];
    separador8.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador8];
    
    UIButton *expo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [expo addTarget:self
             action:@selector(filtrar:)
   forControlEvents:UIControlEventTouchUpInside];
    expo.tag=8;
    expo.tintColor=[UIColor blackColor];
    [expo setImage:[UIImage imageNamed:@"Exposiciones.png"]  forState:UIControlStateNormal];
    expo.frame = CGRectMake(325, 5, 30, 30);
    expo.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:expo];
    UIView *separador9=[[UIView alloc]initWithFrame:CGRectMake(359, 10, 1, 24)];
    separador9.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador9];
    
    UIButton *deportivo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [deportivo addTarget:self
                  action:@selector(filtrar:)
        forControlEvents:UIControlEventTouchUpInside];
    deportivo.tag=9;
    deportivo.tintColor=[UIColor blackColor];
    [deportivo setImage:[UIImage imageNamed:@"Deportivo.png"]  forState:UIControlStateNormal];
    deportivo.frame = CGRectMake(365, 5, 30, 30);
    deportivo.backgroundColor=[UIColor clearColor];
    [_scroll addSubview:deportivo];
    UIView *separador10=[[UIView alloc]initWithFrame:CGRectMake(399, 10, 1, 24)];
    separador10.backgroundColor=[UIColor colorWithRed:(160/255.0) green:(160/255.0) blue:(160/255.0) alpha:1];
    [_scroll addSubview:separador10];
    
    
    
    
    [_scroll setContentSize:CGSizeMake(400,44)];
    
    //Definde Fondo de la vista
    self.view.backgroundColor=[UIColor whiteColor];
    // self.view.backgroundColor=[UIColor colorWithRed:(243/255.0) green:(23/255.0) blue:(52/255.0) alpha:1];
    
    
    
    
    
    //declaramos un variable que nos servira como delegado
    delegate= (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
    
    
    //Copiamos el radio del delegado por default es  2000 metros
    radio=delegate.user_radio;//@"2000";
    
    
    [mapa setDelegate:self];
    //obtenemos la ubicacion del usuario y centramos el mapa ahi
    LocationManager = [[CLLocationManager alloc] init];
    
    LocationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    LocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [LocationManager startUpdatingLocation];
#ifdef __IPHONE_8_0
    if(IS_OS_8_OR_LATER) {
        // Use one or the other, not both. Depending on what you put in info.plist
        [LocationManager requestWhenInUseAuthorization];
        [LocationManager requestAlwaysAuthorization];
    }
#endif
    
    //[LocationManager requestWhenInUseAuthorization];
    //[LocationManager requestAlwaysAuthorization];
    
    
    
    
    initialLocation.latitude = LocationManager.location.coordinate.latitude-0.020;
    initialLocation.longitude = LocationManager.location.coordinate.longitude;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(initialLocation, 4000, 4000);
    [mapa setShowsUserLocation:YES];
    [mapa setRegion:region animated:YES];
    
    
    
    //llamamos metodo para crear la tabla
    [self crearTabla];
    
    //iniciamos el mapa
    [self setupMapView];
    
    
    
    [self crearLoadingView];
    
    //obtenemos los eventos
    posicionAux.latitude=LocationManager.location.coordinate.latitude;
    posicionAux.longitude=LocationManager.location.coordinate.longitude;
    [self obtenerEventos:LocationManager.location.coordinate.latitude Y:LocationManager.location.coordinate.longitude];
    
    //iniciamos con la lista de evnetos oculta
    
    
    [super viewDidLoad];
    
    
}

-(void)crearTabla{
    
    
    
    _tableView.rowHeight=90;
    [_tableView setBackgroundColor:[UIColor clearColor]];
    _tableView.tableHeaderView.backgroundColor=[UIColor grayColor];
    [self.tableView setSeparatorColor:[UIColor colorWithRed:(7/255.0) green:(104/255.0) blue:(239/255.0) alpha:1]];
    _tableView.dataSource   = self;
    _tableView.delegate     = self;
    
    
    
    
}

-(void)setupMapView{
    
    mapa.rotateEnabled = NO;
    [mapa setShowsUserLocation:YES];
    mapa.delegate = self;
    [self.view insertSubview:mapa
                belowSubview: _tableView];
    UITapGestureRecognizer* tapRec = [[UITapGestureRecognizer alloc]
                                      initWithTarget:self action:@selector(touchMap)];
    [mapa addGestureRecognizer:tapRec];
    [self crearBuscaAqui];
}




-(void)obtenerEventos :(float) latitud Y : (float) longitud {
    
    //obtenemos la posicion del usuario
    currentLatitud=[NSString stringWithFormat:@"%.8f", latitud];
    currentLongitud=[NSString stringWithFormat:@"%.8f", longitud];
   //http://eventario.mx/eventos.json?fecha=2014-10-08
    //http://eventario.mx/eventos.json?fecha=2014/12/08&lon=-103.346925807&lat=20.676203715886&dist=20
    NSString *urlString =@"http://eventario.mx/eventos.json";
    NSString *url=[NSString stringWithFormat:@"%@?fecha=%@&lon=%@&lat=%@&dist=20",urlString,_fecha,[NSString stringWithFormat:@"%.8f", longitud],[NSString stringWithFormat:@"%.8f", latitud]];
    // NSString *url=@"http://dev.codigo.labplc.mx/EventarioWeb/eventos.json";
    NSLog(@"%@",url);
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if ([data length] >0  )
        {
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableString * miCadena = [NSMutableString stringWithString: dato];
            NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
            
            
            // lugares= [jsonObject objectForKey:@"eventos"];//[consulta objectForKey:@"ubicaciones"];
            
            eventos=[NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
            _original=[NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
            
            
            
            
            
            
            if ([eventos count]==0) {
                _tableView.rowHeight=450;
                NSArray *vacio=[[NSArray alloc]initWithObjects:@"VACIO", nil];
                eventos=vacio;
                isEmpty=TRUE;
                UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos cerca de este lugar intenta ampliando el radio de búsqueda desde el menú opcciones" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                [alerta show];
                
                [self getMapa:latitud Y :longitud];
                [self.tableView reloadData];
                
                
            }
            else{
                for (int i=0; i<=[eventos count]-1; i++) {
                    NSString *d=[[eventos objectAtIndex:i] objectForKey:@"imagen"];
                    
                    [self performSelectorInBackground: @selector(buscar_imagen:) withObject: d];
                }
                _tableView.rowHeight=90;
                isEmpty=FALSE;
                //Mandamos a llamar la lista para llenarla y enseñarla
                [self getMapa:latitud Y :longitud];
                
                [self.tableView reloadData];
                
                
                
            }
        }
        else {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"Revisa tu conexión de internet y  vuelve a intentarlo. " delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alert show];
            _tableView.rowHeight=450;
            NSArray *vacio=[[NSArray alloc]initWithObjects:@"VACIO", nil];
            eventos=vacio;
            isEmpty=TRUE;
            
            [self getMapa:latitud Y :longitud];
            [self.tableView reloadData];
            
            loading.hidden=TRUE;
            
        }
    });
    
}

-(void)getLista {
    
    // Revisamos si los eventos son pocos (4) para redimencionar la tabla y no poder scrollear
    if ([eventos count] <5 && [eventos count] >0) {
        CGRect frame;
        frame.size.height=([eventos count]*90);
        frame.size.width=320;
        frame.origin.x=0;
        frame.origin.y=222;
        _tableView.frame=frame;
        _tableView.scrollEnabled=FALSE;
        [self.tableView reloadData];
        _tableView.hidden=FALSE;
        //[self.view addSubview:_tableView];
        
    }
    else if ([eventos count]>5){
        // [self.view addSubview:_tableView];
        [self.tableView reloadData];
        _tableView.hidden=FALSE;
        
    }
    else{
        //[self.tableView reloadData];
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No tenemos eventos cercanos a ti en este lugar,intenta de nuevo ampliando el radio de búsqueda en el menú de opcciones " delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
        _tableView.hidden=TRUE;
        
        
    }
    
    // [self getMapa];
}

-(void)getMapa :(float) latitud Y : (float) longitud
{
    //Quitamos todo los markers que pueda tener el mapa
    [mapa removeAnnotations:mapa.annotations];
    
    if (!isEmpty) {
        
        
        for(int i=0;i<([eventos count]);i++) {
            
            NSMutableDictionary *lugar=[[NSMutableDictionary alloc]init];
            lugar=[eventos objectAtIndex:i];
            
            CLLocationCoordinate2D SCL;
            SCL.latitude = [[lugar objectForKey:@"latitud"] doubleValue];
            SCL.longitude = [[lugar objectForKey:@"longitud"]doubleValue];
            
            
            CGFloat newLat = [[lugar objectForKey:@"latitud"] doubleValue];
            CGFloat newLon = [[lugar objectForKey:@"longitud"] doubleValue];
            
            CLLocationCoordinate2D newCoord = {newLat, newLon};
            
            Mipin *annotationPoint = [[Mipin alloc] initWithTitle:[lugar objectForKey:@"nombre"] subtitle:[lugar objectForKey:@"lugar"] andCoordinate:newCoord tipo:@"" evento:i lugar:[lugar objectForKey:@"lugar"] hora:[lugar objectForKey:@"hora_inicio"]];
            
            [mapa addAnnotation:annotationPoint];
        }}
    
    //Quitamos la vista de loading y paramos el spinner
    // [spinner stopAnimating];
    //[loading removeFromSuperview];
    loading.hidden=TRUE;
    CLLocationCoordinate2D SCL;
    SCL.latitude = latitud;
    SCL.longitude = longitud;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(SCL, 4000, 4000);
    [mapa setShowsUserLocation:YES];
    [mapa setRegion:region animated:YES];
    
    //obtememos la localizacion actual del usuario
    //[self getCurrentLocation:nil];
    
}


- (IBAction)getCurrentLocation:(id)sender {
    loading.hidden=FALSE;
    LocationManager = [[CLLocationManager alloc] init];
    LocationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    LocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [LocationManager startUpdatingLocation];
    CLLocationCoordinate2D SCL;
    
    SCL.latitude = LocationManager.location.coordinate.latitude;
    
    SCL.longitude = LocationManager.location.coordinate.longitude;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(SCL, 4000, 4000);
    [mapa setShowsUserLocation:YES];
    [mapa setRegion:region animated:YES];
    [self obtenerEventos:SCL.latitude Y:SCL.longitude];
    
    
}
#pragma mark - Table view Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (!isEmpty) {
        
        DescripcionViewController *detalles;//=[[DescripcionViewController alloc]init];
        if ([delegate.alto intValue] < 568)
        {
            detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion2"];
            
        }
        
        else
        {
            
            detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion"];
            
        }
        
        
        
        
        detalles.evento=[eventos objectAtIndex:indexPath.row];
        detalles.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        // [self.navigationController pushViewController:detalles animated:YES];
        
        
        [self presentViewController:detalles animated:YES completion:NULL];
        
    }
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventos count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isEmpty) {
        
        
        eventCell *cell=[[eventCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
        
        if(indexPath.row == 0){
            
            
            
        }
        
        
        if (cell == nil) {
        }
        
        
        cell.selectionStyle= UITableViewCellSelectionStyleNone;
        
        // [self buscar_imagen:[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"imagen"]];
        
        NSString *cat=[NSString stringWithFormat:@("%@.png"),[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"categoria"]];
        cell.imagen.image=[UIImage imageNamed:cat]; //[delegate.cacheImagenes objectForKey:[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"imagen"]];
        
        cell.nombre.text= [[eventos objectAtIndex:indexPath.row ]   objectForKey:@"nombre"];
        NSString *horas=[[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"hora_inicio"]
                         stringByReplacingOccurrencesOfString:@"2000-01-01T" withString:@""];
        horas=[horas  stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
        
        NSString *horasfin=[[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"hora_fin"]
                            stringByReplacingOccurrencesOfString:@"2000-01-01T" withString:@""];
        horasfin=[horasfin  stringByReplacingOccurrencesOfString:@":00Z" withString:@""];
        
        cell.hora.text=[NSString stringWithFormat:@("%@ - %@"),horas,horasfin];
        //cell.hora.text= [[eventos objectAtIndex:indexPath.row ]   objectForKey:@"hora_inicio"];
      //  float metros= [[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"distancia"] doubleValue];
        
        
       // cell.distancia.text= [NSString stringWithFormat:(@"%.2f Km."),metros];
        /*
         if (metros>=1) {
         //metros=(metros/1000);
         
         cell.distancia.text= [NSString stringWithFormat:(@"%@ Km."),[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"distancia"]];
         }
         else{
         NSLog(@"%@",[[eventos objectAtIndex:indexPath.row ] objectForKey:@"distancia"]);
         cell.distancia.text= [NSString stringWithFormat:(@"%@ m"),[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"distancia"]];
         }*/
        return cell;
    }
    
    else{
        SinEventoTableViewCell *cell=[[SinEventoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
        //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil) {
            //  NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"evento_cell" owner:self options:nil];
            //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
            // cell = [topLevelObjects objectAtIndex:0];
        }
        cell.nombre.text= @"No encontramos eventos cerca de este lugar intenta ampliando el radio de búsqueda en el menú de opcciones.";
        return cell;
        
    }
    
    // cell.textLabel.text = [[eventos objectAtIndex:indexPath.row ]   objectForKey:@"nombre"];
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    //first get total rows in that section by current indexPath.
    NSInteger totalRow = [tableView numberOfRowsInSection:indexPath.section];
    
    //this is the last row in section.
    if(indexPath.row == totalRow -1){
        // get total of cells's Height
        float cellsHeight = totalRow * cell.frame.size.height;
        // calculate tableView's Height with it's the header
        float tableHeight = (tableView.frame.size.height - tableView.tableHeaderView.frame.size.height);
        
        // Check if we need to create a foot to hide the backView (the map)
        if((cellsHeight - tableView.frame.origin.y)  < tableHeight){
            // Add a footer to hide the background
            int footerHeight = tableHeight - cellsHeight;
            tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, footerHeight)];
            
            //  [tableView.tableFooterView setBackgroundColor:[UIColor colorWithRed:(243/255.0) green:(23/255.0) blue:(52/255.0) alpha:1]];
            
            [tableView.tableFooterView setBackgroundColor:[UIColor whiteColor]];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)actualizar{
    radio=delegate.user_radio;
    
    [self getCurrentLocation:nil];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (buscar.text!=nil ) {
        if ([buscar.text isEqualToString:@" "]) {
            [self.view endEditing:YES];
            
        }
        else{
            
        }
    }
    
    else{
        [self.view endEditing:YES];
    }
    
    if (textField.text && textField.text.length > 0)
    {
        // NSLog(@"%@",buscar.text);
        // NSLog(@"%@",buscar.text);
        [self.view endEditing:YES];
        [self getPlaces];
    }
    else
    {
        UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"Introduce un lugar de búsqueda" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alerta show];
    }
    [self.view endEditing:YES];
    return YES;
}

-(void)getPlacesApple{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    NSString *direccion=[NSString stringWithFormat:@"%@,Mexico,distrito federal",buscar.text];
    [geocoder geocodeAddressString:direccion completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error)
        {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos el lugar que buscas" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            // NSLog(@"Geocode failed with error: %@", error);
            //[self displayError:error];
            
            return;
            
        }
        
        CLPlacemark *placemark=[placemarks objectAtIndex:0];
        //  NSLog(@"Received placemarks: %@", placemarks);
        // NSLog(@"%f,%f",placemark.location.coordinate.latitude,placemark.location.coordinate.longitude);
        loading.hidden=FALSE;
        [self obtenerEventos: placemark.location.coordinate.latitude Y:placemark.location.coordinate.longitude];
        //[self displayPlacemarks:placemarks];
    }];
    
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
//Metodo para ir a la siguiente vista desde el boton del CallOut en el marcador
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    
    
    DescripcionViewController *detalles;//=[[DescripcionViewController alloc]init];
    if ([delegate.alto intValue] < 568)
    {
        detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion2"];
        
    }
    
    else
    {
        
        detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion"];
        
    }
    
    // detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion"];
    detalles.evento=[eventos objectAtIndex:view.tag];
    detalles.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:detalles animated:YES completion:NULL];
}


-(void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    for (UIView *subview in view.subviews ){
        [subview removeFromSuperview];
    }
}

//Metodo para Cambiar el CallOutView del Marker en el mapa
- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    
    /*if(![view.annotation isKindOfClass:[MKUserLocation class]]) {
     CustomCalloutAnnotation *calloutView = (CustomCalloutAnnotation *)[[[NSBundle mainBundle] loadNibNamed:@"CustomCallOutView" owner:self options:nil] objectAtIndex:0];
     CGRect calloutViewFrame = calloutView.frame;
     calloutViewFrame.origin = CGPointMake(-calloutViewFrame.size.width/2 + 85, -calloutViewFrame.size.height);
     calloutView.frame = calloutViewFrame;
     calloutView.nombre.text=@"fsdfr";
     [calloutView.nombre setText:[(Mipin*)[view annotation] title]];
     [calloutView.lugar setText:[(Mipin*)[view annotation] lugar]];
     [calloutView.hora setText:[(Mipin*)[view annotation] hora]];
     UIView *d=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 00)];
     d.backgroundColor=[UIColor greenColor];
     [calloutView addSubview:d];
     [calloutView addGestureRecognizer:tapDetails];
     [view addSubview:calloutView];
     
     
     }*/
}

-(void)touchMap{
    [self.view endEditing:YES];
}


-(IBAction)getCenter:(id)sender{
    [bucar_aqui removeFromSuperview];
    loading.hidden=FALSE;
    
    [self.view endEditing:YES];
    CLLocationCoordinate2D centre = [mapa centerCoordinate];
    // NSLog(@"%f, %f", centre.latitude, centre.longitude);
    //[mapa removeAnnotation:annotationPointUbication];
    radio=delegate.user_radio;
    // annotationPointUbication = [[Mipin alloc] initWithTitle:@"Centro" subtitle:@"" andCoordinate:centre tipo:@"ubicacion" evento:0];
    
    // [mapa addAnnotation:annotationPointUbication];
    
    //obtenemos la posicion del usuario
    currentLatitud=[NSString stringWithFormat:@"%.8f", centre.latitude];
    currentLongitud=[NSString stringWithFormat:@"%.8f", centre.longitude];
    // guardamos el radio anteriot
    posicionAux.latitude=centre.latitude;
    posicionAux.longitude=centre.longitude;
    [self obtenerEventos:centre.latitude Y:centre.longitude];
    
}



#pragma mark - Creando Vistas Auxiliates
-(void)crearLoadingView{
    //Creamos vista que contiene el spinner y lo enseñamos al usuario
    loading=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-25, self.view.frame.size.height/2 -50, 50, 50)];
    loading.backgroundColor=[UIColor colorWithRed:(7/255.0) green:(104/255.0) blue:(239/255.0) alpha:1];   // loading.alpha=0.8;
    loading.layer.cornerRadius = 5;
    loading.layer.masksToBounds = YES;
    
    spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner setCenter:CGPointMake(loading.frame.size.width/2.0, loading.frame.size.height/2.0)];
    [spinner startAnimating];
    [loading addSubview:spinner];
    [self.view addSubview:loading];
    
    
}

-(void)crearBuscaAqui{
    bucar_aqui = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [bucar_aqui addTarget:self
                   action:@selector(getCenter:)
         forControlEvents:UIControlEventTouchUpInside];
    [bucar_aqui setTitle:@"Buscar en esta zona" forState:UIControlStateNormal];
    //UIImage *buttonImage=[UIImage imageNamed:@"buscaaqui.png"];
    //    [bucar_aqui setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    bucar_aqui.frame = CGRectMake(40 , 5, 240, 30.0);
    bucar_aqui.tintColor=[UIColor whiteColor];
    bucar_aqui.backgroundColor=[UIColor colorWithRed:(7/255.0) green:(104/255.0) blue:(239/255.0) alpha:1];
}


#pragma mark - Metodos Auxiliares

-(int)test{
    
    return 0;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    //NSLog(@"scrolleando tabla");
    //  [self touchTabla];
}


-(void) getPlaces{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *direccion=buscar.text;//@"juan%20escutia%2094,la%20Condesa";
        
        
        NSData *stringData = [direccion dataUsingEncoding: NSASCIIStringEncoding allowLossyConversion: YES];
        
        direccion = [[NSString alloc] initWithData: stringData encoding: NSASCIIStringEncoding];      direccion = [direccion stringByReplacingOccurrencesOfString:@" "
                                                                                                                                                       withString:@"%20"];
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/textsearch/json?key=AIzaSyAy1XLjh6iRYgoPmtQD654iTXT_u9GdNVE&sensor=true&query=%@,distritofederal",direccion];
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        
        if (data!=nil) {
            
            
            NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSMutableString * miCadena = [NSMutableString stringWithString: dato];
            
            NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
            
            NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
            NSArray *aux=[jsonObject objectForKey:@"results"];
            if ([aux count]==0) {
                UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos el lugar que buscas, intenta con otra direccón" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
                [alerta show];
            }
            else{
                NSDictionary *primero=[[jsonObject objectForKey:@"results"]objectAtIndex:0];
                NSDictionary *coordenadas=[[primero objectForKey:@"geometry"] objectForKey:@"location"];
                
                [self obtenerEventos: [[coordenadas objectForKey:@"lat"] floatValue] Y:[[coordenadas objectForKey:@"lng"] floatValue]];}
        }
        else{
            
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos el lugar que buscas, intenta con otra direccón" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
        }
        
    });
    
}
-(IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint translatedPoint = [recognizer translationInView:self.view];
        NSLog(@"magnitude: %f", translatedPoint.y);
        if (translatedPoint.y<0) {
            NSLog(@"arriba");
            isArrow=FALSE;
            // [self touchTabla];
            
        }
        
    }
}


-(void)buscar_imagen:(NSString *) url
{
    
    
    NSObject *o = [delegate.cacheImagenes objectForKey:url];
    if( o == nil ){
        @try{
            [delegate.cacheImagenes setObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString: url]]]
                                       forKey:url];
        }
        @catch (NSException *exception) {
            
        }
    }
    
    
}


// moviendo el mapa
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    moviendo++;
    NSLog(@"regionDidChangeAnimated");
    MKCoordinateRegion mapRegion;
    // set the center of the map region to the now updated map view center
    mapRegion.center = mapView.centerCoordinate;
    
    mapRegion.span.latitudeDelta = 0.3; // you likely don't need these... just kinda hacked this out
    mapRegion.span.longitudeDelta = 0.3;
    
    // get the lat & lng of the map region
    double lat = mapRegion.center.latitude;
    double lng = mapRegion.center.longitude;
    
    // note: I have a variable I have saved called lastLocationCoordinate. It is of type
    // CLLocationCoordinate2D and I initially set it in the didUpdateUserLocation
    // delegate method. I also update it again when this function is called
    // so I always have the last mapRegion center point to compare the present one with
    CLLocation *before = [[CLLocation alloc] initWithLatitude:initialLocation.latitude longitude:initialLocation.longitude];
    CLLocation *now = [[CLLocation alloc] initWithLatitude:lat longitude:lng];
    
    CLLocationDistance distance = ([before distanceFromLocation:now]) * 0.000621371192;
    
    
    NSLog(@"Scrolled distance: %@", [NSString stringWithFormat:@"%.02f", distance]);
    
    if( distance > SCROLL_UPDATE_DISTANCE )
    { NSLog(@"se movio");
        if (moviendo>3) {
            
            
            [mapa addSubview:bucar_aqui];
        }
    }
    
    // resave the last location center for the next map move event
    initialLocation.latitude = mapRegion.center.latitude;
    initialLocation.longitude = mapRegion.center.longitude;
    
}
-(void)viewDidAppear:(BOOL)animated{
    
    
}

-(IBAction)filtrar:(id)sender{
    UIButton *a=(UIButton *)sender;
    NSLog(@"tag %i",(int)a.tag);
    
    if(a.tag==0){
        
        eventos=_original;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos cercanos a ti, intenta ampliando el radio de búsqueda" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
    }
    else if (a.tag==1)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Cine"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    
    else if (a.tag==2)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Teatro"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
    }
    
    else if (a.tag==3)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Infantiles"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
    }
    
    else if (a.tag==4)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Cultura"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    else if (a.tag==5)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Música"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    else if (a.tag==6)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Aprendizaje"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    else if (a.tag==7)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Tecnología"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    else if (a.tag==8)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Exposiciones"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    else if (a.tag==9)
    {
        
        eventos=_original;
        
        NSMutableArray *filtrados=[[NSMutableArray alloc]init];
        for (int i=0; i<[eventos count]; i++) {
            // buscamos en todo el array de eventos la categoria para ir filtrantodolos
            
            if ([ [[eventos objectAtIndex:i]   objectForKey:@"categoria"] isEqualToString:@"Deportivo"] ) {
                
                [filtrados addObject:[eventos objectAtIndex:i]];
            }
            
        }
        eventos=nil;
        eventos=filtrados;
        if ([eventos count]==0) {
            UIAlertView *alerta=[[UIAlertView alloc]initWithTitle:@"Mensaje" message:@"No encontramos eventos de esta categoría cerca de ti , intenta con otra categoría" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
            [alerta show];
            @autoreleasepool {
                UIButton *a=[UIButton alloc];
                a.tag=0;
                [self filtrar:a];
            }

        }
        else{
            [self.tableView reloadData];
            //hay que actualizae el mapa tambien falta pasar lo parametros de donde hará zoom el usuario
            [self getMapa:posicionAux.latitude Y :posicionAux.longitude];
        }
        
    }
    
    
}

-(IBAction)regresar:(id)sender
{
    // [self dismissModalViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:NO completion:nil];
}


@end
