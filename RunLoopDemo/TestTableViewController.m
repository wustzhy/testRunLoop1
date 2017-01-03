//
//  TestTableViewController.m
//  RunLoopDemo
//
//  Created by 赵洋 on 17/1/3.
//  Copyright © 2017年 Chun Tips. All rights reserved.
//

#import "TestTableViewController.h"

@interface TestTableViewController ()

@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic) NSInteger count;
@property (nonatomic, strong) NSTimer *testTimer;

@end

@implementation TestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.count = 0;
    
    self.testLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 100, 100, 50)];
    [self.view addSubview:self.testLabel];
    
    /// 当tablview 滚动时，label停止更新 scheduledTimer 默认运行在Default Mode
//    self.testTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self        selector:@selector(updateTestLabel) userInfo:nil repeats:YES];
    /// ---------   timer 添加至 commonModes， 当tableview滑动时 timer继续运行
    self.testTimer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(updateTestLabel) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.testTimer forMode:NSRunLoopCommonModes];
}

- (void)updateTestLabel
{
    self.count ++;
    self.testLabel.text = [NSString stringWithFormat:@"%ld", self.count];
    if (self.count == 100) {
        [self.testTimer invalidate];
        self.testTimer = nil;
    }
}

//  注意 --- 如果不在viewDidDisappear 中 invalidate timer 那么 dealloc不会走！
-(void)dealloc{
    NSLog(@"%s",__func__);
}

-(void)viewDidDisappear:(BOOL)animated{

    [super viewDidDisappear:animated];
    //  ------上句👆、 下句👇 顺序可以调换
    if(self.testTimer){
        [self.testTimer invalidate];
        self.testTimer = nil;
    }
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
