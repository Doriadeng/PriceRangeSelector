//
//  MasterViewController.m
//  PriceRangeSelector
//
//  Created by 邓念 on 15/2/13.
//  Copyright (c) 2015年 dengnian. All rights reserved.
//

#import "MasterViewController.h"

@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"title";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.view.userInteractionEnabled = YES;
    
    //test
    NSArray *arrPrice = @[@"0",@"400",@"800",@"1200",@"2000"];
    self.priceSlider = [[PriceRangeSelector alloc] initWithFrame:CGRectMake(15, 140, kScreenWidth-30, 60) arr:arrPrice];
    _priceSlider.delegate = self;
    
    NSString *strFirst = [arrPrice firstObject];
    NSString *strLast = [arrPrice lastObject];
    [_priceSlider setLeftValue:strFirst rightValue:strLast];
    [self.view addSubview:_priceSlider];
    
    
    self.lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    _lblPrice.backgroundColor = [UIColor lightTextColor];
    
    _lblPrice.center = CGPointMake(kScreenWidth/2, 300);
    [self.view addSubview:_lblPrice];
    _lblPrice.text = [NSString stringWithFormat:@"%@-%@",strFirst,strLast];
    _lblPrice.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark PriceRangeDelegate
-(void)selectedPriceRange
{
    
    self.lblPrice.text = [NSString stringWithFormat:@"%@-%@",[_priceSlider getLeftValue],[_priceSlider getRightValue]];
}

@end
