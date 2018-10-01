//
//  CNCityDatabase.h
//  Pods
//
//  Created by Enix Yu on 2018/10/1.
//

#ifndef CNCityDatabase_h
#define CNCityDatabase_h

#import <Foundation/Foundation.h>

@class CNRegion;

@protocol CNCityDatabase <NSObject>

@required

/// 获取数据库单例
///
/// @return region database instance
+ (instancetype)shardInstance;

/// 获取省列表 (不包含直辖市)
///
/// @return 省份列表
- (NSArray<CNRegion *> *)provinces;

/// 获取直辖市
///
/// @return 直辖市列表
- (NSArray<CNRegion *> *)municipalities;

/// 获取某个省的所有城市
///
/// @param code 省份的代码
/// @return 城市列表
- (NSArray<CNRegion *> *)citiesInProvinceCode:(NSString *)code;

@optional

/// 最近访问的城市
///
/// @return 返回最近访问过的城市列表
- (NSArray<CNRegion *> *)recentCities;

/// 热门城市
///
/// @return 返回最近访问过的城市列表
- (NSArray<CNRegion *> *)hotCities;

/// 添加最近访问的城市
///
/// @param city 最近访问的城市
- (void)addRecentCity:(CNRegion *)city;

@end

#endif /* CNCityDatabase_h */
