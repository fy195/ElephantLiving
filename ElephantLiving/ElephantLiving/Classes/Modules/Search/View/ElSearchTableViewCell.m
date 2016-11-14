//
//  ElSearchTableViewCell.m
//  ElephantLiving
//
//  Created by dllo on 16/11/8.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElSearchTableViewCell.h"
#import "UIImageView+WebCache.h"

@interface ElSearchTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;

@end

@implementation ElSearchTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setHeaderImage:(NSString *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
        [_headerImageView sd_setImageWithURL:[NSURL URLWithString:headerImage]];
    }
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
        _nameLabel.text = name;
        _nameLabel.numberOfLines = 0;
        [_nameLabel sizeToFit];
    }
}

- (void)setLevel:(NSNumber *)level {
    if (_level != level) {
        _level = level;
    }
    _levelLabel.text = [NSString stringWithFormat:@"Level %@",level];
    _levelLabel.textColor = [UIColor colorWithRed:1.0 green:0.503 blue:0.0028 alpha:1.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
