//
//  DiscoverController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "DiscoverController.h"
#import "EVASearchBar.h"

@interface DiscoverController ()

@end

@implementation DiscoverController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    /**
     *  系统提供的 searchBar 限制太多, 会被图片撑开, 需要自定义
     
    UISearchBar *search = [[UISearchBar alloc]init];
    search.scopeBarBackgroundImage = [UIImage imageNamed:@"searchbar_textfield_background"];
     */
    UITextField *searchBar = [EVASearchBar searchBar];
    searchBar.size = CGSizeMake(345, 30);
    
    self.navigationItem.titleView = searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}



@end
