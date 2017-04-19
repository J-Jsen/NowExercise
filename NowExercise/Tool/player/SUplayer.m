//
//  SUplayer.m
//  SUPlayer
//
//  Created by mac on 17/3/14.
//  Copyright © 2017年 Suger. All rights reserved.
//

#import "SUplayer.h"
#define WeakSealf(weakself) __weak typeof(self) weakself = self;

@interface SUplayer()
{
    BOOL isIntoBackground;
    BOOL isShowToolbar;
    NSTimer *_timer;
    AVPlayerItem *_playerItem;
    AVPlayerLayer *_playerLayer;
    id _playTimeObserver; // 播放进度观察者
    UIActivityIndicatorView*loadActivity;

}
@property (weak, nonatomic) IBOutlet UIView *playerView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIButton *playBtn;
@property (weak, nonatomic) IBOutlet UISlider *playProgress;

@property (weak, nonatomic) IBOutlet UIButton *NowExerciseBtn;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgress;

@property (nonatomic, strong) CADisplayLink *link;//以屏幕刷新率进行定时操作
@property (nonatomic, assign) NSTimeInterval lastTime;


@end

@implementation SUplayer
- (void)awakeFromNib{
    [super awakeFromNib];
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"SUplayer" owner:self options:nil] firstObject];
        self.frame = frame;
        //加载拖到进度条的图片
        //[self.playProgress setThumbImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self setPortraitLayout];
        //返回按钮图片
#warning 设置关闭按钮图片
        [self.closeBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
#warning 设置播放按钮图片
        [self.playBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.player = [[AVPlayer alloc]init];
        _playerLayer = [AVPlayerLayer playerLayerWithPlayer:_player];
        _playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        [self.playerView.layer addSublayer:_playerLayer];
        loadActivity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self addSubview:loadActivity];
        
        
    }
    return self;
}
#pragma mark upMovieUrl
- (void)updatePlayerWith:(NSURL *)url{
    _playerItem = [AVPlayerItem playerItemWithURL:url];
    [_player replaceCurrentItemWithPlayerItem:_playerItem];
    [self addObserverAndNotification];
    [loadActivity startAnimating];
}
- (void)addObserverAndNotification{
    [_playerItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];//监听status属性
    [_playerItem addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];//监听缓冲进度
    [self monitoringPlayback:_playerItem];//监听播放状态
    [self addNotification];
    
    
}
-(void)addNotification{
    //给AVPlayerItem添加播放完成通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playbackFinished:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    // 后台&前台通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resignActiveNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
}
-(void)playbackFinished:(NSNotification *)notification{
    NSLog(@"视频播放完成.");
    _playerItem = [notification object];
    [_playerItem seekToTime:kCMTimeZero];
    [self play];
}
// 后台
- (void)resignActiveNotification{
    NSLog(@"进入后台");
    isIntoBackground = YES;
    [self pause];
}

// 前台
- (void)enterForegroundNotification
{
    NSLog(@"回到前台");
    isIntoBackground = NO;
    [self play];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    _playerLayer.frame = self.bounds;
    loadActivity.center = self.center;
}
#pragma mark showPlayer
- (void)showInSuperView:(UIView *)SuperView andSuperVC:(UIViewController *)SuperVC{
    [SuperView addSubview:self];
    
}

