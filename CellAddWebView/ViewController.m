//
//  ViewController.m
//  CellAddWebView
//
//  Created by iOSDeveloper on 2017/4/1.
//  Copyright © 2017年 iOSDeveloper. All rights reserved.
//

#import "ViewController.h"
#import "MyTableViewCell.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableDictionary *heightDic;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setupUI];
}

- (void)setupUI{
    self.heightDic = [[NSMutableDictionary alloc] init];
    
    // 注册加载完成高度的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(noti:) name:WEBVIEW_HEIGHT object:nil];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.tableView registerClass:[MyTableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
}

#pragma mark - table delegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.tag = indexPath.row;
    
    NSString *str = nil;
    if (indexPath.row == 0) {
        str = @"<p>人民网讯 综合美国媒体报道，美国联邦财政部国税局近日公布了去年美国公民放弃国籍人数，数字显示，共有5411名美国公民放弃美国国籍。这是连续四年刷新纪录。这份由联邦财政部国税局提供的弃美籍报告公布了每个季度放弃美国国籍的人数和个人姓名。2014年，&ldquo;肥咖法&rdquo;正式施行，公报显示当年放弃美籍人数激增到了3415人。<br/>（ 老任）(来源：人民网-国际频道)</p>";
    }else if(indexPath.row == 1){
        str = @"<p>人民网讯 综合美国媒体报道，公报显示当年放弃美籍人数激增到了3415人。<br/>（ 老任）(来源：人民网-国际频道)</p>";
    }else if(indexPath.row == 2){
        str = @"<p>人民网讯 综合美国媒体报道，公报显示当年放弃美籍人数激增到了3415人。这是连续四年刷新纪录。这份由联邦财政部国税局提供的弃美籍报告公布了每个季度放弃美国国籍的人数和个人姓名。<br/>（ 老任）(来源：人民网-国际频道)</p>";
    }
    
    // 赋值 把需要的html放里面就好了，不需要其他操作
    cell.contentStr = str;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return CGFLOAT_MIN;
}

//单元格的高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //初次加载高为0，收到通知以后刷新单元格，设置实际高
    CGFloat cellHeight = [[self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]] floatValue];
    NSLog(@"单元格的高:%f",cellHeight);
    return cellHeight;
}

#pragma mark - 通知
- (void)noti:(NSNotification *)sender
{
    MyTableViewCell *cell = [sender object];
    NSLog(@"单元格的tag值:%@",@(cell.tag));
    
    //避免进入死循环，循环刷新
    if (![self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.tag]]||[[self.heightDic objectForKey:[NSString stringWithFormat:@"%ld",(long)cell.tag]] floatValue] != cell.height)
    {
        //value:单元格的高,key:cell的tag值
        [self.heightDic setObject:[NSNumber numberWithFloat:cell.height] forKey:[NSString stringWithFormat:@"%ld",(long)cell.tag]];
        
        //刷新当前cell
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:cell.tag inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
