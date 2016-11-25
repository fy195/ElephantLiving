//
//  ElNormalListTableViewCell.h
//  ElephantLiving
//
//  Created by Omaiga on 16/10/20.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ElNormalListTableViewCell : UITableViewCell

@property (nonatomic, strong)UIImageView *headerImageView;

@property (nonatomic, strong)NSString *headerImage;

@property (nonatomic, strong)UILabel *nikenameLabel;

@property (nonatomic, copy)NSString *nikenameText;

@property (nonatomic, strong)UILabel *charmLabel;

@property (nonatomic, copy)NSString *charmText;

@property (nonatomic, strong)UILabel *listLabel;

@property (nonatomic, assign)NSInteger listNumber;

@property (nonatomic, assign)float cornerRadius;

@end
