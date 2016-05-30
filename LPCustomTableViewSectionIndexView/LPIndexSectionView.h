//tableView right section view custom

#import <UIKit/UIKit.h>

typedef void(^LPSectionTitleHandleCallBack)(NSString *title, NSInteger index);
@interface LPIndexSectionView : UIView
{
    @private
    CGFloat _titleHeight;
}
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) UIColor *sectionBackgroundColor;
@property (nonatomic, strong) UIColor *selectTitleColor;
@property (nonatomic, strong) UIColor *titleDefaultColor;
@property (nonatomic, copy)   LPSectionTitleHandleCallBack titleHandleCallBack;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, copy)   NSString *title;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles titleHeight:(CGFloat)titleHeight;
- (void)handleSelectTitle:(LPSectionTitleHandleCallBack)block;

@end
