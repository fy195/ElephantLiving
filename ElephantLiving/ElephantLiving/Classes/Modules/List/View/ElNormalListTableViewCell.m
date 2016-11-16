//
//  ElNormalListTableViewCell.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElNormalListTableViewCell.h"
#import "ElMacro.h"
#import "UIImageView+WebCache.h"

@implementation ElNormalListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // 排名数字
        self.listLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _listLabel.text = @"";
        _listLabel.textAlignment = NSTextAlignmentCenter;
        _listLabel.textColor = [UIColor colorWithRed:0.8706 green:0.3412 blue:0.4392 alpha:1.0];
        _listLabel.numberOfLines = 1;
        [self addSubview:_listLabel];
        
        
        // 排名头像
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _headerImageView.layer.cornerRadius = SCREEN_WIDTH * 0.17 / 2;
        _headerImageView.clipsToBounds = YES;
        _headerImageView.image = [UIImage imageNamed:@"大象头像"];
        [self addSubview:_headerImageView];
        
        
        // 昵称
        self.nikenameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nikenameLabel.text = @"";
        _nikenameLabel.numberOfLines = 1;
        [self addSubview:_nikenameLabel];
        
        
        // 魅力值
        self.charmLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _charmLabel.text = @"0";
        _charmLabel.textAlignment = NSTextAlignmentRight;
        _charmLabel.numberOfLines = 1;
        _charmLabel.textColor = [UIColor colorWithRed:0.9843 green:0.4196 blue:0.0 alpha:1.0];
        [self addSubview:_charmLabel];
        
        
    }
    return self;
}

#pragma mark - set传值
- (void)setHeaderImage:(NSString *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
    }
    
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:headerImage]];
    
}


- (void)setNikenameText:(NSString *)nikenameText {
    if (_nikenameText != nikenameText) {
        _nikenameText = nikenameText;
        _nikenameLabel.text = nikenameText;
    }
}


- (void)setCharmText:(NSString *)charmText {
    if (_charmText != charmText) {
        _charmText = charmText;
        _charmLabel.text = charmText;
    }
    _charmLabel.numberOfLines = 0;
    [_charmLabel sizeToFit];
    _charmLabel.font = [UIFont systemFontOfSize:15];
}
-(void)setListNumber:(NSInteger)listNumber {
    if (_listNumber != listNumber) {
        _listNumber = listNumber;
        _listLabel.text = [NSString stringWithFormat: @"%ld",listNumber];
    }

}

- (void)layoutSubviews {
    [super layoutSubviews];
    _listLabel.frame = CGRectMake(5, 0, self.width * 0.06, self.width * 0.1);
    _listLabel.center = CGPointMake(_listLabel.x + _listLabel.width / 2, self.height * 0.5);
    _headerImageView.frame = CGRectMake(_listLabel.x + _listLabel.width + 10, 0, self.width * 0.17, self.width * 0.17);
    _headerImageView.center = CGPointMake(_headerImageView.x + _headerImageView.width / 2, self.height * 0.5);
    _nikenameLabel.frame = CGRectMake(_headerImageView.x + _headerImageView.width + 10, 0, self.width * 0.35, self.width * 0.08);
    _nikenameLabel.center = CGPointMake(_nikenameLabel.x + _nikenameLabel.width / 2, self.height * 0.5);
    _charmLabel.frame = CGRectMake(self.bounds.size.width - self.bounds.size.width * 0.2 - 10, 0, self.width * 0.2, self.width * 0.08);
    _charmLabel.center = CGPointMake(_charmLabel.x + _charmLabel.width / 2, self.height * 0.5);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
