//
//  SearchViewController.m
//  ChooseHelper
//
//  Created by Apple on 2019/10/11.
//  Copyright © 2019 apple. All rights reserved.
//

#import "SearchViewController.h"
#import "MainCollectionViewCell.h"
#import "GPXQViewController.h"

@interface SearchViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchBarDelegate,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)UILabel *topLabel;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#041833" alpha:1];
    
    UISearchBar *searchBar = [UISearchBar new];
    searchBar.layer.cornerRadius = 5;
    searchBar.delegate = self;
    searchBar.placeholder = @"股票代码/名称";
    searchBar.layer.masksToBounds = YES;
    [self.view addSubview:searchBar];
    [searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.mas_equalTo(self.view.mas_left).with.offset(8);
        make.right.mas_equalTo(self.view.mas_right).with.offset(-61);
        make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT_STATUSBAR + 6);
        make.height.mas_equalTo(33);
        
    }];
    
    UIButton *cancelBtn = [UIButton new];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelBtnCliek:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelBtn];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
      
        make.left.mas_equalTo(searchBar.mas_right).with.offset(0);
        make.right.mas_equalTo(self.view.mas_right).with.offset(0);
        make.top.mas_equalTo(self.view.mas_top).with.offset(HEIGHT_STATUSBAR + 11);
        make.height.mas_equalTo(22);
        
    }];
    
    //创建一个layout布局类
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    //设置布局方向为垂直流布局
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    //设置每个item的大小为100*100
    layout.itemSize = CGSizeMake(83, 42);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
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
        
        make.top.mas_equalTo(searchBar.mas_bottom).with.offset(60);
        make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-33);
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        
    }];
    self.collectionView = collect;
    
    
    UILabel *label = [Utils setLabelWithlines:0 textAlignment:NSTextAlignmentCenter font:[UIFont systemFontOfSize:13] text:@"搜索记录" textColor:[UIColor colorWithHexString:@"#BFBFBF" alpha:1]];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(searchBar.mas_bottom).with.offset(20);
        make.height.mas_equalTo(20);
        make.right.mas_equalTo(self.view.mas_right);
        make.left.mas_equalTo(self.view.mas_left);
        
    }];
    self.topLabel = label;
    
}

- (void)cancelBtnCliek:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDelegate
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MainCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"MainCollectionViewCell" forIndexPath:indexPath];
    
    
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GPXQViewController *vc = [[GPXQViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UISearchBarDelegate
//结束输入
- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
}
//开始输入
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
}
//搜索文字发生改变
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    [self startSearchWithKeywords:searchText];
}
//搜索按钮被点击
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self startSearchWithKeywords:searchBar.text];
}
//取消按钮被点击
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
   
}
//开始搜索操作
- (void)startSearchWithKeywords:(NSString *)keywords {

    if (keywords.length == 0) {
        
        self.topLabel.hidden = NO;
        //显示最近5个
    }
    else
    {
        self.topLabel.hidden = YES;
    }
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
