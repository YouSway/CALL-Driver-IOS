//
//  CCProgressView.m
//  UserClient
//
//  Created by user on 2016/7/23.
//  Copyright © 2016年 YouSway. All rights reserved.
//

#import "CCProgressView.h"

#import "UIDefine.h"

#define kProgressThumbWh 40

// 計時器間隔時長
#define kAnimTimeInterval 1.0

/**
 * 圓圈layer上旋轉的layer
 */
@interface CCProgressThumb : CALayer
{
    NSTimeInterval _animationTime;
}

@property (assign, nonatomic) double startAngle;
@property (nonatomic, strong) UILabel *timeLabel;      // 顯示時間Label

@end

@implementation CCProgressThumb

- (instancetype)init
{
    if ((self = [super init])) {
        [self setupLayer];
    }
    return self;
}

- (void)layoutSublayers
{
    _timeLabel.frame = self.bounds;
    
    [_timeLabel sizeToFit];
    _timeLabel.center = CGPointMake(CGRectGetMidX(self.bounds) - _timeLabel.frame.origin.x,
                                    CGRectGetMidY(self.bounds) - _timeLabel.frame.origin.y);
}

- (void)setupLayer
{
    // 繪製圓
    UIGraphicsBeginImageContext(CGSizeMake(kProgressThumbWh, kProgressThumbWh));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 1);
    CGContextSetFillColorWithColor(ctx, circleLine.CGColor);
    CGContextSetStrokeColorWithColor(ctx, circleLine.CGColor);
    CGContextAddEllipseInRect(ctx, CGRectMake(1, 1, kProgressThumbWh - 2, kProgressThumbWh - 2));
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *circle = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UIImageView *circleView = [[UIImageView alloc] initWithImage:circle];
    circleView.frame = CGRectMake(0, 0, kProgressThumbWh, kProgressThumbWh);
    circleView.image = circle;
    [self addSublayer:circleView.layer];
    
    _timeLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.font = [UIFont systemFontOfSize:10];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    _timeLabel.text = @"00:00";
    [self addSublayer:_timeLabel.layer];
    
    _startAngle = - M_PI / 2;
}

- (void)setAnimationTime:(NSTimeInterval)animationTime
{
    _animationTime = animationTime;
}

- (double)calculatePercent:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime
{
    double progress = 0.0f;
    if ((toTime > 0) && (fromTime > 0)) {
        progress = fromTime / toTime;
        if ((progress * 100) > 100) {
            progress = 1.0f;
        }
    }
    return progress;
}

- (void)startAnimation
{
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.calculationMode = kCAAnimationPaced;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = YES;
    pathAnimation.duration = kAnimTimeInterval;
    pathAnimation.repeatCount = 0;
    pathAnimation.autoreverses = YES;
    
    CGMutablePathRef arcPath = CGPathCreateMutable();
    CGPathAddPath(arcPath, NULL, [self bezierPathFromParentLayerArcCenter]);
    pathAnimation.path = arcPath;
    CGPathRelease(arcPath);
    [self addAnimation:pathAnimation forKey:@"position"];
}

/**
 * 根據父Layer獲取到一個移動路徑
 * @return
 */
- (CGPathRef)bezierPathFromParentLayerArcCenter
{
    CGFloat centerX = CGRectGetWidth(self.superlayer.frame) / 2.0;
    CGFloat centerY = CGRectGetHeight(self.superlayer.frame) / 2.0;
    double tmpStartAngle = _startAngle;
    //    _startAngle = _startAngle + (2 * M_PI) * kAnimTimeInterval / _animateTime;
    _startAngle = _startAngle + (2 * M_PI) * kAnimTimeInterval / _animationTime;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY)
                                          radius:centerX
                                      startAngle:tmpStartAngle
                                        endAngle:_startAngle
                                       clockwise:YES].CGPath;
}

- (void)stopAnimation
{
    [self removeAllAnimations];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end

/**
 * 圓圈layer
 */
@interface CCProgress : CAShapeLayer
{
    NSTimeInterval _animationTime;
}

@property (assign, nonatomic) double initialProgress;
@property (nonatomic) NSTimeInterval elapsedTime;                   //已使用時間
@property (assign, nonatomic) double percent;
@property (nonatomic, strong) UIColor *circleColor;
@property (nonatomic, strong) CAShapeLayer *progress;
@property (nonatomic, strong) CCProgressThumb *thumb;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, assign) int timeCount;

@end

@implementation CCProgress

- (instancetype) init
{
    if ((self = [super init])) {
        [self setupLayer];
    }
    return self;
}

- (void)layoutSublayers
{    self.path = [self bezierPathWithArcCenter];
    self.progress.path = self.path;
    
    self.thumb.frame = CGRectMake((320 - kProgressThumbWh) / 2.0f, 180, kProgressThumbWh, kProgressThumbWh);
    [super layoutSublayers];
}

- (void)setupLayer
{
    // 繪製圓
    self.path = [self bezierPathWithArcCenter];
    self.fillColor = [UIColor clearColor].CGColor;
    self.strokeColor = circleLine.CGColor;
    self.lineWidth = 2;
    
    // 添加可以變動的滾動條
    self.progress = [CAShapeLayer layer];
    self.progress.path = self.path;
    self.progress.fillColor = [UIColor clearColor].CGColor;
    self.progress.strokeColor = circleLine.CGColor;
    self.progress.lineWidth = 10;
    self.progress.lineCap = kCALineCapSquare;
    self.progress.lineJoin = kCALineCapSquare;
    [self addSublayer:self.progress];
    
    // 添加可以旋轉的ThumbLayer
    self.thumb = [[CCProgressThumb alloc] init];
    [self addSublayer:self.thumb];
    
    self.timeCount = 0;
}

