//
//  HBPriceRangeSelector.h
//  hbgj
//
//  Created by dengnian on 13-9-12.
//
//

#import <UIKit/UIKit.h>

typedef  enum
{
    TrackingNone,
    TrackingLeftThumb,
    TrackingRightThumb,
    
}TrackingThumb;

@protocol PriceRangeDelegate

-(void)selectedPriceRange;

@end

@interface PriceRangeSelector : UIControl

@property (nonatomic, retain) NSMutableArray *arrValue;
@property (nonatomic, assign) int iLeftValue;
@property (nonatomic, assign) int iRightValue;
@property (nonatomic, retain) UIImageView *imgviewLeft;
@property (nonatomic, retain) UIImageView *imgviewRight;
@property (nonatomic, retain) UIImageView *imgviewConnect;
@property (nonatomic, retain) UIImageView *imgviewBackground;

@property (nonatomic, assign) CGPoint startLocation;
@property (nonatomic, assign) TrackingThumb trackingThumb;
@property (nonatomic, assign) int startTrackingValue;
@property (nonatomic, assign) float fInterval;
@property (nonatomic, assign) CGPoint leftLocation;
@property (nonatomic, assign) CGPoint rightLocation;

@property (nonatomic, assign) id<PriceRangeDelegate> delegate;

- (id)initWithFrame:(CGRect)frame arr:(NSArray *)arr;
- (void)setLeftValue:(NSString *)strleft rightValue:(NSString *)strright;
- (NSString *)getLeftValue;
- (NSString *)getRightValue;

@end

@interface LLSelectBtn : UIButton
@property (nonatomic, assign) BOOL bSelect;
@property (nonatomic, retain) NSMutableDictionary *dicContent;

@end




