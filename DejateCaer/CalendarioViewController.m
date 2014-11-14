//
//  CalendarioViewController.m
//  DejateCaer
//
//  Created by Carlos Castellanos on 09/11/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "CalendarioViewController.h"
#import "FututroViewController.h"

@interface CalendarioViewController ()

@end

@implementation CalendarioViewController

- (void)viewDidLoad {
    
    
    UIView *aux =[[UIView alloc]init];// = [nibContents lastObject];
    aux.frame=CGRectMake(0, 130, 320, 325);
    aux.backgroundColor=[UIColor clearColor];
    aux.alpha=0.98;
    aux.layer.cornerRadius = 5;
    aux.layer.masksToBounds = YES;
    
    VRGCalendarView *calendar = [[VRGCalendarView alloc] init];
    calendar.delegate=self;
    [aux addSubview:calendar];
    
    
    
    
    
    UILabel *instruccions=[[UILabel alloc]initWithFrame:CGRectMake(50, 65, 220, 80)];
    instruccions.text=@"Selecciona un día en el calendario para poder ver los eventos que ocurrirán en esa fecha";
    instruccions.font=[UIFont systemFontOfSize:12];
    instruccions.numberOfLines=5;
    instruccions.textColor=[UIColor blackColor];
    instruccions.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:instruccions];
     [self.view addSubview:aux];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)calendarView:(VRGCalendarView *)calendarView switchedToMonth:(int)month targetHeight:(float)targetHeight animated:(BOOL)animated {
    if (month==[[NSDate date] month]  ) {
        NSArray *dates = [NSArray arrayWithObjects:[NSNumber numberWithInt:1],[NSNumber numberWithInt:5], nil];
        [calendarView markDates:dates];
    }
}

-(void)calendarView:(VRGCalendarView *)calendarView dateSelected:(NSDate *)date {
    
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;
    NSLog(@"%@", [NSString stringWithFormat:@"%@",
                  [df stringFromDate:date]]);
    NSString *fecha =[NSString stringWithFormat:@"%@",
                [df stringFromDate:date]];
    NSArray *aux = [fecha componentsSeparatedByString:@"/"];
    fecha=[NSString stringWithFormat:@"%@/%@/%@",[aux objectAtIndex:2],[aux objectAtIndex:1],[aux objectAtIndex:0]];
    //[self futuro:nil];
    FututroViewController *futuro;
    futuro= [[self storyboard] instantiateViewControllerWithIdentifier:@"futuro"];
    futuro.fecha=fecha;
    futuro.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    // [self.navigationController pushViewController:detalles animated:YES];
    
    
    [self presentViewController:futuro animated:YES completion:NULL];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
