//
//  SinEventoTableViewCell.m
//  DejateCaer
//  @rockarloz
//  rockarlos@me.com
//  Created by Carlos Castellanos on 02/04/14.
//  Copyright (c) 2014 Carlos Castellanos. All rights reserved.
//

#import "SinEventoTableViewCell.h"

@implementation SinEventoTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //self.backgroundColor=[UIColor colorWithRed:(243/255.0) green:(23/255.0) blue:(52/255.0) alpha:1];
        // Initialization code
        self.backgroundColor=[UIColor whiteColor];
        UIView *selectedView = [[UIView alloc]init];
        selectedView.backgroundColor = [UIColor clearColor];
        _nombre=[[UILabel alloc]initWithFrame:CGRectMake(10, 5, 280, 70)];
        _nombre.textColor=[UIColor whiteColor];
        _nombre.textAlignment=NSTextAlignmentCenter;
       // [_nombre setFont:[UIFont systemFontOfSize:16]];
        
        [_nombre setFont:[UIFont fontWithName:@"NIISansLight" size:15]];
        
        _nombre.numberOfLines = 4;
        _nombre.textColor=[UIColor colorWithRed:(7/255.0) green:(104/255.0) blue:(239/255.0) alpha:1];

        [self   addSubview:_nombre];
        self.selectedBackgroundView=selectedView;
        
      //   self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
