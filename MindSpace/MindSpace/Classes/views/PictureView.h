//
//  PictureView.h
//  MindSpace
//
//  Created by lanou3g on 16/3/3.
//  Copyright © 2016年 侯彦栋，李金岩，徐未钱，姚行. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^click)(int i);

@interface PictureView : UIView

// imageNames 和images 二选一
//图片名数组
@property(nonatomic,weak)NSArray *imageNames;
//图片数组
@property(nonatomic,weak)NSArray *images;
//回调单击方法
@property(nonatomic,strong)click click;


@end
