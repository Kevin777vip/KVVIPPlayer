//
//  ViewController.m
//  KVVipPlayer
//
//  Created by fb on 2018/6/20.
//  Copyright © 2018 com.fengbangstore. All rights reserved.
//

#import "ViewController.h"
#import "BaseWebViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configData];
    [self configUI];
}

- (void)configData{
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:@"爱奇艺"];
    [_dataArray addObject:@"优酷"];
    [_dataArray addObject:@"腾讯"];
    [_dataArray addObject:@"本地视频"];
}

- (void)configUI{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"main_cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"main_cell"];
    }
    
    if (_dataArray.count>indexPath.row) {
        cell.textLabel.text = _dataArray[indexPath.row];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            [self goWebView:0];
            break;
        case 1:
            [self goWebView:1];
            break;
        case 2:
            [self goWebView:2];
            break;
        default:
            break;
    }
}

-(void)goWebView:(NSInteger)index{
    NSLog(@"web");
    BaseWebViewController *webView = [[BaseWebViewController alloc]init];
    switch (index) {
        case 0:
            webView.webUrlStr = @"http://www.iqiyi.com";
            break;
        case 1:
            webView.webUrlStr = @"http://www.youku.com";
            break;
        case 2:
            webView.webUrlStr = @"https://v.qq.com";
            break;
        default:
            break;
    }
    [self.navigationController pushViewController:webView animated:YES];
}

-(void)goLocalVideoList{
    
}

@end
