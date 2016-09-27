//
//  FUTableViewIndexBar.m
//  FUTableViewIndexBar
//
//  Copyright (c) 2016 fujunzhi. All rights reserved.
//  change by fjz  Inspiration from ‘AIMTableViewIndexBar’


#import <QuartzCore/QuartzCore.h>
#import "FUTableViewIndexBar.h"

#if !__has_feature(objc_arc)
#error FUTableViewIndexBar must be built with ARC.
// You can turn on ARC for only FUTableViewIndexBar files by adding -fobjc-arc to the build phase for each of its files.
#endif

#define RGB(r,g,b,a)  [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:a]

@interface FUTableViewIndexBar ()
{
    BOOL isLayedOut;
    CGFloat fontSize;
    NSMutableArray *letters;
    CAShapeLayer *shapeLayer;
    CGFloat letterHeight;
}
@property (strong, nonatomic) UIColor *borderColor;
@property (strong, nonatomic) UIColor *indexTextColor;
@property (strong, nonatomic) UIColor *animateColor;
@property (strong, nonatomic) UIColor *selectIndexColor;
@end


@implementation FUTableViewIndexBar
@synthesize indexes, delegate;

- (id)init{
    if (self = [super init]){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor indexTextColor:(UIColor *)indexTextColor animateColor:(UIColor *)animateColor selectIndexColor:(UIColor *)selectColor
{
    self.borderColor = borderColor;
    self.indexTextColor = indexTextColor;
    self.animateColor = animateColor;
    self.selectIndexColor = selectColor;
    return [self initWithFrame:frame];
}

+ (instancetype)fuTableViewIndexBarWithFrame:(CGRect)frame borderColor:(UIColor *)borderColor indexTextColor:(UIColor *)indexTextColor animateColor:(UIColor *)animateColor selectIndexColor:(UIColor *)selectColor
{
    return [[self alloc] initWithFrame:frame borderColor:borderColor indexTextColor:indexTextColor animateColor:animateColor selectIndexColor:selectColor];
}


- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (void)setup {
    self.defaultIndextList = NO;
    self.selectBig = YES;
    
    shapeLayer = [CAShapeLayer layer];
    shapeLayer.lineWidth = 1.0f;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineJoin = kCALineCapSquare;
    if (!self.borderColor)
        self.borderColor = RGB(218, 218, 218, 1);
    shapeLayer.strokeColor = self.borderColor.CGColor;
    shapeLayer.strokeEnd = 1.0f;
    self.layer.masksToBounds = NO;
}

- (void)setIndexes:(NSArray *)idxs {
    indexes = idxs;
    isLayedOut = NO;
    
    if (self.isDefaultIndextList)
        letters = [@[@"#", @"A", @"B", @"C",
                     @"D", @"E", @"F", @"G",
                     @"H", @"I", @"J", @"K",
                     @"L", @"M", @"N", @"O",
                     @"P", @"Q", @"R", @"S",
                     @"T", @"U", @"V", @"W",
                     @"X", @"Y", @"Z"] mutableCopy];
    else
    {
        letters = [@[@"#"] mutableCopy];
        [letters addObjectsFromArray:indexes];
    }
    [self layoutSubviews];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (!isLayedOut){
        
        [self.layer.sublayers makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
        
        shapeLayer.frame = (CGRect) {.origin = CGPointZero, .size = self.layer.frame.size};
        UIBezierPath *bezierPath = [UIBezierPath bezierPath];
        [bezierPath moveToPoint:CGPointZero];
        [bezierPath addLineToPoint:CGPointMake(0, self.frame.size.height)];
        letterHeight = self.frame.size.height / [letters count];
        fontSize = 12;
        if (letterHeight < 14){
            fontSize = 11;
        }
        
        [letters enumerateObjectsUsingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
            CGFloat originY = idx * letterHeight;
            CALayer *temp = [[CALayer alloc] init];
            temp.frame = CGRectMake(0, originY, self.frame.size.width, letterHeight);
            
            CGFloat textLayerH = [self limitText:@"A" Size:CGSizeMake(self.frame.size.width, MAXFLOAT) font:[UIFont systemFontOfSize:fontSize]].height;
            CGFloat textLayerY = (letterHeight - textLayerH) *0.5;
            CATextLayer *ctl = [self textLayerWithSize:fontSize
                                                string:letter
                                              andFrame:CGRectMake(0,textLayerY, self.frame.size.width, textLayerH)];
            
            
            [temp addSublayer:ctl];
            [self.layer addSublayer:temp];
            
            [bezierPath moveToPoint:CGPointMake(0, originY)];
            [bezierPath addLineToPoint:CGPointMake(ctl.frame.size.width, originY)];
        }];
        
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        isLayedOut = YES;
    }
}

- (CATextLayer*)textLayerWithSize:(CGFloat)size string:(NSString*)string andFrame:(CGRect)frame {
    CATextLayer *tl = [CATextLayer layer];
    [tl setFont:@"ArialMT"];
    [tl setFontSize:size];
    [tl setFrame:frame];
    [tl setAlignmentMode:kCAAlignmentCenter];
    [tl setContentsScale:[[UIScreen mainScreen] scale]];
    if (!self.indexTextColor)
        self.indexTextColor = RGB(168, 168, 168, 1);
    [tl setForegroundColor:self.indexTextColor.CGColor];
    [tl setString:string];
    return tl;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
	[self sendEventToDelegate:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
	[self sendEventToDelegate:event];
}

- (void)sendEventToDelegate:(UIEvent*)event{
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint point = [touch locationInView:self];
    NSInteger indx = (NSInteger) floorf(fabs(point.y) / letterHeight);
    indx = indx < [letters count] ? indx : [letters count] - 1;
    
    [self animateLayerAtIndex:indx];
    
    __block NSInteger scrollIndex;
    NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndexesInRange:NSMakeRange(0, indx+1)];
    [letters enumerateObjectsAtIndexes:indexSet options:NSEnumerationReverse usingBlock:^(NSString *letter, NSUInteger idx, BOOL *stop) {
        //        scrollIndex = [indexes indexOfObject:letter];
        //        *stop = scrollIndex != NSNotFound;
        BOOL isExist = [indexes containsObject:letter];
        if (isExist) {
            scrollIndex = [indexes indexOfObject:letter];
            if (self.delegate && [self.delegate respondsToSelector:@selector(fu_TableViewIndexBar:didSelectSectionAtIndex:)])
                [self.delegate fu_TableViewIndexBar:self didSelectSectionAtIndex:scrollIndex];
        }
        *stop = YES;
    }];
    
    //    [delegate tableViewIndexBar:self didSelectSectionAtIndex:scrollIndex];
}

- (void)animateLayerAtIndex:(NSInteger)index{
    if ([self.layer.sublayers count] - 1 > index){
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
        if (!self.animateColor) 
            self.animateColor = RGB(180, 180, 180, 1);
        animation.toValue = (id)self.animateColor.CGColor;
        animation.duration = 0.5f;
        animation.autoreverses = YES;
        animation.repeatCount = 1;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
        [self.layer.sublayers[index] addAnimation:animation forKey:@"myAnimation"];
        
        CGFloat selectFontSize = fontSize + (self.isSelectBig ? 2 : 0);
        for (int i = 0; i < self.layer.sublayers.count; i ++) {
            CATextLayer *currentLayer = (CATextLayer *)self.layer.sublayers[i].sublayers[0];
            [currentLayer setFontSize:fontSize];
            currentLayer.foregroundColor = self.indexTextColor.CGColor;
            if (i == index)
            {
                [currentLayer setFontSize:selectFontSize];
                currentLayer.foregroundColor = self.selectIndexColor.CGColor;
            }
        }
    }  
}

- (CGSize)limitText:(NSString *)text Size:(CGSize)size font:(UIFont *)font
{
    NSDictionary *attributesDic = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributesDic context:nil].size;
}



@end













