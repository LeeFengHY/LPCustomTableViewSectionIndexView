# 一个简易的自定义tableView section index view

>使用方法

     _sectionView = [[LPIndexSectionView alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 35, 64, 30, self.view.frame.size.height - 124) titles:self.groupArray titleHeight:30];
     [self.view addSubview:_sectionView];
        [_sectionView handleSelectTitle:^(NSString *title, NSInteger index) {
    
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:YES];
        }];


>效果图
![image]()
