//
//  GB2260.m
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import "GB2260.h"
#import "CNRegion.h"

#define Revision    @"201607"
#define RecentKey   @"CNCitySelector.recent"
#define MaxRecent   10

@interface GB2260 ()

@property (nonatomic, copy) NSArray* db;

@property (nonatomic, strong) NSMutableArray* recent;

@end

@implementation GB2260

+ (instancetype)shardInstance {
    static GB2260 *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [GB2260 new];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSBundle *bundle = [self currentBundle];
        NSString *path = [bundle pathForResource:Revision ofType:@"plist"];
        NSArray *items = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *item in items) {
            CNRegion *region = [[CNRegion alloc] initWithDict:item];
            [arr addObject:region];
        }
        _db = arr;
        
        [self initRecent];
    }
    return self;
}

- (void)initRecent {
    NSUserDefaults *userDft = [NSUserDefaults standardUserDefaults];
    NSArray<NSString *> *recentCodes = [[userDft objectForKey:RecentKey] mutableCopy];
    
    _recent = [NSMutableArray array];
    if (recentCodes == nil) {
        return;
    }
    
    for (NSString *code in recentCodes) {
        [_recent addObject:[self regionForCode:code]];
    }
}

- (NSBundle *)currentBundle {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]]
                            pathForResource:@"CNCitySelector" ofType:@"bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    return bundle;
}

/// 获取省列表 (不包含直辖市)
- (NSArray<CNRegion *> *)provinces {
    NSMutableArray *result = [NSMutableArray array];
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:@"\\d{2}0000$"
                                                                            options:kNilOptions
                                                                              error:nil];
    for (CNRegion *region in _db) {
        NSArray *matches = [regexp matchesInString:region.code
                                           options:kNilOptions
                                             range:NSMakeRange(0, region.code.length)];
        if (matches.count == 0 || region.isMunicipality) {
            continue;
        }
        
        [result addObject:region];
    }
    
    return result;
}

/// 获取直辖市
- (NSArray *)municipalities {
    NSMutableArray *result = [NSMutableArray array];
    for (CNRegion *region in _db) {
        if (region.isMunicipality) {
            [result addObject:region];
        }
    }
    
    return result;
}

/// 获取某个省的所有城市
- (NSArray *)citiesInProvinceCode:(NSString *)code {
    if (code.length != 6) return nil;
    
    NSMutableArray *result = [NSMutableArray array];
    NSString *prefix = [code substringWithRange:NSMakeRange(0, 2)];
    NSString *regex = [NSString stringWithFormat:@"^%@\\d{4}$", prefix];
    NSRegularExpression *regexp = [NSRegularExpression regularExpressionWithPattern:regex
                                                                            options:kNilOptions
                                                                              error:nil];
    for (CNRegion *region in _db) {
        if ([region.code isEqualToString:code]) {
            continue;
        }
        
        NSArray *matches = [regexp matchesInString:region.code
                                           options:kNilOptions
                                             range:NSMakeRange(0, region.code.length)];
        if (matches.count == 0) {
            continue;
        }
        
        [result addObject:region];
    }
    
    return result;
}

/// 最近访问的城市
- (NSArray<CNRegion *> *)recentCities {
    return _recent;
}

/// 热门城市
- (NSArray<CNRegion *> *)hotCities {
    NSBundle *bundle = [self currentBundle];
    NSString *path = [bundle pathForResource:@"hot" ofType:@"plist"];
    NSArray<NSString *> *hot = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *code in hot) {
        [arr addObject:[self regionForCode:code]];
    }
    return arr;
}

- (void)addRecentCity:(CNRegion *)city {
    if ([_recent containsObject:city]) {
        return;
    }
    
    [_recent insertObject:city atIndex:0];
    if (_recent.count > MaxRecent) {
        [_recent removeObjectsInRange:NSMakeRange(MaxRecent, _recent.count - MaxRecent)];
    }
    [self saveRecent];
}

- (void)saveRecent {
    NSMutableArray *arr = [NSMutableArray array];
    for (CNRegion *item in _recent) {
        [arr addObject:item.code];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:RecentKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (CNRegion *)regionForCode:(NSString *)code {
    for (CNRegion *item in _db) {
        if ([item.code isEqualToString:code]) {
            return item;
        }
    }
    
    return nil;
}

@end
