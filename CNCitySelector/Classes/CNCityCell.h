//
//  CNCityCell.h
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import <UIKit/UIKit.h>

@interface CNCityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIView *wrapperView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong, getter=getActiveColor) UIColor *activeColor;
@property (nonatomic, strong, getter=getInActiveColor) UIColor *inactiveColor;

@end
