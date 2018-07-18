//
//  SoundAndShakeTool.m
//  GjFax
//
//  Created by gjfax on 2018/4/18.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import "SoundAndShakeTool.h"
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SoundAndShakeTool ()
@property (nonatomic, assign) SystemSoundID soundID;
@property (nonatomic, assign) BOOL isSoundForbidden;
@end

@implementation SoundAndShakeTool
#pragma mark -  单例
+ (instancetype)manager{
    static id _instance;
    static dispatch_once_t _onceToken;
    dispatch_once(&_onceToken, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

#pragma mark -  系统音效：不需要音效文件
//[self soundWithName:@"Tock" SoundType:@"caf"];
- (void)soundWithName:(NSString *)soundName SoundType:(NSString *)soundType
{
    
    if (!_soundID) {
        NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",soundName,soundType];
        if (path) {
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&_soundID);
            
            if (error != kAudioServicesNoError) {//获取的声音的时候，出现错误
                _soundID = 0;
            }
        }
    };
}

#pragma mark -  自定义音效1：需要音效文件 (根据文件的名称和扩展名获取 path 名称)
// [self selfDefinedSoundEffectWith:@"Sound2_Tock" ofType:@"mp3"];
- (void)selfDefinedSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    
    if (!_soundID) {
        NSString *path = [[NSBundle mainBundle] pathForResource:resourceName ofType:type];
        if (path) {
            //使用本地
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                _soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        } else {
            //使用系统
            [self soundWithName:@"Tock" SoundType:@"caf"];
        }
    };
}

#pragma mark -  自定义音效2：需要音效文件 (使用bundle 创建一个资源文件的URL)
//[self selfDefinedSoundEffectWith:@"Sound2_Tock.mp3"];
- (void)selfDefinedSoundEffectWith:(NSString *)filename
{
    if (!_soundID) {
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            //使用本地
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                _soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }else {
            //使用系统
            [self soundWithName:@"Tock" SoundType:@"caf"];
        }
    };
}

#pragma mark -  开启震动
+ (void)playShake {
    
    //系统震动
    //      AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    // 普通短震，3D Touch 中 Peek 震动反馈
    AudioServicesPlaySystemSound(1519);
    
    // 普通短震，3D Touch 中 Pop 震动反馈
    //        AudioServicesPlaySystemSound(1520);
    
    // 连续三次短震
    //    AudioServicesPlaySystemSound(1521);
}

#pragma mark -  停止震动
+ (void)stopShake {
    //     AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(1519);
    //     AudioServicesDisposeSystemSoundID(1520);
    //     AudioServicesDisposeSystemSoundID(1521);
}

#pragma mark -  统一开启声音
+ (void)play {
    SoundAndShakeTool *tool = [SoundAndShakeTool manager];
    if (![self getForbiddenMark]) {
        [tool selfDefinedSoundEffectWith:@"Sound2_Tock" ofType:@"mp3"];
    }
    [tool play];
}

#pragma mark -  统一停止声音
+ (void)stop {
    [[SoundAndShakeTool manager] stop];
    [self forbidMark];
}

#pragma mark -  统一继续声音
+ (void)replaySound {
    SoundAndShakeTool *tool = [SoundAndShakeTool manager];
    [tool selfDefinedSoundEffectWith:@"Sound2_Tock" ofType:@"mp3"];
    [tool play];
    [self allowMark];
}

#pragma mark -  标记
+ (void)forbidMark {
    SoundAndShakeTool *tool = [SoundAndShakeTool manager];
    tool.isSoundForbidden = YES;
}
+ (void)allowMark {
    SoundAndShakeTool *tool = [SoundAndShakeTool manager];
    tool.isSoundForbidden = NO;
}
+ (BOOL)getForbiddenMark {
    SoundAndShakeTool *tool = [SoundAndShakeTool manager];
    return tool.isSoundForbidden;
}

#pragma mark -  开启声音
- (void)play {
    AudioServicesPlaySystemSound(_soundID);
}

#pragma mark -  停止声音
- (void)stop {
    _soundID = 0;
}

#pragma mark -  销毁
- (void)dealloc {
    AudioServicesDisposeSystemSoundID(_soundID);
    //    AudioServicesRemoveSystemSoundCompletion(_soundID);
}
@end
