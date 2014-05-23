#import <Foundation/Foundation.h>


@interface OBBadgeView : UIView
@property(nonatomic, strong) UIColor *fillColor;

@property(nonatomic, strong) UIColor *strokeColor;

- (void)setBadgeText:(NSString *)value;

- (void)hide;

- (void)show;

- (void)noStroke;

- (void)setFontColor:(UIColor *)color;

- (void)shadow:(BOOL)showShadow;
@end
