//
//  ElPersonCharmTableViewCell.m
//  ElephantLiving
//
//  Created by dllo on 16/10/21.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElPersonCharmTableViewCell.h"

@interface ElPersonCharmTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;

@end

@implementation ElPersonCharmTableViewCell

- (void)setTitle:(NSString *)title {
    if (_title != title) {
        _title = title;
    }
    _titleLabel.text = title;
}

- (void)setCount:(NSString *)count {
    if (_count != count) {
        _count = count;
    }
    _numberLabel.text = count;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
