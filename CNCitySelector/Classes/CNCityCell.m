//
//  CNCityCell.m
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import "CNCityCell.h"
#import "CNConstants.h"


@interface CNCityCell ()

@end

@implementation CNCityCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self setCellActive:NO];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setCellActive:YES];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setCellActive:NO];
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self setCellActive:NO];
    [super touchesCancelled:touches withEvent:event];
}

/// Set cell active style
- (void)setCellActive:(BOOL)active {
    CALayer *layer = _wrapperView.layer;
    layer.borderWidth = 1.0f;
    layer.cornerRadius = 2.0f;
    
    if (active) {
        layer.borderColor = [self getActiveColor].CGColor;
        _titleLabel.textColor = [self getActiveColor];
        layer.backgroundColor = [[self getActiveColor] colorWithAlphaComponent:0.1].CGColor;
    } else {
        layer.borderColor = [self getInActiveColor].CGColor;
        _titleLabel.textColor = [UIColor darkGrayColor];
        layer.backgroundColor = [UIColor whiteColor].CGColor;
    }
}

- (UIColor *)getActiveColor {
    if (_activeColor == nil) {
        return DefaultPrimaryColor;
    }
    
    return _activeColor;
}

- (UIColor *)getInActiveColor {
    if (_inactiveColor == nil) {
        return [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    }
    
    return _inactiveColor;
}

@end
