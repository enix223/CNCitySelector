//
//  CNCurrentCityCell.h
//  CNCitySelector
//
//  Created by Enix Yu on 2018/10/1.
//

#import <UIKit/UIKit.h>

@interface CNCurrentCityCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *titleButton;

@property (nonatomic, strong, getter=getPrimaryColor) UIColor *primaryColor;

@end
