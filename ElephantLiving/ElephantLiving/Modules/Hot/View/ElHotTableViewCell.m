//
//  ElHotTableViewCell.m
//  ElephantLiving
//
//  Created by dllo on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElHotTableViewCell.h"

@interface ElHotTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *viewCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *liveLabel;

@end

@implementation ElHotTableViewCell

- (void)setIconImage:(UIImage *)iconImage {
    if (_iconImage != iconImage) {
        _iconImage = iconImage;
    }
    _iconImageView.image = iconImage;
}

- (void)setName:(NSString *)name {
    if (_name != name) {
        _name = name;
    }
    _nameLabel.text = name;
}

- (void)setLocation:(NSString *)location {
    if (_location != location) {
        _location = location;
    }
    _locationLabel.text = location;
}

- (void)setViewCount:(NSInteger)viewCount {
    if (_viewCount != viewCount) {
        _viewCount = viewCount;
    }
    _viewCountLabel.text = [NSString stringWithFormat:@"%ld人在看",_viewCount];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld人在看",_viewCount]];
    NSRange range = NSMakeRange([[str string] rangeOfString:[NSString stringWithFormat:@"%ld", _viewCount]].location, [[str string] rangeOfString:[NSString stringWithFormat:@"%ld", _viewCount]].length);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.000 green:0.485 blue:0.598 alpha:1.000] range:range];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
    [_viewCountLabel setAttributedText:str];
    _liveLabel.layer.borderWidth = 2.0f;
    _liveLabel.layer.borderColor = [UIColor whiteColor].CGColor;
}

- (void)setCoverImage:(UIImage *)coverImage {
    if (_coverImage != coverImage) {
        _coverImage = coverImage;
    }
    _coverImageView.image = coverImage;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
