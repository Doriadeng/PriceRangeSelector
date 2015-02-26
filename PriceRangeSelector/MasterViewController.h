//
//  MasterViewController.h
//  PriceRangeSelector
//
//  Created by 邓念 on 15/2/13.
//  Copyright (c) 2015年 dengnian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PriceRangeSelector.h"
#define kScreenWidth      [[UIScreen mainScreen] bounds].size.width

@interface MasterViewController : UIViewController<PriceRangeDelegate>

@property (nonatomic, retain) PriceRangeSelector *priceSlider;
@property (nonatomic, retain) UILabel *lblPrice;

@end

