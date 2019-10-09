//
//  ViewController.m
//  smallTa
//
//  Created by Apple on 2019/9/27.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ViewController.h"
#import "MainCollectionViewCell.h"
#import "ListTableViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
//全部
@property(nonatomic,strong)NSMutableArray *dataSource;
@property (nonatomic,copy) NSString *filePatch;
@property(nonatomic,strong)UILabel *firstLabel;
@property(nonatomic,strong)UILabel *secondLabel;
@property(nonatomic,assign)NSInteger showPlace;
@property (nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *messsages;
@property(nonatomic,assign)int total;
@property(nonatomic,assign)int user;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"Trip Record";
    
    
        
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    self.filePatch = [path stringByAppendingPathComponent:@"Data.plist"];//没有会自动创建
    self.dataSource = [[NSMutableArray alloc]init];

    NSMutableArray *sandBoxDataArray = [[NSMutableArray alloc]initWithContentsOfFile:self.filePatch];
    [self.dataSource addObjectsFromArray:sandBoxDataArray];

    self.showPlace = 0;
        
        
    UIButton *back = [UIButton new];
    [back setImage:kGetImage(@"right") forState:UIControlStateNormal];
    [back addTarget:self action:@selector(reocrdBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:back];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT_STATUSBAR);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(self.view.mas_right);
        
    }];
        
        
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(18, 18);
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.sectionInset = UIEdgeInsetsMake(0, 18, 0, 18);
    //创建collectionView 通过一个布局策略layout来创建
    UICollectionView * collect = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    //代理设置
    collect.backgroundColor = [UIColor clearColor];
    collect.delegate = self;
    collect.dataSource = self;
    collect.emptyDataSetSource = self;
    collect.emptyDataSetDelegate = self;
    //注册item类型 这里使用系统的类型
    [collect registerNib:[UINib nibWithNibName:NSStringFromClass([MainCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"MainCollectionViewCell"];
    [self.view addSubview:collect];
    
    [collect mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(0);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-33);
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        
    }];
    self.collectionView = collect;
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
     self.tableView.emptyDataSetSource = self;
     self.tableView.emptyDataSetDelegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ListTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ListTableViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(145);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-60);
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
        
    }];
    
    
    UILabel *firstLabel = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:@"-- days have passed" textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [self.view addSubview:firstLabel];
    [firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(30);
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
        
    }];
    [firstLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];

    UILabel *secondLabel = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:16] text:@"-- days remaining" textColor:[UIColor colorWithHexString:@"#333333" alpha:1]];
    [self.view addSubview:secondLabel];
    [secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(firstLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo(self.view.mas_left).with.offset(18);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-18);
        
    }];
    [secondLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    self.secondLabel = secondLabel;
    self.firstLabel = firstLabel;

    
    UIButton *add1 = [UIButton new];
    [add1 setBackgroundImage:kGetImage(@"up_add") forState:UIControlStateNormal];
    [add1 setTitle:@"Add a big event" forState:UIControlStateNormal];
    [add1 addTarget:self action:@selector(addNote) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add1];
    [add1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(secondLabel.mas_bottom).with.offset(15);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    UIButton *add2 = [UIButton new];
    [add2 setBackgroundImage:kGetImage(@"add") forState:UIControlStateNormal];
    [add2 addTarget:self action:@selector(addTag) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:add2];
    [add2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-20);
        make.width.mas_equalTo(78);
        make.height.mas_equalTo(78);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    [self getDataFromPlist];
}

- (void)getDataFromPlist {
    //沙盒获取路径
    NSArray *pathArray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [pathArray objectAtIndex:0];
    //获取文件的完整路径
    NSString *filePatch = [path stringByAppendingPathComponent:@"info.plist"];//没有会自动创建
    NSMutableArray *sandBoxDataArray = [[NSMutableArray alloc]initWithContentsOfFile:filePatch];
    self.filePatch = filePatch;
    self.dataSource = [[NSMutableArray alloc]init];
    [self.dataSource addObjectsFromArray:sandBoxDataArray];
    
    
    if (self.dataSource.count > 0) {
        
        self.showPlace = 0;
        NSDictionary *dic = self.dataSource[0];
        self.total = [dic[@"remain"] intValue];
        self.user = [dic[@"user"] intValue];
        self.titleLabel.text = dic[@"name"];
        self.messsages = [[NSMutableArray alloc]init];
        [self.messsages addObjectsFromArray:dic[@"data"]];
        
        self.user = self.user + [self comPareDay:dic[@"time"]];
    
        
        self.firstLabel.text = [NSString stringWithFormat:@"%d days have passed",self.user];
        self.secondLabel.text = [NSString stringWithFormat:@"%d days remaining",self.total - self.user];
        
        [self.tableView reloadData];
        [self.collectionView reloadData];
        
    }
    else
    {
        self.total = 0;
        self.user = 0;
        self.messsages = [[NSMutableArray alloc]init];
        [self.tableView reloadData];
        [self.collectionView reloadData];
    }

}

- (int)comPareDay:(NSString *)date
{
    NSDate * nowDate = [NSDate date];
    NSString *dateString = date;
    //字符串转NSDate格式的方法
    NSDate * ValueDate = [self StringTODate:dateString];
    //计算两个中间差值(秒)
    NSTimeInterval time = [nowDate timeIntervalSinceDate:ValueDate];
    
    //开始时间和结束时间的中间相差的时间
    int days;
    days = ((int)time)/(3600*24);  //一天是24小时*3600秒
    return days;
}

- (NSDate *)StringTODate:(NSString *)sender
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"YYYY-MMMM-dd";
    [dateFormatter setMonthSymbols:[NSArray arrayWithObjects:@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12", nil]];
    NSDate * ValueDate = [dateFormatter dateFromString:sender];
    return ValueDate;

}

- (NSString *)stringFromDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (void)backBtnCliked:(UIButton *)sender
{
    if (self.dataSource.count > 0) {
        
        self.showPlace--;
        
        if (self.showPlace < 0) {
            
            self.showPlace = self.dataSource.count - 1;
            
        }
        [self resetMessage];
        
    }
}

- (void)reocrdBtnCliked:(UIButton *)sender
{
    if (self.dataSource.count > 0) {
        
        self.showPlace++;
        
        if (self.showPlace >= self.dataSource.count) {
            
            self.showPlace = 0;
            
        }
        [self resetMessage];
    }
}

- (void)resetMessage
{
    [self.messsages removeAllObjects];
    NSDictionary *dic = self.dataSource[self.showPlace];
    self.total = [dic[@"remain"] intValue];
    self.user = [dic[@"user"] intValue];
    self.titleLabel.text = dic[@"name"];
    [self.messsages addObjectsFromArray:dic[@"data"]];
    
    self.user = self.user + [self comPareDay:dic[@"time"]];

    
    self.firstLabel.text = [NSString stringWithFormat:@"%d days have passed",self.user];
    self.secondLabel.text = [NSString stringWithFormat:@"%d days remaining",self.total - self.user];
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
}

- (void)addTag
{
    YCAlertView *alert = [[YCAlertView alloc]initWithFrame:CGRectMake(0, 0, 345, 389) withTitle:@"" confrimBolck:^(id obj) {
        
        NSArray *array = obj;
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:array[0] forKey:@"name"];
        [dic setObject:array[1] forKey:@"remain"];
        [dic setObject:array[2] forKey:@"user"];
        [dic setObject:[self stringFromDate:[NSDate date]] forKey:@"time"];
        [dic setObject:[[NSArray alloc]init] forKey:@"data"];
        
        [self.dataSource addObject:dic];
        
        [self.dataSource writeToFile:self.filePatch atomically:YES];
        
        self.showPlace = self.dataSource.count - 1;
        [self resetMessage];
        
    } cancelBlock:^{
        
    }];
    [alert show];
}

- (void)addNote
{
    
    if (self.dataSource.count > 0) {
     
        YCAlertView *alert = [[YCAlertView alloc]initWithFrame:CGRectMake(0, 0, 345, 414) withTitle:@"" placeArray:@[@""] confrimBolck:^(id obj) {
            
            NSArray *array = obj;
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:array[0] forKey:@"time"];
            [dic setObject:array[1] forKey:@"message"];

            [self.messsages addObject:dic];
            
            
            NSArray *sa = [[NSArray alloc]initWithArray:self.messsages];
            
            
            NSMutableDictionary *params = [[NSMutableDictionary alloc]initWithDictionary:self.dataSource[self.showPlace]];
            [params setObject:sa forKey:@"data"];
            [self.dataSource replaceObjectAtIndex:self.showPlace withObject:params];
            [self.dataSource writeToFile:self.filePatch atomically:YES];
            [self.tableView reloadData];
            
            
            
            
            
        } cancelBlock:^{
            
        }];
        [alert show];
    }
}


#pragma mark - UICollectionViewDelegate
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.total;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row < self.user) {
        
        cell.backgroundColor = [UIColor colorWithHexString:@"#FF9CA7" alpha:1];
    }
    else
    {
        cell.backgroundColor = [UIColor colorWithHexString:@"#FFE5E8" alpha:1];
    }
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 31;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 7.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.messsages.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ListTableViewCell";
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ListTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dic = self.messsages[indexPath.row];
    cell.nameLabel.text = dic[@"time"];
    cell.messageLabel.text = dic[@"message"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"no_image");
}



@end
