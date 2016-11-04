//
//  ElCommentTableViewCell.m
//  ElephantLiving
//
//  Created by dllo on 16/11/4.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "ElCommentTableViewCell.h"

@interface ElCommentTableViewCell ()
@property (strong, nonatomic) UILabel *commentLabel;

@end

@implementation ElCommentTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:_commentLabel];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setComment:(NSString *)comment {
    if (_comment != comment) {
        _comment = comment;
    }
    _commentLabel.text = comment;
    _commentLabel.textColor = [UIColor colorWithWhite:0.900 alpha:1.000];
    NSRange range = [comment rangeOfString:@":"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",comment]];
    NSRange range1 = NSMakeRange(0, range.location + 1);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.000 green:0.559 blue:0.224 alpha:1.000] range:range1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range1];
    [_commentLabel setAttributedText:str];
    _commentLabel.font = [UIFont systemFontOfSize:14];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.numberOfLines = 0;
    [_commentLabel sizeToFit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _commentLabel.frame = CGRectMake(20, 0, self.bounds.size.width - 40, self.bounds.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
