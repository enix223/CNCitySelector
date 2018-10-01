//
//  CNNavigateCell.m
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import "CNNavigateCell.h"
#import "CNConstants.h"

@interface CNNavigateCell ()

@property (nonatomic, strong) CAShapeLayer *rightBarLayer;

@end

@implementation CNNavigateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.backgroundColor = [self defaultColor];
    self.contentView.backgroundColor = [self defaultColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _rightBarLayer = [CAShapeLayer layer];
    _rightBarLayer.hidden = YES;
    _rightBarLayer.backgroundColor = [self primaryColor].CGColor;
    [self.contentView.layer addSublayer:_rightBarLayer];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat height = CGRectGetHeight(self.bounds) * 0.4;
    _rightBarLayer.frame = CGRectMake(width - 3, (CGRectGetHeight(self.bounds) - height) / 2, 3, height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        _rightBarLayer.hidden = NO;
        _titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightHeavy];
    } else {
        _rightBarLayer.hidden = YES;
        _titleLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular];
    }
}

- (UIColor *)defaultColor {
    return [UIColor colorWithRed:0.94
                           green:0.94
                            blue:0.94
                           alpha:1];
}

- (UIColor *)primaryColor {
    if (_primaryColor == nil) {
        return DefaultPrimaryColor;
    }
    
    return _primaryColor;
}

@end
