//
//  HomeTableViewCell.m
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"

@implementation HomeTableViewCell


- (void)setModel:(HomeModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.detailLabel.text = model.excerpt;
    self.authorLabel.text = model.author;
    self.commentLabel.text = model.comment;
    self.likeLabel.text = model.good;
    self.readCountLabel.text = model.view;
    [self.photoView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
}




- (IBAction)commentAction:(UIButton *)sender {
    
}

- (IBAction)likeAction:(UIButton *)sender {
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
