//
//  ViewController.m
//  ActionSheet
//
//  Created by Haven on 2017/6/15.
//  Copyright © 2017年 com.RuanZhiHongYi. All rights reserved.
//

#import "ViewController.h"
#import "HavenActionSheet.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *textLable;
@property (nonatomic, strong) UIView *headView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}


- (IBAction)selectButtonClick {
    
    
    
    HavenActionSheet *actionSheet = [[HavenActionSheet alloc] initActionSheetWithHeadView: self.headView optionsArray: @[@"火影", @"海贼", @"死神"] cancelTitle: @"取消" selectBlock:^(NSInteger index) {
        NSLog(@"%ld", index);
    } cancelBlock:^{
        NSLog(@"取消");
    }];
    [self.view addSubview: actionSheet];
}

- (UIView*)headView {
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width - 20, 100)];
        _headView.backgroundColor = [UIColor whiteColor];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.view.bounds.size.width - 20, 30)];
        titleLabel.text = @"请选择";
        titleLabel.font = [UIFont systemFontOfSize:15.0];
        titleLabel.textColor = [UIColor colorWithRed:73/255.0 green:75/255.0 blue:90/255.0 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_headView addSubview:titleLabel];
        
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 30)];
        descLabel.text = @"记住我的选择，不再提示";
        descLabel.textAlignment = NSTextAlignmentCenter;
        descLabel.center = CGPointMake(_headView.center.x, 55);
        [_headView addSubview:descLabel];
        
        UIButton *selectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedButton.frame = CGRectMake(CGRectGetMinX(descLabel.frame) - 30, 45, 20, 20);
        [selectedButton setImage:[UIImage imageNamed:@"unselected"] forState:UIControlStateNormal];
        [selectedButton setImage:[UIImage imageNamed:@"selected"] forState:UIControlStateSelected];
//        [selectedButton addTarget:self action:@selector(selectedClick:) forControlEvents:UIControlEventTouchUpInside];
        [_headView addSubview:selectedButton];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 99.5, self.view.bounds.size.width - 20, .5)];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1];
        [_headView addSubview:line];
    }
    return _headView;
}

@end
