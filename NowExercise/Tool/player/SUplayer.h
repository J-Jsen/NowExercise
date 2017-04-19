//
//  SUplayer.h
//  SUPlayer
//
//  Created by mac on 17/3/14.
//  Copyright © 2017年 Suger. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@protocol SUplayerDelegate <NSObject>

- (void)ShowAddOrderView;
- (void)Back;
@end

@interface SUplayer : UIView
@property (nonatomic , weak) id<SUplayerDelegate> delegate;

/**
 *  AVPlayer播放器
 */
@property (nonatomic, strong) AVPlayer *player;
/**
 *  播放状态，YES为正在播放，NO为暂停
 */
@property (nonatomic, assign) BOOL isPlaying;
/**
 *  传入视频地址
 *
 *   string 视频url
 */
- (void)updatePlayerWith:(NSURL *)url;

/**
 *  播放
 */
- (void)play;

/**
 *  暂停
 */
- (void)pause;
/**
 *在父视图显示
 */
-(void)showInSuperView:(UIView*)SuperView andSuperVC:(UIViewController*)SuperVC;

@end
