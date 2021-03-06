//
//  ElNormalListTableViewCell.m
//  ElephantLiving
//
//  Created by Omaiga on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElNormalListTableViewCell.h"
#import "ElMacro.h"

@implementation ElNormalListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        // 排名数字
        self.listLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.03, SCREEN_WIDTH * 0.06, SCREEN_WIDTH * 0.06, SCREEN_WIDTH * 0.1)];
        _listLabel.backgroundColor = [UIColor cyanColor];
        _listLabel.text = @"";
        _listLabel.textAlignment = NSTextAlignmentCenter;
        _listLabel.numberOfLines = 1;
        [self addSubview:_listLabel];
        
        
        // 排名头像
        self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.12, SCREEN_WIDTH * 0.02, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.17)];
//        _headerImageView.image = [UIImage imageNamed:@""];
        _headerImageView.layer.cornerRadius = 35;
        _headerImageView.backgroundColor = [UIColor yellowColor];
        _headerImageView.clipsToBounds = YES;
        [self addSubview:_headerImageView];
        
        
        // 昵称
        self.nikenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.31, SCREEN_WIDTH * 0.07, SCREEN_WIDTH * 0.3, SCREEN_WIDTH * 0.08)];
        _nikenameLabel.text = @"";
        _nikenameLabel.backgroundColor = [UIColor purpleColor];
        _nikenameLabel.numberOfLines = 1;
        _nikenameLabel.textColor = [UIColor cyanColor];
        [self addSubview:_nikenameLabel];
        
        
        // 魅力值
        self.charmLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH * 0.8, SCREEN_WIDTH * 0.07, SCREEN_WIDTH * 0.17, SCREEN_WIDTH * 0.08)];
        _charmLabel.backgroundColor = [UIColor orangeColor];
        _charmLabel.text = @"";
        _charmLabel.numberOfLines = 1;
        [self addSubview:_charmLabel];
        
        
    }
    return self;
}


#pragma mark - set传值
- (void)setHeaderImage:(UIImage *)headerImage {
    if (_headerImage != headerImage) {
        _headerImage = headerImage;
//        _headerImageView.image = headerImage;
    }
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
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
