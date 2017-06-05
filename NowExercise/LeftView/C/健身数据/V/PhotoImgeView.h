//
//  PhotoImgeView.h
//  NowExercise
//
//  Created by Suger on 17/4/17.
//  Copyright © 2017年 Guodong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoImgeView : UIView<UIScrollViewDelegate>
{
    UIImageView * photoImageV;
    UIScrollView * scrollV;
}
- (void)setImage:(UIImage *)image;
@end
