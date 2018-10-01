//
//  CNRegion.h
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import <Foundation/Foundation.h>

@interface CNRegion : NSObject <NSCopying, NSCoding>

/// 行政区域代码
@property (nonatomic, copy) NSString *code;

/// 行政区域名称
@property (nonatomic, copy) NSString *name;

/// 是否为直辖市
@property (nonatomic, assign) BOOL isMunicipality;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
