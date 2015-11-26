//
//  MessageController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "MessageController.h"
#import "ViewController_1.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"发私信" style: UIBarButtonItemStylePlain target:self action:@selector(didClickForSendMsg:)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;   //发现此方法在这里设置并没有什么卵用, 这是因为 rootController 中设置随机色时已经加载了一遍视图, 那时样式还没生效
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationItem.rightBarButtonItem.enabled = NO;//然而也并不知道为什么设置在这里就有卵用
}

-(void) didClickForSendMsg: (UIBarButtonItem *)sender{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *ID = @"cell";
    /**
      *- (__kindof UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath 
      *使用这个方法来获取 cell 崩溃
     
     *  unable to dequeue a cell with identifier cell - must register a nib or a class for the identifier or connect a prototype cell in a storyboard'
     */
#warning forIndexPath
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    
    return cell;
}

#pragma mark - 代理方法

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ViewController_1 *vc_1 = [[ViewController_1 alloc]init];
    vc_1.title = @"测试1";
    /**
     *  当此控制器被 push 时, 所在的 tabbarController 的 tabbar 会自动隐藏
     */
//    vc_1.hidesBottomBarWhenPushed = YES;
#warning
    /**
     *  使用自定义的 navigationController 之后, 子控制器的 navigationController 变成了EVANavigationController
            > po self.navigationController
     */
    [self.navigationController pushViewController:vc_1 animated:YES];
}

@end
