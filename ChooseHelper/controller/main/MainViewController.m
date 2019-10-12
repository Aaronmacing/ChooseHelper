//
//  MainViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/10.
//  Copyright © 2019 apple. All rights reserved.
//

#import "MainViewController.h"
#import "MainTableViewCell.h"
#import "ClassViewController.h"
#import "MessageViewController.h"
#import "InformationViewController.h"
#import "StockRequetServer.h"
#import "StockNewsModel.h"
#import "UIImageView+WebCache.h"

@interface MainViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate> //实现滚动视图协议
{
   NSArray * _rArr;
   UILabel * _nd;

}
 @property (strong,nonatomic)UIScrollView *scrollview; //滚动视图控件对象
 @property (strong,nonatomic)UIPageControl *pagecontrol;//分页控制控件对象
@property(nonatomic,strong)UITableView *tableView;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#041833" alpha:1];
   

   
    //创建ScrollView并初始化
     self.scrollview = [UIScrollView new];
     //将滚动视图添加到视图控制器控制的视图View容器中
     [self.view addSubview:self.scrollview];
 
    [self.scrollview mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT_STATUSBAR);
         make.left.mas_equalTo(self.view.mas_left);
         make.right.mas_equalTo(self.view.mas_right);
        make.height.mas_equalTo(160);
        
    }];
   
   UIImageView * ssview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索框"]];
   [self.view addSubview:ssview];
   
   UIImageView * fdjview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"搜索icon"]];
   [ssview addSubview:fdjview];
   
   UILabel * ms = [[UILabel alloc] init];
   ms.text = @"股票代码/名称";
   ms.textColor = Uni_RGB(191, 191, 191);
   ms.font = [UIFont systemFontOfSize:13];
   [ssview addSubview:ms];
   
   UIButton * ssBrn = [UIButton buttonWithType:UIButtonTypeCustom];
   [ssBrn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
   [ssview addSubview:ssBrn];


   [ssview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.view);
      make.top.equalTo(self.view).offset(50);
   }];
   
   [fdjview mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(ssview).offset(10);
      make.centerY.equalTo(ssview);
   }];
   
   [ms mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(ssview).offset(36);
      make.centerY.equalTo(ssview);
   }];
   
   [ssBrn mas_makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(ssview);
   }];
    
 
      //创建5个imageView对象并加载图片
      CGFloat x = 0;
      CGFloat y = 0;
      UIImage *image;
      for(int i=0; i<3; i++)
      {
          UIImageView *imageview = [[UIImageView alloc]init];
          image = [UIImage imageNamed:[NSString stringWithFormat:@"banner_%d",i+1]];
          [imageview setImage:image];
          //设置每一个图像视图imageView的frame矩形区域
          imageview.frame = CGRectMake(x+self.view.frame.size.width*i, y, self.view.frame.size.width, 160);
          //设置图像模式，使图片变动时，图片不失真
          imageview.contentMode = UIViewContentModeScaleAspectFit;
          //将图像视图添加到滚动视图容器中
          [self.scrollview addSubview:imageview];
      }
 
      //设置scrollView
      self.scrollview.contentSize = CGSizeMake(3*self.view.frame.size.width, 0);//有多少图片,那么滚动视图的滚动宽度就等于图片数量乘以你所设置的单个滚动视图矩形区域的宽度
      self.scrollview.contentOffset = CGPointZero;//默认滚动视图的初始原点位置都为0
      self.scrollview.pagingEnabled = YES;//设置滚动视图可以进行分页
      self.scrollview.delegate = self;//设置滚动视图的代理
 
      //创建初始化并设置PageControl
      self.pagecontrol = [[UIPageControl alloc]init];
      self.pagecontrol.numberOfPages = 3; //因为有5张图片，所以设置分页数为5
      self.pagecontrol.currentPage  = 0; //默认第一页页数为0
      //设置分页控制点颜色
      self.pagecontrol.currentPageIndicatorTintColor = [UIColor colorWithHexString:@"#2C3346" alpha:1];//未选中的颜色
      self.pagecontrol.pageIndicatorTintColor = [UIColor whiteColor];//选中时的颜色
      //添加分页控制事件用来分页
      [self.pagecontrol addTarget:self action:@selector(pageControlChanged:) forControlEvents:UIControlEventValueChanged];
      //将分页控制视图添加到视图控制器视图中
      [self.view addSubview:self.pagecontrol];
    
    
    [self.pagecontrol mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.mas_equalTo(self.scrollview.mas_bottom);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        
    }];
    
    
    UIButton *leftBtn = [UIButton new];
    [leftBtn addTarget:self action:@selector(leftBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setBackgroundImage:kGetImage(@"m_a") forState:UIControlStateNormal];
    [self.view addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.scrollview.mas_bottom).with.offset(31);
        make.height.mas_equalTo(128);
        make.width.mas_equalTo(128);
        make.left.mas_equalTo(self.view.mas_left).with.offset(13);
        
    }];
    
    UIButton *rightBtn1 = [UIButton new];
    [rightBtn1 addTarget:self action:@selector(rightUpBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn1 setBackgroundImage:kGetImage(@"m_b") forState:UIControlStateNormal];
    [self.view addSubview:rightBtn1];
    [rightBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.scrollview.mas_bottom).with.offset(31);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(200);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-12);
        
    }];
    
    
    UIButton *rightBtn2 = [UIButton new];
    [rightBtn2 setBackgroundImage:kGetImage(@"m_c") forState:UIControlStateNormal];
    [rightBtn2 addTarget:self action:@selector(rightDownBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn2];
    [rightBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(rightBtn1.mas_bottom).with.offset(7);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(200);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-12);
        
    }];
    
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = kGetImage(@"main_flag");
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(leftBtn.mas_bottom).with.offset(40);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(30);
            make.left.mas_equalTo(self.view.mas_left).with.offset(13);
        
    }];
    
    UILabel *label1 = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentLeft font:[UIFont systemFontOfSize:17] text:@"热门动态" textColor:[UIColor colorWithHexString:@"#FEFEFE" alpha:1]];
    [self.view addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(imageView.mas_right).with.offset(8);
        make.width.mas_equalTo(203);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(imageView.mas_top).with.offset(0);
        
    }];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
       self.tableView.backgroundColor = [UIColor clearColor];
       self.tableView.delegate = self;
       self.tableView.dataSource = self;
        self.tableView.emptyDataSetSource = self;
        self.tableView.emptyDataSetDelegate = self;
       [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MainTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"MainTableViewCell"];
       self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       [self.view addSubview:self.tableView];
       
       [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(imageView.mas_bottom).with.offset(10);
           make.bottom.mas_equalTo(self.view.mas_bottom);
           make.left.mas_equalTo(self.view.mas_left).with.offset(0);
           make.right.mas_equalTo(self.view.mas_right).with.offset(0);
           
       }];
   
   _nd = [[UILabel alloc] init];
   _nd.text = @"暂无数据";
   _nd.textColor = [UIColor whiteColor];
   _nd.font = [UIFont systemFontOfSize:22];
   [self.tableView addSubview:_nd];
   
   [_nd mas_makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self.tableView);
   }];
   
   [[StockRequetServer sharedStockRequetServer] getNewsByType:@"caijing" success:^(NSArray * _Nonnull newsList) {
      self->_rArr = newsList;
      
      if (self->_rArr.count > 0) {
         self->_nd.hidden = YES;
      }else{
         self->_nd.hidden = NO;
      }
      [self.tableView reloadData];
      
   } failure:^(NSString * _Nonnull msg) {
      [MBManager showBriefAlert:msg inView:self.view];
   }];
    
}

