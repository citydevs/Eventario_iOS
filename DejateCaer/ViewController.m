//
//  ViewController.m
//  DejateCaer
//
//  Created by Carlos Castellanos on 12/03/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "ViewController.h"
#import "eventCell.h"
#import "DescripcionViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
 NSArray *eventos;
 NSString *currentLatitud;
 NSString *currentLongitud;
    NSString *radio;
}
@synthesize mapa,LocationManager;
- (void)viewDidLoad
{

    radio=@"2000";
    LocationManager = [[CLLocationManager alloc] init];
    LocationManager.distanceFilter = kCLDistanceFilterNone; // whenever we move
    LocationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    [LocationManager startUpdatingLocation];
    
  
    self.view.layer.shadowOpacity = 0.75f;
    self.view.layer.shadowRadius = 10.0f;
    self.view.layer.shadowColor = [UIColor blackColor].CGColor;
    
        [mapa setDelegate:self];
    [mapa setShowsUserLocation:YES];

    //eventos = [NSArray arrayWithObjects:@"Egg Benedict", @"Mushroom Risotto", @"Full Breakfast", @"Hamburger", @"Ham and Egg Sandwich", @"Creme Brelee", @"White Chocolate Donut", @"Starbucks Coffee", @"Vegetable Curry", @"Instant Noodle with Egg", @"Noodle with BBQ Pork", @"Japanese Noodle with Pork", @"Green Tea", @"Thai Shrimp Cake", @"Angry Birds Cake", @"Ham and Cheese Panini", nil];

    [self getEventos];
   
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void)getEventos{
    currentLatitud=[NSString stringWithFormat:@"%.8f", LocationManager.location.coordinate.latitude];
    currentLongitud=[NSString stringWithFormat:@"%.8f", LocationManager.location.coordinate.longitude];
    NSLog(@"%@" ,currentLongitud);
    NSLog(@"%@",currentLatitud );
    
   // NSString *urlString =@"http://codigo.labplc.mx/~rockarloz/dejatecaer/prueba.php";
   NSString *urlString =@"http://codigo.labplc.mx/~rockarloz/dejatecaer/dejatecaer.php";
   NSString *url=[NSString stringWithFormat:@"%@?longitud=%@&latitud=%@&radio=%@",urlString,currentLongitud,currentLatitud,radio];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSOperationQueue *queue =[[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error)
     
     {
         if ([data length] >0  && error == nil)
         {
             NSArray *lugares;
             NSString *dato=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSMutableString * miCadena = [NSMutableString stringWithString: dato];
             NSData *data1 = [miCadena dataUsingEncoding:NSUTF8StringEncoding];
             
             NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:data1 options:NSJSONReadingAllowFragments error:nil];
             
             NSMutableDictionary *consulta=[[NSMutableDictionary alloc]init];
             consulta = [jsonObject objectForKey:@"eventos"];
             lugares= [jsonObject objectForKey:@"eventos"];//[consulta objectForKey:@"ubicaciones"];
             eventos=lugares;
             
             for(int i=0;i<[lugares count];i++) {
                 NSLog(@"%i",i);
                 NSMutableDictionary *lugar=[[NSMutableDictionary alloc]init];
                 lugar=[lugares objectAtIndex:i];
                 
                  CLLocationCoordinate2D SCL;
                  SCL.latitude = [[lugar objectForKey:@"latitud"] doubleValue];
                  SCL.longitude = [[lugar objectForKey:@"longitud"]doubleValue];
                  MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
                  annotationPoint.coordinate = SCL;
                  annotationPoint.title = [lugar objectForKey:@"nombre"];
                  annotationPoint.subtitle = [lugar objectForKey:@"direccion"];
                  [mapa addAnnotation:annotationPoint];
                  
                 [self getCurrentLocation:nil];
                 
                 
                 
             }
             _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 222, 320, 346)];
             _tableView.dataSource=self;
             _tableView.delegate=self;
             _tableView.rowHeight=75;
             _tableView.backgroundColor=[UIColor blueColor];
             [self.view addSubview:_tableView];
             
            
             
             
         }
         else{
          //   respuesta = nil;             NSLog(@"Contenido vacio");
             
         }
         
          [self.tableView reloadData];
         
         
         //Termina el método asíncrono
     }];

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DescripcionViewController *detalles;//=[[DescripcionViewController alloc]init];
  
    detalles = [[self storyboard] instantiateViewControllerWithIdentifier:@"descripcion"];
      detalles.evento=[eventos objectAtIndex:indexPath.row];
detalles.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
//[self presentViewController:detalles animated:YES completion:NULL];
 [self.navigationController pushViewController:detalles animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [eventos count];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *simpleTableIdentifier = @"SimpleTableItem";
   // eventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell"];
    eventCell *cell=[[eventCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"customCell"];
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
      //  NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"evento_cell" owner:self options:nil];
      //  cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
       // cell = [topLevelObjects objectAtIndex:0];
    }
    cell.nombre.text= [[eventos objectAtIndex:indexPath.row ]   objectForKey:@"nombre"];
    cell.hora.text= [[eventos objectAtIndex:indexPath.row ]   objectForKey:@"hora"];
    int metros= [[[eventos objectAtIndex:indexPath.row ]   objectForKey:@"distancia"] integerValue];
    if (metros>=1000) {
        metros=(metros/1000);
        NSLog(@"%i",metros);
        cell.distancia.text= [NSString stringWithFormat:(@"%i Km"),metros];
    }
    else{
    cell.distancia.text= [NSString stringWithFormat:(@"%i m"),metros];
    }
    
   // cell.textLabel.text = [[eventos objectAtIndex:indexPath.row ]   objectForKey:@"nombre"];
    return cell;
}


- (IBAction)getCurrentLocation:(id)sender {
    CLLocationCoordinate2D SCL;
    NSString *lat=[NSString stringWithFormat:@"%.8f", LocationManager.location.coordinate.latitude];
    ;
    NSString *lot=[NSString stringWithFormat:@"%.8f", LocationManager.location.coordinate.longitude];
    ;
    SCL.latitude = [lat doubleValue];
    SCL.longitude = [lot doubleValue];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(SCL, 2000, 2000);
    
    [mapa setRegion:region animated:YES];
}



@end