//
//  DetailViewController.h
//  PriceRangeSelector
//
//  Created by 邓念 on 15/2/13.
//  Copyright (c) 2015年 dengnian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