#pragma mark 开始播放
- (void)play{
    _isPlaying = YES;
    [_player play];
    [self.playBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    if (!self.link) {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];//和屏幕频率刷新相同的定时器
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
        
    }
}
//刷新 看播放是否卡顿
- (void)update{
    NSTimeInterval current = CMTimeGetSeconds(_player.currentTime);
    if (current == self.lastTime) {
        //卡顿
        [loadActivity startAnimating];
    }else{//没有卡顿
        [loadActivity stopAnimating];
    }
    self.lastTime = current;
}
#pragma mark 暂停播放
- (void)pause{
    _isPlaying = NO;
    [_player pause];
    [self.playBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    
}

- (void)setPortraitLayout{
    //[UIApplication sharedApplication].statusBarHidden = YES;
}
- (IBAction)playerSliderChanged:(id)sender {
    [self pause];
    //转换成CMTime才能给player来控制播放进度
    CMTime dragedCMTime = CMTimeMake(self.playProgress.value, 1);
    [_playerItem seekToTime:dragedCMTime];

}
- (IBAction)BackBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(Back)]) {
        [self.delegate Back];
    }
}
- (IBAction)playerSliderInside:(id)sender {
    NSLog(@"释放播放");
    [self play];

}
- (IBAction)playerSliderDown:(id)sender {
    NSLog(@"按动停止");
    [self pause];

}
- (IBAction)NowExerciseBtnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(ShowAddOrderView)]) {
        [self.delegate ShowAddOrderView];
    }
}
#pragma mark KVO Status
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    AVPlayerItem *item = (AVPlayerItem *)object;
    if ([keyPath isEqualToString:@"status"]) {
        if (isIntoBackground) {
            return;
        }else{
            if ([item status] == AVPlayerStatusReadyToPlay) {
                NSLog(@"AVPlayerStatusReadyToPlay");
                CMTime duration = item.duration;// 获取视频总长度
                NSLog(@"%f", CMTimeGetSeconds(duration));
                [self setMaxDuratuin:CMTimeGetSeconds(duration)];
                [self play];
                [loadActivity stopAnimating];
            }else if([item status] == AVPlayerStatusFailed) {
                NSLog(@"AVPlayerStatusFailed");
            }else{
                NSLog(@"AVPlayerStatusUnknown");
            }
        }
    }else if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        
        NSTimeInterval timeInterval = [self availableDurationRanges];//缓冲进度
        CMTime duration = _playerItem.duration;
        CGFloat totalDuration = CMTimeGetSeconds(duration);
        [self.bufferProgress setProgress: timeInterval / totalDuration animated:YES];
    }else if (object == _playerItem && [keyPath isEqualToString:@"playbackBufferEmpty"])
    {
        if (_playerItem.playbackBufferEmpty) {
            //Your code here
            NSLog(@"bufer Empty---");
        }
    }
    
    else if (object == _playerItem && [keyPath isEqualToString:@"playbackLikelyToKeepUp"])
    {
        if (_playerItem.playbackLikelyToKeepUp)
        {
            //Your code here
            NSLog(@"keep   up");
            
        }
    }
}
- (void)setMaxDuratuin:(float)total{
    self.playProgress.maximumValue = total;
    self.totalLabel.text = [self convertTime:self.playProgress.maximumValue];
}

- (NSTimeInterval)availableDurationRanges {
    NSArray *loadedTimeRanges = [_playerItem loadedTimeRanges];
    CMTimeRange timeRange = [loadedTimeRanges.firstObject CMTimeRangeValue];// 获取缓冲区域
    float startSeconds = CMTimeGetSeconds(timeRange.start);
    float durationSeconds = CMTimeGetSeconds(timeRange.duration);
    NSTimeInterval result = startSeconds + durationSeconds;// 计算缓冲总进度
    return result;
}

#pragma mark - _playTimeObserver
- (void)monitoringPlayback:(AVPlayerItem *)item {
    WeakSealf(ws);
    //这里设置每秒执行30次
    _playTimeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        
        // 计算当前在第几秒
        float currentPlayTime = (double)item.currentTime.value/item.currentTime.timescale;
        [ws updateVideoSlider:currentPlayTime];
    }];
}
- (void)updateVideoSlider:(float)currentTime{
    self.playProgress.value = currentTime;
    self.currentLabel.text = [self convertTime:currentTime];
}



- (NSString *)convertTime:(CGFloat)second{
    NSDate *d = [NSDate dateWithTimeIntervalSince1970:second];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (second/3600 >= 1) {
        [formatter setDateFormat:@"HH:mm:ss"];
    } else {
        [formatter setDateFormat:@"mm:ss"];
    }
    NSString *showtimeNew = [formatter stringFromDate:d];
    return showtimeNew;
}
- (void)dealloc{
    [_player replaceCurrentItemWithPlayerItem:nil];
    [_playerItem removeObserver:self forKeyPath:@"status"];
    [_playerItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [_player removeTimeObserver:_playTimeObserver];
    _playTimeObserver = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
