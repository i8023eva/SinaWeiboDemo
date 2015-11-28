//
//  ViewController_1.m
//  新浪微博-beat
//
//  Created by lyh on 15/10/18.
//  Copyright © 2015年 lyh. All rights reserved.
//

#import "ViewController_1.h"
#import "ViewController_2.h"

@interface ViewController_1 ()

@end

@implementation ViewController_1





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

#warning 
    /**
     *  通过控制器的继承是可以实现少写代码, 但只限控制器父类相同, 不推荐这种方式
     
     * 需要让所有 push 进来的控制器, 导航栏左上角和右上角内容都一样
     * >拦截所有 push 进来的控制器
     * >自定义导航控制器, 重写 push 方法, 就可以得到传进来的控制器参数
     */
    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    ViewController_2 *vc_2 = [[ViewController_2 alloc]init];
    vc_2.title = @"测试2";
    [self.navigationController pushViewController:vc_2 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
