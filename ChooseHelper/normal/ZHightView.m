//
//  ZZHDateView.m
//  XHJY_app
//
//  Created by zzh_iPhone on 16/3/9.
//  Copyright © 2016年 LiangXiaobin. All rights reserved.
//

#import "ZHightView.h"
#import "Constant.h"

#define hScale ([UIScreen mainScreen].bounds.size.height) / 667

@interface ZHightView ()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    UIView *mainView;
    UIPickerView *pickerVIew;
}
@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,retain)NSMutableArray *dataArray;
@end

@implementation ZHightView

- (id)initWithFrame:(CGRect)frame withTitle:(NSString *)title withDataSource:(NSArray *)array withSelectid:(NSInteger)num
{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (num < 0) {
            num = 0;
        }
        
        self.selectIndex = -1;
        _dataArray = [[NSMutableArray alloc]initWithArray:array];
        UIView *backGroundView = [[UIView alloc]initWithFrame:self.frame];
        backGroundView.backgroundColor = Uni_RGBA(0, 0, 0, 0.3);
        [self addSubview:backGroundView];
        
        
//        UITapGestureRecognizer *gp = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidden)];
//        [backGroundView addGestureRecognizer:gp];
        
        
        mainView = [[UIView alloc]init];
        mainView.frame = CGRectMake(0, Uni_kMainScreenHeight-260 * hScale, Uni_kMainScreenWidth, 260*hScale);
        mainView.backgroundColor = [UIColor whiteColor];
        [backGroundView addSubview:mainView];
        
        pickerVIew = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 44, Uni_kMainScreenWidth, 180)];
        pickerVIew.delegate = self;
        pickerVIew.dataSource = self;
        [pickerVIew selectRow:num inComponent:0 animated:YES];
        [mainView addSubview:pickerVIew];
        self.selectIndex = num;
        
        
        
        UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        sureBtn.frame = CGRectMake(Uni_kMainScreenWidth - 15 - 26, 10, 40, 26);
        [sureBtn setTitle:@"OK" forState:UIControlStateNormal];
        [sureBtn setTitleColor:[UIColor colorWithHexString:@"#343C62" alpha:1] forState:UIControlStateNormal];
        [sureBtn addTarget:self action:@selector(selectTime:) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:sureBtn];
        
        UIButton *close = [UIButton buttonWithType:UIButtonTypeSystem];
        close.frame = CGRectMake(15, 10, 60, 26);
        [close setTitle:@"Cancel" forState:UIControlStateNormal];
        [close setTitleColor:[UIColor colorWithHexString:@"#9398B0" alpha:1] forState:UIControlStateNormal];
        [close addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        [mainView addSubview:close];
        
    }
    
    return self;
}


- (void)selectTime:(UIButton *)sender
{
    [self hidden];
    if (self.calendarBlock)
    {
        if (self.selectIndex == -1) {
        
            self.calendarBlock(0);
        }
        else
        {
            self.calendarBlock(self.selectIndex);
        }
    }
    
}

- (void)show
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self->mainView.center = mainView.center =  CGPointMake(Uni_kMainScreenWidth / 2, Uni_kMainScreenHeight - mainView.bounds.size.height / 2);

    }];
}

- (void)hidden
{
    [UIView animateWithDuration:0.5 animations:^{
        
        self->mainView.center = mainView.center =  CGPointMake(Uni_kMainScreenWidth / 2, Uni_kMainScreenHeight + mainView.bounds.size.height * 2);
        
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
            
        }
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return  self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectIndex = row;
}

@end
