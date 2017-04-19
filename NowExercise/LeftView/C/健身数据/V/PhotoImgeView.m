//
//  PhotoImgeView.m
//  NowExercise
//
//  Created by Suger on 17/4/17.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import "PhotoImgeView.h"



@implementation PhotoImgeView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        scrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        
        scrollV.maximumZoomScale = 2.0;
        scrollV.minimumZoomScale = 1.0;
        //scrollV.bounces = NO;
        scrollV.contentSize = CGSizeMake(SCREEN_W, SCREEN_H);
        //scrollV.indicatorStyle = UIScrollViewIndicatorStyleBlack;
        scrollV.bouncesZoom = NO;
        scrollV.delegate = self;
        [self addSubview:scrollV];
        
        photoImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H)];
        photoImageV.backgroundColor = [UIColor blackColor];
        photoImageV.contentMode = UIViewContentModeCenter;
        [scrollV addSubview:photoImageV];
        
        NSLog(@"位置:::::************%@",photoImageV);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setImage:(UIImage *)image{
    photoImageV.image = image;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return photoImageV;
}


@end
