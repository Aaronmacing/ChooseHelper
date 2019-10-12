
#import "UITapGestureRecognizer+Property.h"
#import <objc/runtime.h>

@implementation UITapGestureRecognizer (Property)

@dynamic data;
@dynamic tapView;

-(void)setData:(id)data{
     objc_setAssociatedObject(self, @selector(data), data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(id)data{
    return objc_getAssociatedObject(self, @selector(data));
}

-(void)setTapView:(UIView *)tapView{
    objc_setAssociatedObject(self, @selector(tapView), tapView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIView *)tapView{
    return objc_getAssociatedObject(self, @selector(tapView));
}

@end
