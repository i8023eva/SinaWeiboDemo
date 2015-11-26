//
//  EVANavigationController.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "EVANavigationController.h"

@interface EVANavigationController ()

@end

@implementation EVANavigationController

+(void)initialize{//第一次使用时调用
    /**
     *  设置整个项目所有 barButtonItem的样式
     */
    UIBarButtonItem *items = [UIBarButtonItem appearance];
    /**
     *  正常状态下的样式
     */
    [items setTitleTextAttributes:@{NSForegroundColorAttributeName: rgbColor(255, 109, 0),  
                                    NSFontAttributeName: [UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    /**
     *  不能被选中的样式
     */
    [items setTitleTextAttributes:@{NSForegroundColorAttributeName: rgbColor(222, 222, 222)} forState:UIControlStateDisabled];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    /**
     *  第一个 push 进来的是4个根控制器, 如果数量 > 1, 那就说明不是最上层的四个 NavigationController
     
     * 当把 super 放在后面时, 执行第一次的时候 push 的数量是0, 此时应判断 > 0
            > 执行完 super 之后, count = 1 > 0, 开始执行 if
     */
    if (self.viewControllers.count > 0) {
        
        viewController.hidesBottomBarWhenPushed = YES;
        
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Action:@selector(didClickForBack:) image:@"navigationbar_back" highlightedImage:@"navigationbar_back_highlighted"];

        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self Action:@selector(didClickForMore:) image:@"navigationbar_more" highlightedImage:@"navigationbar_more_highlighted"];
    }
    [super pushViewController:viewController animated:animated];
}



-(void) didClickForBack:(UIButton *) sender{
    /**
     *  这里也不是 self.navigationController
     */
    [self popViewControllerAnimated:YES];
}

-(void) didClickForMore:(UIButton *) sender{
    
    [self popToRootViewControllerAnimated:YES];
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
