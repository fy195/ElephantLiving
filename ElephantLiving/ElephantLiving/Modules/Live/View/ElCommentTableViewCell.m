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
        self.backgroundColor = [UIColor clearColor];
        self.commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 70, self.height)];
        [self addSubview:_commentLabel];
        _commentLabel.backgroundColor = [UIColor clearColor];
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
    _commentLabel.textColor = [UIColor whiteColor];
    NSRange range = [comment rangeOfString:@":"];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",comment]];
    NSRange range1 = NSMakeRange(0, range.location + 1);
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:1.000 green:0.559 blue:0.224 alpha:1.000] range:range1];
    [str addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range1];
    [_commentLabel setAttributedText:str];
    _commentLabel.font = [UIFont systemFontOfSize:13];
    _commentLabel.numberOfLines = 0;
    [_commentLabel sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
