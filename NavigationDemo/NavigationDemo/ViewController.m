//
//  ViewController.m
//  NavigationDemo
//
//  Created by daiyunpeng on 2017/6/1.
//  Copyright © 2017年 Elegant Team. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
#define SCREEN_W [UIScreen mainScreen].bounds.size.width
#define SCREEN_H [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置导航栏透明，但是BarButtonItem正常显示
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    //设置导航栏背景色
    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_W / 3, 0, SCREEN_W/3, 30)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"导航栏";
    self.navigationItem.titleView = titleLabel;
    //去掉导航栏下的一条线 shadow
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellID"];
    //监听scrollView的offset可以渐变导航栏的颜色。
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]
        ) {
//        NSLog(@"%f",self.tableView.contentSize.height);
//        NSLog(@"%@",[change valueForKey:NSKeyValueChangeNewKey]);
        CGPoint point = [[change valueForKey:NSKeyValueChangeNewKey] CGPointValue];
        [[self.navigationController.navigationBar subviews] objectAtIndex:0].alpha = 1-(point.y / (self.tableView.contentSize.height - SCREEN_H));
        
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.textLabel.text = @"导航栏";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondViewController *sec = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:sec animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

@end
































