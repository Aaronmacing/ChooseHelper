//
//  YCAlertView.m
//  YCAlertView
//
//  Created by zyc on 2017/11/1.
//  Copyright © 2017年 YC. All rights reserved.
//

#import "YCAlertView.h"



#define TagValue  1000
#define AlertTime 0.3 //弹出动画时间
#define DropTime 0.5 //落下动画时间
#define Uni_STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height



@interface YCAlertView()

@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *ContentLB;
@property(nonatomic,strong)UIButton *cancleBtn;
@property(nonatomic,strong)UIButton *sureBtn;
@property(nonatomic,strong)UITextField *inputTF;
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,assign)int num;
@end

@implementation YCAlertView

-(void)cancleBtnClick{
    [self hide];
    if (_cancleBlock) {
        _cancleBlock();
    }
}
-(void)sureBtnClick:(UIButton *)sender{
    
    
    if (self.num == 1) {
        
        UITextField *tf1 = [self viewWithTag:20];
        UITextView *tf2 = [self viewWithTag:21];
        if (tf1.text.length > 0 && tf2.text.length > 0) {
         
            [self hide];
            if (_sureBlock) {
                _sureBlock(@[tf1.text,tf2.text]);
            }
        }
    }
    else
    {
        UITextField *tf1 = [self viewWithTag:20];
        UITextField *tf2 = [self viewWithTag:21];
        UITextField *tf3 = [self viewWithTag:22];
        if (tf1.text.length > 0 && tf2.text.length > 0 && tf3.text.length > 0) {
         
            [self hide];
            if (_sureBlock) {
                _sureBlock(@[tf1.text,tf2.text,tf3.text]);
            }
        }
    }
}

-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *iview = [[UIView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    iview.tag = TagValue;
    iview.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [iview addGestureRecognizer:tap];
    iview.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    [[UIApplication sharedApplication].keyWindow addSubview:iview];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}


//弹出隐藏
-(void)hide{
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform = CGAffineTransformScale(self.transform,0.1,0.1);
            self.alpha = 0;
        } completion:^(BOOL finished) {
            UIView *bgview = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgview) {
                [bgview removeFromSuperview];
            }
            [self removeFromSuperview];
        }];
    }
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title confrimBolck:(void (^)(id obj))confrimBlock cancelBlock:(void (^)(void))cancelBlock{
    if (self = [super initWithFrame:frame]) {
        [self customUIwith:frame title:title];
        _sureBlock = confrimBlock;
        _cancleBlock = cancelBlock;
    }
    return self;
}


-(void)customUIwith:(CGRect)frame title:(NSString *)title
{
    UIImageView *bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bgimageview.image = [UIImage imageNamed:@"a_1_bg"];
    [self addSubview:bgimageview];
    
    UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:@"Add time spectrum" textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    label.frame = CGRectMake(0, 30, 345, 16);
    [self addSubview:label];
    
    NSArray *array = @[@"Time spectrum label",@"Time limit",@"Has been running for"];
    for (int i = 0; i < 3; i++) {
        
        UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:array[i] textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
        label.frame = CGRectMake(0, 62 + 92 * i, 345, 16);
        [self addSubview:label];
        
        
    }
    
    
    for (int i = 0; i < 3; i++) {
        
        UITextField *inputTF = [[UITextField alloc]init];
        if (i == 0) {
            
            inputTF.frame = CGRectMake(16, 89 + 92 * i, 315, 44);
        }
        else
        {
            inputTF.frame = CGRectMake(16, 89 + 92 * i, 276, 44);
            inputTF.keyboardType = UIKeyboardTypeNumberPad;
        }
        inputTF.tag = 20 + i;
        inputTF.tintColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        inputTF.background = kGetImage(@"tf_bg");
        inputTF.textAlignment = NSTextAlignmentCenter;
        inputTF.font = [UIFont systemFontOfSize:20];
        inputTF.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:inputTF];
    }
    
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:@"days" textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
        label.frame = CGRectMake(291, 89 + 92 + 92 * i, 55, 44);
        [self addSubview:label];
        
        
    }
    
    
    



    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 345, 345, 44)];
    imageView.image = kGetImage(@"btm_bg");
    [self addSubview:imageView];

    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(344 / 2, 345, 1, 44)];
    imageView1.image = kGetImage(@"line");
    [self addSubview:imageView1];

    
    _cancleBtn = [UIButton new];
     _cancleBtn.frame = CGRectMake(0, 345, 344 / 2, 44);
    [_cancleBtn setTitle:@"Cancel" forState:UIControlStateNormal];
     [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:_cancleBtn];
    
     _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(344 / 2 + 1, 345, 344 / 2, 44);
     [_sureBtn setTitle:@"OK" forState:UIControlStateNormal];
     [self addSubview:_sureBtn];
     [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}

- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title placeArray:(NSArray *)placeArray confrimBolck:(void (^)(id obj))confrimBlock cancelBlock:(void (^)(void))cancelBlock
{
    if (self = [super initWithFrame:frame]) {
        [self customUIwith:frame title:title placeArray:placeArray];
        _sureBlock = confrimBlock;
        _cancleBlock = cancelBlock;
    }
    return self;
}


-(void)customUIwith:(CGRect)frame title:(NSString *)title placeArray:(NSArray *)placeArray{
    
    
    self.num = 1;
    
    
    UIImageView *bgimageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    bgimageview.image = [UIImage imageNamed:@"a_2_bg"];
    [self addSubview:bgimageview];
    
    UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:@"Add time spectrum" textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    label.frame = CGRectMake(0, 30, 345, 16);
    [self addSubview:label];
    
    NSArray *array = @[@"Time node",@"Event description"];
    for (int i = 0; i < 2; i++) {
        
        UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:array[i] textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
        label.frame = CGRectMake(0, 62 + 95 * i, 345, 16);
        [self addSubview:label];
        
        
    }
    
    
    for (int i = 0; i < 1; i++) {
        
        UITextField *inputTF = [[UITextField alloc]init];
        inputTF.frame = CGRectMake(16, 89 + 92 * i, 315, 44);
        inputTF.tag = 20 + i;
        inputTF.tintColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        inputTF.background = kGetImage(@"tf_bg");
        inputTF.textAlignment = NSTextAlignmentCenter;
        inputTF.font = [UIFont systemFontOfSize:20];
        inputTF.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
        [self addSubview:inputTF];
    }
    

    UITextView* textView = [[UITextView alloc] initWithFrame:CGRectMake(15, 180, 315, 160)];
    textView.backgroundColor = Uni_RGB(254, 229, 232);
    textView.tag = 21;
    textView.font = [UIFont systemFontOfSize:16];
    //对齐
    textView.textColor = [UIColor colorWithHexString:@"#333333" alpha:1];
    textView.textAlignment = NSTextAlignmentLeft;
    textView.autocorrectionType = UITextAutocorrectionTypeNo;//自动纠错方式
    textView.autocapitalizationType = UITextAutocapitalizationTypeNone;//自动大写方式
    [self addSubview:textView];
    
    



    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 370, 345, 44)];
    imageView.image = kGetImage(@"btm_bg");
    [self addSubview:imageView];

    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(344 / 2, 370, 1, 44)];
    imageView1.image = kGetImage(@"line");
    [self addSubview:imageView1];

    
    _cancleBtn = [UIButton new];
     _cancleBtn.frame = CGRectMake(0, 370, 344 / 2, 44);
    [_cancleBtn setTitle:@"Cancel" forState:UIControlStateNormal];
     [_cancleBtn addTarget:self action:@selector(cancleBtnClick) forControlEvents:UIControlEventTouchUpInside];
     [self addSubview:_cancleBtn];
    
     _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _sureBtn.frame = CGRectMake(344 / 2 + 1, 370, 344 / 2, 44);
     [_sureBtn setTitle:@"OK" forState:UIControlStateNormal];
     [self addSubview:_sureBtn];
     [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


@end
