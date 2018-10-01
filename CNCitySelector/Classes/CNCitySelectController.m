//
//  CNCitySelectController.m
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import "CNCitySelectController.h"
#import "CNNavigateCell.h"
#import "CNCityCell.h"
#import "CNConstants.h"

#import "GB2260.h"
#import "CNRegion.h"

/// 单元间距
#define CityCellMargin          2.0f
/// 行距
#define CityCellLineMargin      6.0f
/// section间距
#define CityCellSectionMargin   10.0f
/// 一行多少个cell
#define CityCellItemsPerRow     3
/// cell高度
#define CityCellHeight          36.0f

@interface CNCitySelectController () <UITableViewDelegate,
                                      UITableViewDataSource,
                                      UICollectionViewDataSource,
                                      UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSArray<CNRegion *> *navigateItems;

@property (nonatomic, copy) NSArray<CNRegion *> *cities;

@end

@implementation CNCitySelectController

@synthesize navigatorWidthFactor = _navigatorWidthFactor;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initViews];
    
    [self initData];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.navigateView selectRowAtIndexPath:index
                                   animated:YES
                             scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.navigateView didSelectRowAtIndexPath:index];
}

- (void)initViews {
    CGFloat width = [self getNavigatorWidthFactor] * SCREEN_WIDTH;
    CGRect frame = CGRectMake(0, 0, width, SCREEN_HEIGHT);
    _navigateView = [[UITableView alloc] initWithFrame:frame];
    _navigateView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _navigateView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self.view addSubview:_navigateView];
    
    CGFloat contentWidth = SCREEN_WIDTH - width;
    frame.size.width = contentWidth;
    frame.origin.x = width;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 3 Items per row
    layout.itemSize = CGSizeMake((contentWidth - 2 * CityCellSectionMargin - CityCellMargin * (CityCellItemsPerRow + 1)) / CityCellItemsPerRow, CityCellHeight);
    layout.minimumLineSpacing = CityCellLineMargin;
    layout.minimumInteritemSpacing = CityCellMargin;
    layout.sectionInset = UIEdgeInsetsMake(CityCellSectionMargin, CityCellSectionMargin, CityCellSectionMargin, CityCellSectionMargin);
    _contentView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    _contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_contentView];
    
    NSString *bundlePath = [[NSBundle bundleForClass:[CNCitySelectController class]]
                            pathForResource:@"CNCitySelector" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    
    [_navigateView registerNib:[UINib nibWithNibName:@"CNNavigateCell" bundle:bundle]
        forCellReuseIdentifier:@"CNNavigateCell"];
    
    [_contentView registerNib:[UINib nibWithNibName:@"CNCityCell" bundle:bundle]
   forCellWithReuseIdentifier:@"CNCityCell"];
    
    _navigateView.dataSource = self;
    _navigateView.delegate = self;
    
    _contentView.dataSource = self;
    _contentView.delegate = self;
}

- (void)initData {
    NSMutableArray<CNRegion *> *arr = [NSMutableArray array];
    
    BOOL showRecent = [_datasource respondsToSelector:@selector(recentCities)];
    BOOL showHot = [_datasource respondsToSelector:@selector(hotCities)];
    if (showHot) {
        CNRegion *hot = [CNRegion new];
        hot.name = @"热门城市";
        hot.code = @"hot";
        [arr addObject:hot];
    }
    
    if (showRecent) {
        CNRegion *hot = [CNRegion new];
        hot.name = @"最近访问";
        hot.code = @"recent";
        [arr addObject:hot];
    }
    
    CNRegion *region = [CNRegion new];
    region.name = @"直辖市";
    region.code = @"municipalities";
    [arr addObject:region];
    
    [arr addObjectsFromArray:[_datasource provinces]];
    _navigateItems = arr;
}

#pragma mark - table view

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_navigateItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNNavigateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CNNavigateCell"];
    CNRegion *region = [_navigateItems objectAtIndex:indexPath.row];
    
    if (_activeColor) {
        cell.primaryColor = _activeColor;
    }
    
    cell.titleLabel.text = region.name;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CNRegion *region = [_navigateItems objectAtIndex:indexPath.row];
    
    if ([region.code isEqualToString:@"hot"]) {
        _cities = [_datasource hotCities];
    } else if ([region.code isEqualToString:@"recent"]) {
        _cities = [_datasource recentCities];
    } else if ([region.code isEqualToString:@"municipalities"]) {
        _cities = [_datasource municipalities];
    } else {
        _cities = [_datasource citiesInProvinceCode:region.code];
    }
    [_contentView reloadData];
}

#pragma mark - collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_cities count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CNCityCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CNCityCell" forIndexPath:indexPath];
    CNRegion *region = [_cities objectAtIndex:indexPath.row];
    
    if (_activeColor) {
        cell.activeColor = _activeColor;
    }
    
    if (_inactiveColor) {
        cell.inactiveColor = _inactiveColor;
    }
    
    cell.titleLabel.text = region.name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CNRegion *region = [_cities objectAtIndex:indexPath.row];
    if (_delegate) {
        [_delegate didSelectRegion:region];
    }
}

#pragma mark - Private

- (void)setNavigatorWidthFactor:(CGFloat)navigatorWidthFactor {
    if (navigatorWidthFactor > 1 || navigatorWidthFactor < 0) return;
    
    _navigatorWidthFactor = navigatorWidthFactor;
}

- (CGFloat)getNavigatorWidthFactor {
    if (_navigatorWidthFactor == 0) {
        return 0.3;
    }
    
    return _navigatorWidthFactor;
}

@end
