//tableView right section view custom

#import "LPIndexSectionView.h"

@interface LPIndexSectionView ()
{
    CGFloat _sectionWidth;
    CGRect  _frame;
}

@end
@implementation LPIndexSectionView

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleHeight:(CGFloat)titleHeight
{
    self = [super initWithFrame:frame];
    if (self) {
        _titles = titles;
        _titleHeight = titleHeight;
        _sectionBackgroundColor = [UIColor whiteColor];
        _titleDefaultColor = [UIColor colorWithRed:4/255.0 green:178/255.0 blue:218/255.0 alpha:1.0];
        _selectTitleColor = [UIColor blackColor];
        _sectionWidth = frame.size.width;
        _frame = frame;
        _index = 0;
        _selectIndex = 0;
        self.backgroundColor = _sectionBackgroundColor;
        [self initialize];
        
        
    }
    return self;
}

- (void)initialize
{
    self.layer.cornerRadius = _sectionWidth/2;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = [UIColor colorWithRed:231/255.0 green:231/255.0 blue:231/255.0 alpha:1.0].CGColor;
    self.layer.borderWidth = 0.5;
    
    [self layoutTitlesView];
}



- (void)setTitles:(NSArray *)titles
{
    //当数组对象发生改变添加观察者监听
    _titles = titles;
}

- (void)updateUIForKeypath:(NSString *)keyPath {
    if ([keyPath isEqualToString:@"titles"]) {
        [self layoutTitlesView];
    }
}

- (NSArray *)observableKeypaths {
    return @[@"titles"];
}

- (void)layoutTitlesView
{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    __block NSInteger total = _titles.count;
    __weak typeof(self) weakSelf = self;
    //快速遍历
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [weakSelf layoutTitle:obj index:idx total:total];
    }];
}
- (void)layoutTitle:(id)obj index:(NSUInteger)index total:(NSInteger)total
{
    UILabel *titleLable = [self labelWithTitle:obj index:index total:total];
    [self addSubview:titleLable];
    
}
- (UILabel *)labelWithTitle:(NSString *)title index:(NSUInteger)index total:(NSInteger)total
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.tag = index;
    titleLabel.font = [UIFont systemFontOfSize:15.0];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = _titleDefaultColor;
    titleLabel.text = title;
    //NSLog(@"%@+index %ld",title,index);
    titleLabel.frame = [self frameForIndex:index total:total];
    return titleLabel;
}
- (CGRect)frameForIndex:(NSUInteger)index total:(NSInteger)total
{
    CGFloat totalHeight = total*_titleHeight;
    CGFloat startY = (_frame.size.height - totalHeight)/2;
    CGRect frame = CGRectZero;
    frame.size.width = _frame.size.width;
    frame.size.height = _titleHeight;
    frame.origin.x = 0;
    frame.origin.y = startY +_titleHeight*index;
    return frame;
}

#pragma mark - Touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self selectTitleWithPoint:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    [self selectTitleWithPoint:point];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{

}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

- (void)selectTitleWithPoint:(CGPoint)point
{
    
    __block NSInteger total = self.titles.count;
    [self.titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGRect frame = [self frameForIndex:idx total:total];
        if (CGRectContainsPoint(frame, point)) {
            _selectIndex = idx;
            _index = _selectIndex;
            //执行点击事件,同时停止遍历
            if (_titleHandleCallBack) {
                _titleHandleCallBack(obj,idx);
            }
            *stop = YES;
        }
    }];
    [self refreshUI];
}
- (void)handleSelectTitle:(LPSectionTitleHandleCallBack)block
{
    _titleHandleCallBack = block;
}

- (void)setSectionBackgroundColor:(UIColor *)sectionBackgroundColor
{
    _sectionBackgroundColor = sectionBackgroundColor;
    self.backgroundColor = _sectionBackgroundColor;
}
- (void)refreshUI
{
    NSInteger i = 0;
    for (UILabel *label in self.subviews) {
        if (i == _selectIndex) {
            label.textColor = _selectTitleColor;
        }else{
            label.textColor = _titleDefaultColor;
        }
        i++;
    }
}
- (void)setSelectTitleColor:(UIColor *)selectTitleColor
{
    _selectTitleColor = selectTitleColor;
    [self refreshUI];
}
- (void)setTitleDefaultColor:(UIColor *)titleDefaultColor
{
    _titleDefaultColor = titleDefaultColor;
    for (UILabel *lable in self.subviews) {
        [lable.textColor setValue:_titleDefaultColor forKey:@"color"];
    }
}
@end
