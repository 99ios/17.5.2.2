//
//  ViewController.m
//  17.5.2-2 陀螺仪的裸数据
//
//  Created by 李维佳 on 2017/4/14.
//  Copyright © 2017年 Liz. All rights reserved.
//

#import "ViewController.h"
#import <CoreMotion/CoreMotion.h>

@interface ViewController ()
@property (nonatomic, strong) CMMotionManager *motionMgr;
@end

@implementation ViewController

- (CMMotionManager *)motionMgr{
    if (_motionMgr == nil) {
        _motionMgr = [[CMMotionManager alloc ] init];
    }
    return _motionMgr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //Pull模式--加速计Accelerometer
    if (self.motionMgr.isAccelerometerAvailable) {
        //启动采样
        [self.motionMgr startAccelerometerUpdates];
    }else {
        NSLog(@"加速计Accelerometer不可用");
    }
    //Pull模式--陀螺仪
    if (self.motionMgr.isGyroAvailable) {
        [self.motionMgr startGyroUpdates];
    }else {
        NSLog(@"陀螺仪GyroScope不可用");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //获取陀螺仪当前状态
    CMRotationRate rationRate = self.motionMgr.gyroData.rotationRate;
    NSLog(@"gyroscope current state: x:%f, y:%f, z:%f", rationRate.x, rationRate.y, rationRate.z);
}

- (IBAction)startGyro:(id)sender {
    //设置采样间隔
    self.motionMgr.gyroUpdateInterval = 1.0;
    //开始采样
    [self.motionMgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
        NSLog(@"x:%f, y:%f, z:%f", gyroData.rotationRate.x, gyroData.rotationRate.y, gyroData.rotationRate.z);
    }];
}

- (IBAction)stopGyro:(id)sender {
    [self.motionMgr stopGyroUpdates];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
