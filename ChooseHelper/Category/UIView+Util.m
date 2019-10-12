
#import "UIView+Util.h"

@implementation UIView (Util)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}

- (void)setMinX:(CGFloat)minX{
    CGRect frame = self.frame;
    frame.origin.x = minX;
    self.frame = frame;
}

- (CGFloat)minX{
    return CGRectGetMinX(self.frame);
}

- (void)setMinY:(CGFloat)minY{
    CGRect frame = self.frame;
    frame.origin.y = minY;
    self.frame = frame;
}

- (CGFloat)minY{
    return CGRectGetMinY(self.frame);
}

- (void)setMaxX:(CGFloat)maxX{
    self.x = maxX - self.width;
}

- (CGFloat)maxX{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxY:(CGFloat)maxY{
    self.y = maxY - self.height;
}

- (CGFloat)maxY{
    return CGRectGetMaxY(self.frame);
}


- (void)addTarget:(id)target action:(SEL)method{
    [self addTarget:target action:method data:nil];
}

-(void)addTarget:(id)target action:(SEL)method data:(id)data{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:method];
    tap.data = data;
    tap.tapView = self;
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

@end
