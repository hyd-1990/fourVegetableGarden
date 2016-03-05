//
//  TableViewCell.h
//  MindSpace
//
//  Created by lanou3g on 16/3/1.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WordModel.h"
@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *image;

@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (nonatomic, strong)WordModel *model;

@end
