//
//  TableViewCell.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "TableViewCell.h"
#import "UIImageView+WebCache.h"
@implementation TableViewCell

- (void)setModel:(WordModel *)model
{
    self.TitleLabel.text = model.title;
    self.nameLabel.text = model.author;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