- (void)searchClick{
   
   
}

- (void)leftBtnCliked:(UIButton *)sender
{
   [[NSNotificationCenter defaultCenter] postNotificationName:@"jump2" object:nil];
}

- (void)rightUpBtnCliked:(UIButton *)sender
{
   ClassViewController *vc = [[ClassViewController alloc]init];
   [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightDownBtnCliked:(UIButton *)sender
{
   InformationViewController *vc = [[InformationViewController alloc]init];
   [self.navigationController pushViewController:vc animated:YES];
    
}



#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 99;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _rArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"MainTableViewCell";
    MainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[MainTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
   NewsInfoModel * model = _rArr[indexPath.row];
   cell.titleLabel.text = model.title;
   cell.timeLabel.text = model.date;
   cell.numLabel.text = @"";
   [cell.rimageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic_s] placeholderImage:[UIImage imageNamed:@"zy_lbpic"]];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
   MessageViewController *vc = [[MessageViewController alloc]init];
   [self.navigationController pushViewController:vc animated:YES];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"no_image");
}






#pragma mark - pageControll的事件响应
-(void)pageControlChanged:(UIPageControl*)sender
{

 CGFloat x = sender.currentPage * self.scrollview.frame.size.width;
  self.scrollview.contentOffset = CGPointMake(x,0);

}

#pragma mark - scrollView的代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  //计算pagecontroll相应地页(滚动视图可以滚动的总宽度/单个滚动视图的宽度=滚动视图的页数)
  NSInteger currentPage = (int)(scrollView.contentOffset.x) / (int)(self.view.frame.size.width);
  self.pagecontrol.currentPage = currentPage;//将上述的滚动视图页数重新赋给当前视图页数,进行分页
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

 


@end
