//
//  CNCitySelectController.h
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import <UIKit/UIKit.h>
#import "CNCityDatabase.h"
#import "CNCitySelectDelegate.h"

@interface CNCitySelectController : UIViewController

/// 侧方栏
@property (strong, nonatomic) UITableView *navigateView;

/// 内容栏
@property (strong, nonatomic) UICollectionView *contentView;

/// 侧方栏长度比例 0 ~ 1.0
@property (nonatomic, assign, getter=getNavigatorWidthFactor) CGFloat navigatorWidthFactor;

/// 城市高亮颜色
@property (nonatomic, strong) UIColor *activeColor;

/// 城市非高亮颜色
@property (nonatomic, strong) UIColor *inactiveColor;

/// 城市数据源
@property (nonatomic, weak) id<CNCityDatabase> datasource;

/// 城市选择delegate
@property (nonatomic, weak) id<CNCitySelectDelegate> delegate;

@end
