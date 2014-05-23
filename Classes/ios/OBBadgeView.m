#import "OBBadgeView.h"


@interface OBBadgeView ()
@property(nonatomic, strong) UIColor *textColor;
@property(nonatomic, strong) UIColor *shadowColor;
@property(nonatomic) CGSize shadowOffset;
@property(nonatomic) float shadowBlurRadius;
@property(nonatomic, copy) NSString *badgeString;
@property(nonatomic, copy) NSString *fontName;
@end

@implementation OBBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
        self.backgroundColor = [UIColor clearColor];
    }

    return self;
}

- (void)setDefaultValues {
    self.fillColor = [UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1.0];
    self.textColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1.0];
    self.strokeColor = [UIColor colorWithRed:0.878 green:0.878 blue:0.878 alpha:1.0];
    self.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.22];
    self.shadowOffset = CGSizeMake(0.1, 1.1);
    self.shadowBlurRadius = 0.5;
    self.badgeString = @" ";
    self.fontName = @"Avenir-Light";
    self.userInteractionEnabled = NO;
}

- (void)drawRect:(CGRect)frame {

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGRect group = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.17045 + 0.5), CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.15909 + 0.5), floor(CGRectGetWidth(frame) * 0.84091 + 0.5) - floor(CGRectGetWidth(frame) * 0.17045 + 0.5), floor(CGRectGetHeight(frame) * 0.82955 + 0.5) - floor(CGRectGetHeight(frame) * 0.15909 + 0.5));

    CGRect badgeCountRect = CGRectMake(CGRectGetMinX(frame) + floor(CGRectGetWidth(frame) * 0.23864 + 0.5),
            CGRectGetMinY(frame) + floor(CGRectGetHeight(frame) * 0.25 + 0.5),
            floor(CGRectGetWidth(frame) * 0.78409 + 0.5) - floor(CGRectGetWidth(frame) * 0.23864 + 0.5),
            floor(CGRectGetHeight(frame) * 0.75 + 0.5) - floor(CGRectGetHeight(frame) * 0.25 + 0.5));

    CGRect badgeCircleRect = CGRectMake(CGRectGetMinX(group) + floor(CGRectGetWidth(group) * 0.00847) + 0.5, CGRectGetMinY(group) + floor(CGRectGetHeight(group) * 0.00847) + 0.5, floor(CGRectGetWidth(group) * 0.99153) - floor(CGRectGetWidth(group) * 0.00847), floor(CGRectGetHeight(group) * 0.99153) - floor(CGRectGetHeight(group) * 0.00847));

    {
        CGContextSaveGState(context);
        CGContextSetShadowWithColor(context, self.shadowOffset, self.shadowBlurRadius, self.shadowColor.CGColor);
        CGContextBeginTransparencyLayer(context, NULL);

        UIBezierPath* badgeCirclePath = [UIBezierPath bezierPathWithOvalInRect: badgeCircleRect];
        [self.fillColor setFill];
        [badgeCirclePath fill];
        [self.strokeColor setStroke];
        badgeCirclePath.lineWidth = 2;
        [badgeCirclePath stroke];


        CGContextEndTransparencyLayer(context);
        CGContextRestoreGState(context);
    }

    [self.textColor setFill];
    [self.badgeString drawInRect:badgeCountRect withFont:[UIFont fontWithName:self.fontName size:badgeCountRect.size.height * self.determineFontHeight] lineBreakMode:UILineBreakModeWordWrap alignment:UITextAlignmentCenter];
}

- (float)determineFontHeight {
    CGSize size = [self.badgeString sizeWithFont:[UIFont fontWithName:self.fontName size:12]];
    float pointsPerPixel = 12.0 / size.height;
    return pointsPerPixel;
}

- (void)setBadgeText:(NSString *)value {
    self.badgeString = value;
    [[UIColor redColor] CGColor];
    [self setNeedsDisplay];
}

- (void)hide{
    self.hidden = YES;
}

- (void)show{
    self.hidden = NO;
}

- (void)noStroke {
    self.strokeColor = self.fillColor;
    [self setNeedsDisplay];
}

- (void)setFontColor:(UIColor *)color {
    self.textColor = color;
    [self setNeedsDisplay];
}

- (void)shadow:(BOOL)showShadow {
    if(!showShadow) {
        self.shadowColor = [UIColor clearColor];
        [self setNeedsDisplay];
    }
}
@end
