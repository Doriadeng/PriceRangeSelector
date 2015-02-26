//
//  HBPriceRangeSelector.m
//  hbgj
//
//  Created by dengnian on 13-9-12.
//
//

#import "PriceRangeSelector.h"

#define iLeftSpace   13
#define iRightSpace  13
#define iMaxValue    99999
#define kFilterDefault_Price  @"不限"
#define kFilterSelected_Key  @"select"

@implementation PriceRangeSelector

@synthesize iLeftValue,iRightValue,trackingThumb,startTrackingValue,fInterval,leftLocation,rightLocation;
@synthesize imgviewLeft=_imgviewLeft, imgviewRight=_imgviewRight, imgviewConnect=_imgviewConnect, imgviewBackground=_imgviewBackground;
@synthesize startLocation=_startLocation;
@synthesize arrValue;

- (id)initWithFrame:(CGRect)frame arr:(NSMutableArray *)arr
{
    if (self = [super initWithFrame:frame]) {
        
        self.arrValue = [NSMutableArray arrayWithArray:arr];
        
        self.imgviewBackground = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 33)];
        _imgviewBackground.image = [[UIImage imageNamed:@"sliderbg.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [self addSubview:_imgviewBackground];        
        
        self.imgviewConnect = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width-70, 33)];
        _imgviewConnect.image = [[UIImage imageNamed:@"sliderconnect.png"] stretchableImageWithLeftCapWidth:5 topCapHeight:5];
        [self addSubview:_imgviewConnect];
        
        self.imgviewLeft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        _imgviewLeft.image = [UIImage imageNamed:@"priceslider.png"];
        [self addSubview:_imgviewLeft];
        
        self.imgviewRight = [[UIImageView alloc] initWithFrame:CGRectMake(200, 0, 50, 50)];
        _imgviewRight.image = [UIImage imageNamed:@"priceslider.png"];
        [self addSubview:_imgviewRight];
        
        if (arrValue.count>1) {
            self.fInterval = (CGRectGetWidth(self.imgviewBackground.frame)-iLeftSpace-iRightSpace)/(arrValue.count-1);
        }
        
        for (int i=0; i<arrValue.count; i++) {
            
            UIView *lineScale = [[UIView alloc] initWithFrame:CGRectMake(iLeftSpace+fInterval*i, 35, 1, 3)];
            lineScale.backgroundColor = [UIColor colorWithRed:178/255 green:178/255 blue:178/255 alpha:1];
            
            NSString *strItem = [arrValue objectAtIndex:i];
            
            [self addSubview:lineScale];
            
            UILabel *lblPrice = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
            lblPrice.font = [UIFont systemFontOfSize:13];
            lblPrice.textAlignment = NSTextAlignmentCenter;
            lblPrice.text = [NSString stringWithFormat:@"￥%@",strItem];
            lblPrice.backgroundColor = [UIColor clearColor];
            
            lblPrice.center = CGPointMake(lineScale.center.x, lineScale.center.y+10);
            [self addSubview:lblPrice];
            
            if ([strItem isEqualToString:kFilterDefault_Price]) {
                lblPrice.text = kFilterDefault_Price;
                [arrValue replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",iMaxValue]];
            }
            
        }
        
    }
    return self;
}

- (NSString *)getLeftValue
{
    return [NSString stringWithFormat:@"%d",self.iLeftValue];
}

- (NSString *)getRightValue
{
    NSString *strRight = [NSString stringWithFormat:@"%d",self.iRightValue];
    if (self.iRightValue>=iMaxValue) {
        strRight = kFilterDefault_Price;
    }
    return strRight;
}

- (void)setLeftValue:(NSString *)strleft rightValue:(NSString *)strright
{
    int ileft = [strleft intValue];
    int iright = [strright intValue];
    
    if ([strright rangeOfString:kFilterDefault_Price].location != NSNotFound) {
        iright = iMaxValue;
    }
    
    [self setiLeftValue: ileft];
    [self setiRightValue: iright];
    
}

- (void)setiLeftValue:(int)value {
        
    if (value >= self.iRightValue)
    {
        NSUInteger index = [arrValue indexOfObject:[NSString stringWithFormat:@"%d",self.iRightValue]];
        if (index>0) {
            value = [[arrValue objectAtIndex:index-1] intValue];
            
        }
    }
    
    int iMinValue = 0;
    if (arrValue.count>0) {
        iMinValue = [[arrValue firstObject] intValue];
    }
    if (value < iMinValue) {
        value = iMinValue;
    }
    
    self.iLeftValue = value;
    leftLocation.x = [self locationForValue:self.iLeftValue];
    [self setNeedsLayout];
    
}

- (void)setiRightValue:(int)value {
        
    if (value <= self.iLeftValue)
    {
        NSUInteger index = [arrValue indexOfObject:[NSString stringWithFormat:@"%d",self.iLeftValue]];
        if (arrValue.count>index) {
            value = [[arrValue objectAtIndex:index+1] intValue];
            
        }
        
    }
    
    if (value > iMaxValue) {
        value = iMaxValue;
    }
    self.iRightValue = value;
    rightLocation.x = [self locationForValue:self.iRightValue];
    
    [self setNeedsLayout];
    
}

