//
//  ViewController.m
//  LPCustomTableViewSectionIndexView
//
//  Created by QFWangLP on 16/5/30.
//  Copyright © 2016年 qfangwanghk. All rights reserved.
//

#import "ViewController.h"

#import "LPIndexSectionView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    LPIndexSectionView *_sectionView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *dataDic;
@property (nonatomic, strong) NSMutableArray *groupArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _dataDic = [NSMutableDictionary dictionary];
    _groupArray = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L"]];
    
    for (NSInteger i = 0; i <_groupArray.count; i++ ) {
        NSMutableArray *data = [NSMutableArray array];
        for (NSInteger j = 0; j<4; j++) {
            [data addObject:[NSString stringWithFormat:@"%ld+%@",j,_groupArray[i]]];
        }
        [_dataDic setObject:data forKey:_groupArray[i]];
    }
    [self.tableView reloadData];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self initlizerIndexView];
    
}

- (void)initlizerIndexView
{
    _sectionView = [[LPIndexSectionView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 35, 64, 30, self.view.frame.size.height - 124) titles:self.groupArray titleHeight:30];
    [self.view addSubview:_sectionView];
    [_sectionView handleSelectTitle:^(NSString *title, NSInteger index) {
        //NSLog(@"%@++++%ld",title,index);
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:YES];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _groupArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *data = [_dataDic objectForKey:_groupArray[section]];
    return  data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *data = [_dataDic objectForKey:_groupArray[indexPath.section]];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.text = data[indexPath.row];
    return cell;
}
@end
