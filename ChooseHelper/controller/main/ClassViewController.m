//
//  ClassViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "ClassViewController.h"
#import "ClassTableViewCell.h"
#import "PlayViewController.h"

@interface ClassViewController ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,assign)NSInteger leftSelect;
@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titleLabel.text = @"投资课堂";
    
    
      for (int i = 0; i < 4; i++) {
          UIButton *btn = [UIButton new];
          btn.tag = 10 + i;
          [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c_%d_normal",i + 1]] forState:UIControlStateNormal];
          [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"c_%d_select",i + 1]] forState:UIControlStateSelected];
          [btn addTarget:self action:@selector(leftBtnCliked:) forControlEvents:UIControlEventTouchUpInside];
          [self.view addSubview:btn];
          [btn mas_makeConstraints:^(MASConstraintMaker *make) {
              make.left.mas_equalTo(self.view.mas_left).with.offset(8 + ( (Uni_kMainScreenWidth - 16 - 65 * 4) / 3  + 65) * i);
              make.width.mas_equalTo(65);
              make.height.mas_equalTo(89);
              make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(17);
          }];
          
          if (i == 0) {
              btn.selected = YES;
              self.leftSelect = 0;
            
          }
      }
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
   self.tableView.backgroundColor = [UIColor whiteColor];
   self.tableView.delegate = self;
   self.tableView.dataSource = self;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
   [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ClassTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"ClassTableViewCell"];
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   [self.view addSubview:self.tableView];
   
   [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.titleLabel.mas_bottom).with.offset(129 + 5);
       make.bottom.mas_equalTo(self.view.mas_bottom);
       make.left.mas_equalTo(self.view.mas_left).with.offset(0);
       make.right.mas_equalTo(self.view.mas_right).with.offset(0);
       
   }];
    
}

- (void)leftBtnCliked:(UIButton *)sender
{
    if (sender.tag - 10 == self.leftSelect) {
        
    }
    else
    {
        sender.selected = YES;
        UIButton *btn = [self.view viewWithTag:10 + self.leftSelect];
        btn.selected = NO;
        
        self.leftSelect = sender.tag - 10;
    }
}

- (void)czBtnCliked:(UIButton *)sender
{
    
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];

          
    return view;
}



#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"ClassTableViewCell";
    ClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ClassTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    //设置cell没有选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

   
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayViewController *vc = [[PlayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}



- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
{
    return kGetImage(@"no_image");
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