/**
 * 得到bezier曲線路勁
 * @return
 */
- (CGPathRef)bezierPathWithArcCenter
{
    CGFloat centerX = CGRectGetWidth(self.frame) / 2.0;
    CGFloat centerY = CGRectGetHeight(self.frame) / 2.0;
    return [UIBezierPath bezierPathWithArcCenter:CGPointMake(centerX, centerY)
                                          radius:centerX
                                      startAngle:(- M_PI / 2)
                                        endAngle:(3 * M_PI / 2)
                                       clockwise:YES].CGPath;
}

- (void)setCircleColor:(UIColor *)circleColor
{
    self.progress.strokeColor = circleColor.CGColor;
}

- (void)setAnimtionTime:(NSTimeInterval)animtionTime
{
    _animationTime = animtionTime;
    [self.thumb setAnimationTime:animtionTime];
}

- (void)setElapsedTime:(NSTimeInterval)elapsedTime
{
    _initialProgress = [self calculatePercent:_elapsedTime toTime:_animationTime];
    _elapsedTime = elapsedTime;
    
    self.progress.strokeEnd = self.percent;
    [self startAnimation];
}

- (double)percent
{
    _percent = [self calculatePercent:_elapsedTime toTime:_animationTime];
    return _percent;
}

- (double)calculatePercent:(NSTimeInterval)fromTime toTime:(NSTimeInterval)toTime
{
    double progress = 0.0f;
    if ((toTime > 0) && (fromTime > 0)) {
        progress = fromTime / toTime;
        if ((progress * 100) > 100) {
            progress = 1.0f;
        }
    }
    return progress;
}

- (void)startAnimation
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = kAnimTimeInterval;
    pathAnimation.fromValue = @(self.initialProgress);
    pathAnimation.toValue = @(self.percent);
    pathAnimation.removedOnCompletion = YES;
    [self.progress addAnimation:pathAnimation forKey:nil];
    
    [self.thumb startAnimation];
    
    //    self.thumb.timeLabel.text = [self stringFromTimeInterval:_elapsedTime shorTime:YES];
    self.thumb.timeLabel.text = [self stringFromTimeInterval:_timeCount shorTime:YES];
    _timeCount++;
}

- (void)stopAnimation
{
    _elapsedTime = 0;
    self.progress.strokeEnd = 0.0;
    [self removeAllAnimations];
    [self.thumb stopAnimation];
}

-(void)setTime{
    
}

/**
 * 時間格式轉換
 * @param interval NSTimeInterval
 * @param shortTime BOOL
 * @return
 */
//- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval shorTime:(BOOL)shortTime
- (NSString *)stringFromTimeInterval:(int)interval shorTime:(BOOL)shortTime
{
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    
    if (seconds == 5) {
    }
    
    //回傳分秒
    return [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
    
    //    if (shortTime) {
    //        return [NSString stringWithFormat:@"%02ld:%02ld", (long)hours, (long)seconds];
    //    } else {
    //        return [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hours, (long)minutes, (long)seconds];
    //    }
}

@end

@interface CCProgressView ()

@property (nonatomic, strong) CCProgress *progressLayer;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CCProgressView

- (instancetype)init
{
    if ((self = [super init])) {
        [self setupView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self setupView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.progressLayer.frame = self.bounds;
    
    [self.centerLabel sizeToFit];
    self.centerLabel.center = CGPointMake(self.center.x - self.frame.origin.x, self.center.y- self.frame.origin.y);
}

- (void)setupView
{
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = false;
    
    self.progressLayer = [[CCProgress alloc] init];
    self.progressLayer.frame = self.bounds;
    [self.layer addSublayer:self.progressLayer];
    
    _centerLabel = [[UILabel alloc] initWithFrame:self.bounds];
    _centerLabel.font = [UIFont systemFontOfSize:18];
    _centerLabel.textAlignment = NSTextAlignmentCenter;
    _centerLabel.textColor = greenLightWord;
    _centerLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    _centerLabel.text = @"已推送至 0 家";
    [self.layer addSublayer:_centerLabel.layer];
}

- (void)setAnimationTime:(NSTimeInterval)animationTime
{
    _animationTime = animationTime;
    [self.progressLayer setAnimtionTime:animationTime];
}

- (void)startAnimation
{
    if (!_timer) {
        _timer = [NSTimer timerWithTimeInterval:kAnimTimeInterval target:self selector:@selector(doTimerSchedule) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    self.progressLayer.elapsedTime = 0;
    if (_start) _start();
}

- (void)doTimerSchedule
{
    if (self.progressLayer.elapsedTime == 59) {
        self.progressLayer.elapsedTime = 0;
    }
    
    self.progressLayer.elapsedTime = self.progressLayer.elapsedTime + kAnimTimeInterval;;
    if (_animing) _animing(self.progressLayer.elapsedTime);
    
    //    if (self.progressLayer.elapsedTime >= _animationTime) {
    //        [self stopAnimation];
    //    }
}

- (void)stopAnimation
{
    if (_stop) _stop();
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    [_progressLayer stopAnimation];
}

-(void)setLabelText:(NSString *)text{
    _centerLabel.text = text;
}

-(void)setTimeLabelText:(NSString *)text{
    //self.thumb.timeLabel.text = [self stringFromTimeInterval:_elapsedTime shorTime:YES];
    //    CCProgressThumb.thumb.timeLabel.text = text;
    //    CCProgress.timeLabel.text = text;
    //    self.
    
    _progressLayer.thumb.timeLabel.text = text;
    
}

@end
