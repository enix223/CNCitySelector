//
//  CNCurrentCityCell.m
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import "CNCurrentCityCell.h"
#import "CNConstants.h"

@implementation CNCurrentCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_titleButton setTintColor:[self getPrimaryColor]];
}

- (UIColor *)getPrimaryColor {
    if (_primaryColor == nil) {
        return DefaultPrimaryColor;
    }
    
    return _primaryColor;
}

@end
