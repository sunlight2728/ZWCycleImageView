//
//  Gravity.m
//  GyroscopeTest
//
//  Created by Seven-Augus on 16/8/19.
//  Copyright © 2016年 Seven-Augus. All rights reserved.
//

#import "Gravity.h"

@implementation Gravity
{
    NSOperationQueue *_queue;
    void(^_completeBlockGyro)(float x, float y, float z);
    void(^_completeBlockAccelerometer)(float x, float y, float z);
    void(^_completeBlockDeviceMotion)(float x, float y, float z);
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self configGravity];
    }
    return self;
}

- (void)configGravity
{
    _motionManager = [[CMMotionManager alloc] init];
    // 添加一个队列线程
    _queue = [[NSOperationQueue alloc] init];
}

- (void)startGyroUpdatesBlock:(void (^)(float, float, float))completeBlock
{
    // 重力感应
    if (_motionManager.gyroAvailable) {
        // 更新速度
        _motionManager.gyroUpdateInterval = _timeInterval;
        // block
        [_motionManager startGyroUpdatesToQueue:_queue withHandler:^(CMGyroData * _Nullable gyroData, NSError * _Nullable error) {
            if (error) {
                // 停止重力感应更新
                [_motionManager stopGyroUpdates];
                NSLog(@"error == %@", [NSString stringWithFormat:@"%@", error]);
            } else {
                _completeBlockGyro = completeBlock;
                // 回主线程
                [self performSelectorOnMainThread:@selector(gyroUpdate:) withObject:gyroData waitUntilDone:NO];
            }
        }];
    } else {
        NSLog(@"设备没有重力感应");
    }
}

- (void)startAccelerometerUpdatesBlocks:(void (^)(float, float, float))completeBlock
{
    // 加速度
    if (_motionManager.accelerometerAvailable) {
        // 更新速度
        _motionManager.accelerometerUpdateInterval = _timeInterval;
        // block
        [_motionManager startMagnetometerUpdatesToQueue:_queue withHandler:^(CMMagnetometerData * _Nullable magnetometerData, NSError * _Nullable error) {
            _completeBlockAccelerometer = completeBlock;
            if (error) {
                [_motionManager stopAccelerometerUpdates];
                NSLog(@"error == %@", error.localizedDescription);
            } else {
                [self performSelectorOnMainThread:@selector(accelerometerUpdate:) withObject:magnetometerData waitUntilDone:NO];
            }
        }];
    } else {
        NSLog(@"设备没有加速器");
    }
}

- (void)startDeviceMotionUpdatesBlock:(void (^)(float, float, float))completeBlock
{
    // 判断有无陀螺仪
    if (_motionManager.deviceMotionAvailable) {
        // 更新
        _motionManager.deviceMotionUpdateInterval = _timeInterval;
        // block
        [_motionManager startDeviceMotionUpdatesToQueue:_queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            _completeBlockDeviceMotion = completeBlock;
            if (error) {
                [_motionManager stopAccelerometerUpdates];
                NSLog(@"error == %@", error.localizedDescription);
            } else {
                [self performSelectorOnMainThread:@selector(deviceMotionUpdate:) withObject:motion waitUntilDone:NO];
            }
        }];
    } else {
        NSLog(@"设备没有陀螺仪");
    }
}

- (void)gyroUpdate:(CMGyroData *)gyroData
{
    //分量
    _completeBlockGyro(gyroData.rotationRate.x,gyroData.rotationRate.y,gyroData.rotationRate.z);
}

-(void)accelerometerUpdate:(CMAccelerometerData *)accelerometerData;
{
    //重力加速度三维分量
    _completeBlockAccelerometer(accelerometerData.acceleration.x,accelerometerData.acceleration.y,accelerometerData.acceleration.z);
}

-(void)deviceMotionUpdate:(CMDeviceMotion *)motionData
{
    //陀螺仪
    _completeBlockDeviceMotion(motionData.rotationRate.x,motionData.rotationRate.y,motionData.rotationRate.z);
}

-(void)stop
{
    [_motionManager stopAccelerometerUpdates];
    [_motionManager stopGyroUpdates];
    [_motionManager stopDeviceMotionUpdates];
}


+ (Gravity *)shareGravity
{
    static Gravity *gravity = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        gravity = [[self alloc] init];
    });
    return gravity;
}

@end