- (int)valueForLocation:(CGPoint)location {
    
    int newValue = 0;
    int index = (location.x - iLeftSpace + fInterval/2)/fInterval;
    if (arrValue.count>index) {
        newValue = [[arrValue objectAtIndex:index] intValue];
    }
    
    return newValue;
}

- (float)locationForValue:(int)value {
    
    int isaclex = 0;
    
    NSString *strValue = [NSString stringWithFormat:@"%d",value];
    NSUInteger index = [arrValue indexOfObject:strValue];
    
    isaclex = iLeftSpace + fInterval*index;
    
    return isaclex;
}

#pragma mark -

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    _startLocation = [touch locationInView:self];
    
    float distanceFromLeft = fabsf(CGRectGetMidX(self.imgviewLeft.frame)-_startLocation.x);
    float distanceFromRight = fabsf(CGRectGetMidX(self.imgviewRight.frame)-_startLocation.x);
    float distanceFromMiddle = fabsf(CGRectGetMidX(self.imgviewConnect.frame)-_startLocation.x);
    
    CGRect rectRangeLeft = CGRectMake(self.imgviewLeft.frame.origin.x-20, self.imgviewLeft.frame.origin.y-20, self.imgviewLeft.frame.size.width+40, self.imgviewLeft.frame.size.height+40);
    CGRect rectRangeRight = CGRectMake(self.imgviewRight.frame.origin.x-20, self.imgviewRight.frame.origin.y-20, self.imgviewRight.frame.size.width+40, self.imgviewRight.frame.size.height+40);

    if (distanceFromLeft < distanceFromMiddle) {
        if (CGRectContainsPoint(rectRangeLeft, _startLocation)) {
            self.trackingThumb = TrackingLeftThumb;
            self.startTrackingValue = self.iLeftValue;
            return YES;
        }
    } else if (distanceFromRight < distanceFromMiddle) {
        if (CGRectContainsPoint(rectRangeRight, _startLocation)) {
            self.trackingThumb = TrackingRightThumb;
            self.startTrackingValue = self.iRightValue;
            return YES;
        }
    }
    
    self.trackingThumb = TrackingNone;
    return  [super beginTrackingWithTouch:touch withEvent:event];
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {

    CGPoint location = [touch locationInView:self];
    
    if (self.trackingThumb == TrackingLeftThumb) {
        if (location.x<iLeftSpace) {
            location.x = iLeftSpace;
        }
        if (location.x>rightLocation.x) {
            location.x = rightLocation.x;
        }
        leftLocation = location;
        
        [self setNeedsLayout];
        
        [self sendActionsForControlEvents: UIControlEventValueChanged];
        
        return YES;
    }
    
    if (self.trackingThumb == TrackingRightThumb) {
        if (location.x>CGRectGetWidth(self.imgviewBackground.frame)) {
            location.x = CGRectGetWidth(self.imgviewBackground.frame)-iLeftSpace;
        }
        if (location.x<leftLocation.x) {
            location.x = leftLocation.x;
        }
        rightLocation = location;
        [self setNeedsLayout];
        
        [self sendActionsForControlEvents: UIControlEventValueChanged];
        return YES;
    }
    
    self.trackingThumb = TrackingNone;

    return [super continueTrackingWithTouch:touch withEvent:event];

}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {

    [super endTrackingWithTouch:touch withEvent:event];
    
    CGPoint location = [touch locationInView:self];
    
    if (self.trackingThumb == TrackingLeftThumb) {
        [self setiLeftValue: [self valueForLocation:location]];
        
        
        [self sendActionsForControlEvents: UIControlEventValueChanged];
        
    }
    
    else if (self.trackingThumb == TrackingRightThumb) {
        [self setiRightValue: [self valueForLocation:location]];
        
        [self sendActionsForControlEvents: UIControlEventValueChanged];
    }

    
    self.trackingThumb = TrackingNone;
    
    if (_delegate && [(NSObject *)_delegate respondsToSelector:@selector(selectedPriceRange)]) {
        [_delegate selectedPriceRange];
    }

}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    self.trackingThumb = TrackingNone;
    [super cancelTrackingWithEvent:event];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect f = self.imgviewLeft.frame;
    f.size = self.imgviewLeft.image.size;
    f.origin.x = leftLocation.x-iLeftSpace;
    self.imgviewLeft.frame = f;
    
    f = self.imgviewRight.frame;
    f.size = self.imgviewRight.image.size;
    f.origin.x = rightLocation.x-iLeftSpace;

    self.imgviewRight.frame = f;
    
    f = self.imgviewConnect.frame;
    f.size = self.imgviewConnect.image.size;
    f.origin.x = leftLocation.x-iLeftSpace;
    f.size.width = fabsf(rightLocation.x - leftLocation.x)+iLeftSpace*2;
    self.imgviewConnect.frame = f;
    
}

@end

@implementation LLSelectBtn

@synthesize bSelect,dicContent;
@end
