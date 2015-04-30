//
//  CardTableViewCell.m
//  VurbProj
//
//  Created by Richard Zhang on 4/29/15.
//  Copyright (c) 2015 Richard Zhang. All rights reserved.
//

#import "CardTableViewCell.h"

@implementation CardTableViewCell



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier Height: (CGFloat) rowHeight;
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        CGFloat height = rowHeight;
        CGFloat width = CGRectGetWidth(self.contentView.frame);
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, height/3.0f)];
        [self.contentView addSubview:_titleLabel];
        
        _thumbNail = [[UIImageView alloc] initWithFrame:CGRectMake(0, height/3.0f, height/3.0f, height/3.0f)];
        [self.contentView addSubview:_thumbNail];
        
        _customView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_thumbNail.frame), width, height/3.0f)];
        //_customView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:_customView];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for t he selected state
}

@end
