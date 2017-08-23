//
//  ActionSheet.h
//  ActionSheet
//
//  Created by Haven on 2017/6/15.
//  Copyright © 2017年 com.RuanZhiHongYi. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^selectBlock)(NSInteger index);
typedef void(^cancelBlock)();
@interface HavenActionSheet : UIView

// 初始化  传入自定义HeadView 
- (instancetype)initActionSheetWithHeadView: (UIView *)titleView optionsArray: (NSArray *)array cancelTitle: (NSString *)cancelTitle selectBlock : (selectBlock) selectBlock cancelBlock : (cancelBlock) cancelBlock;
@end
