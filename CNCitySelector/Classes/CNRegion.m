//
//  CNRegion.m
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import "CNRegion.h"

@implementation CNRegion

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        _code = [dict objectForKey:@"code"];
        _name = [dict objectForKey:@"name"];
        _isMunicipality = [[dict objectForKey:@"municipality"] boolValue];
    }
    return self;
}

- (BOOL)isEqual:(CNRegion *)object {
    return [self.code isEqual:object.code];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeBool:_isMunicipality forKey:@"isMunicipality"];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        _code = [aDecoder decodeObjectForKey:@"code"];
        _name = [aDecoder decodeObjectForKey:@"name"];
        _isMunicipality = [aDecoder decodeBoolForKey:@"isMunicipality"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    CNRegion *newInstance = [CNRegion new];
    newInstance.code = _code;
    newInstance.name = _name;
    newInstance.isMunicipality = _isMunicipality;
    return newInstance;
}

@end
