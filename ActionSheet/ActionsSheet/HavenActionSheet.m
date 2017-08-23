//
//  ActionSheet.m
//  ActionSheet
//
//  Created by Haven on 2017/6/15.
//  Copyright © 2017年 com.RuanZhiHongYi. All rights reserved.
//

#import "HavenActionSheet.h"

#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define magrin 10
#define rowHeight 44

@interface HavenActionSheet()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *backgroudView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, copy) NSString *cancelTitle;

@property (nonatomic, strong)  selectBlock selectBlock;
@property (nonatomic, strong)  cancelBlock cancelBlock;
@end


@implementation HavenActionSheet

// 初始化
- (instancetype)initActionSheetWithHeadView: (UIView *)titleView optionsArray: (NSArray *)array cancelTitle: (NSString *)cancelTitle selectBlock : (selectBlock) selectBlock cancelBlock : (cancelBlock) cancelBlock
{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        _headView = titleView;
        _dataArray = array;
        _cancelTitle = cancelTitle;
        _selectBlock = selectBlock;
        _cancelBlock = cancelBlock;
        [self createUI];
    }
    return self;
}

// 创建backgroudView tableView
- (void)createUI
{
    [self addSubview: self.backgroudView];
    
    [self addSubview: self.tableView];
}

- (UIView *)backgroudView
{
    if (_backgroudView == nil) {
        _backgroudView = [[UIView alloc] initWithFrame: self.bounds];
        _backgroudView.backgroundColor = [UIColor grayColor];
        _backgroudView.alpha = 0.5;
    }
    return _backgroudView;
}

- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame: CGRectZero style: UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.layer.cornerRadius = 10.0;
        _tableView.clipsToBounds = YES;
        _tableView.bounces = NO;
        _tableView.tableHeaderView = _headView;
        _tableView.backgroundColor = [UIColor clearColor];
//        _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    }
    return _tableView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self show];
}

#pragma mark - 显示 / 隐藏
- (void)show
{
    self.tableView.frame = CGRectMake(magrin, screenHeight, screenWidth - magrin * 2, (self.dataArray.count + 1) * rowHeight + self.headView.bounds.size.height + magrin * 2);
    [UIView animateWithDuration: 0.5 animations:^{
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.origin.y = screenHeight - self.tableView.bounds.size.height;
        self.tableView.frame = tableViewFrame;
    }];
    
    
}

- (void)dismiss
{
    [UIView animateWithDuration: 0.5 animations:^{
        CGRect tableViewFrame = self.tableView.frame;
        tableViewFrame.origin.y = screenHeight;
        self.tableView.frame = tableViewFrame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


#pragma mark - TableViewDelegate/UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.dataArray.count;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: ID];
    }
  
    if (indexPath.section == 0) {
        if (indexPath.row == self.dataArray.count - 1) {
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect: CGRectMake(0, 0, screenWidth - (magrin * 2), rowHeight) byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii: CGSizeMake(10, 10)];
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            layer.frame = cell.contentView.bounds;
            layer.path = path.CGPath;
            cell.layer.mask = layer;
        }
        cell.textLabel.text = self.dataArray[indexPath.row];
    }else if (indexPath.section == 1){
        cell.textLabel.text = self.cancelTitle;
        cell.layer.cornerRadius = 10.0;
        
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (self.selectBlock) {
            self.selectBlock(indexPath.row);
        }
    }else{
        if (self.cancelBlock) {
            self.cancelBlock();
        }
    }
    [self dismiss];
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowHeight;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return magrin;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, screenWidth - magrin * 2, magrin)];
    footerView.backgroundColor = [UIColor clearColor];
    return footerView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}






@end
