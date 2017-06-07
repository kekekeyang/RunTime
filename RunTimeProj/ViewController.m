//
//  ViewController.m
//  RunTimeProj
//
//  Created by 杨海涛 on 6/7/17.
//  Copyright © 2017 杨海涛. All rights reserved.
//

#import "ViewController.h"
#import "ReplaceViewController.h"
#import "DefViewController.h"
#import "ButtonViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"RunTime";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    _dataSource = @[@"替换ViewController生命周期方法",
                   @"解决获取索引、添加、删除元素越界崩溃问题",
                   @"防止按钮重复暴力点击",
                   @"全局更换控件初始效果",
                   @"全局修改导航栏后退（返回）按钮",
                   @"App异常加载占位图通用类封装",];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    //2. 判断是否有可重用的，如果没有，则自己创建
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    
    cell.textLabel.text = _dataSource[indexPath.row];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ReplaceViewController *replace = [[ReplaceViewController alloc]init];
    DefViewController *def = [[DefViewController alloc]init];
    ButtonViewController *btn = [[ButtonViewController alloc]init];
    
    NSInteger index = indexPath.row;
    switch (index) {
        case 0:{
            replace.navigationItem.title = _dataSource[indexPath.row];
            [self.navigationController pushViewController:replace animated:true];
            break;
        }
        case 1:{
            def.navigationItem.title = _dataSource[indexPath.row];
            [self.navigationController pushViewController:def animated:true];
            break;
        }
        case 2:{
            btn.navigationItem.title = _dataSource[indexPath.row];
            [self.navigationController pushViewController:btn animated:YES];
            break;
        }
        case 6:{
            
            break;
        }
            
            
        default:
            break;
    }
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 44;
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
