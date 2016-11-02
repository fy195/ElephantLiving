//
//  ElNewCollectionViewCell.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElNewCollectionViewCell.h"

@interface ElNewCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNewLabel;
@end

@implementation ElNewCollectionViewCell

- (void)setIconImage:(UIImage *)iconImage {
    if (_iconImage != iconImage) {
        _iconImage = iconImage;
    }
    _iconImageView.image = iconImage;
    _userNewLabel.layer.borderWidth = 2.0f;
    _userNewLabel.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setLocation:(NSString *)location {
    if (_location != location) {
        _location = location;
    }
    _locationLabel.text = location;
    [_locationLabel sizeToFit];
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
    }
    _nameLabel.text = name;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

@end
