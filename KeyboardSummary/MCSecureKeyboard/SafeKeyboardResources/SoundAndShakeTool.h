//
//  SoundAndShakeTool.h
//  GjFax
//
//  Created by gjfax on 2018/4/18.
//  Copyright © 2018年 GjFax. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundAndShakeTool : NSObject

/*启动：声音 */
+ (void)play;

/*停止：声音 */
+ (void)stop;

/*继续：声音 */
+ (void)replaySound;

/*启动：震动*/
+ (void)playShake;

/*停止：震动*/
+ (void)stopShake;

@end
