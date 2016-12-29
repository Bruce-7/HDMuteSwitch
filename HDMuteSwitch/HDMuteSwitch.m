//
//  HDMuteSwitch.m
//  Seven
//
//  Created by HeDong on 2016/12/13.
//  Copyright © 2016年 hedong. All rights reserved.
//

#import "HDMuteSwitch.h"

@interface HDMuteSwitch ()

@property (nonatomic, copy) void(^muted)(BOOL muted);

@property (nonatomic, assign) float soundDuration;

@property (nonatomic, strong) NSTimer *playbackTimer;

@end


@implementation HDMuteSwitch

HDSingletonM(HDMuteSwitch)

- (void)playbackComplete {
    if ([(id)self.delegate respondsToSelector:@selector(isMuted:)]) {
        if (self.soundDuration < 0.010) {
            [self.delegate isMuted:YES];
        } else {
            [self.delegate isMuted:NO];
        }
    }
    
    if (self.soundDuration < 0.010) {
        self.muted(YES);
    } else {
        self.muted(NO);
    }
    
    [self.playbackTimer invalidate];
    self.playbackTimer = nil;
}

- (void)incrementTimer {
    self.soundDuration = self.soundDuration + 0.001;
}

static void soundCompletionCallback (SystemSoundID mySSID, void *myself) {
    AudioServicesRemoveSystemSoundCompletion(mySSID);
    [[HDMuteSwitch sharedHDMuteSwitch] playbackComplete];
}

- (void)detectMuteSwitch:(void(^)(BOOL muted))muted {
#if TARGET_IPHONE_SIMULATOR
    // The simulator doesn't support detection and can cause a crash so always return muted
    if ([(id)self.delegate respondsToSelector:@selector(isMuted:)]) {
        [self.delegate isMuted:YES];
    }
    
    muted(YES);
    
    return;
#endif
    self.muted = muted;
    self.soundDuration = 0.0;
    CFURLRef		soundFileURLRef;
    SystemSoundID	soundFileObject;
    
    // Get the main bundle for the app
    CFBundleRef mainBundle;
    mainBundle = CFBundleGetMainBundle();
    
    // Get the URL to the sound file to play
    soundFileURLRef = CFBundleCopyResourceURL(mainBundle,
                                              CFSTR ("detection"),
                                              CFSTR ("aiff"),
                                              NULL);
    
    // Create a system sound object representing the sound file
    AudioServicesCreateSystemSoundID (soundFileURLRef,
                                      &soundFileObject);
    
    AudioServicesAddSystemSoundCompletion (soundFileObject, NULL, NULL,
                                           soundCompletionCallback,
                                           (__bridge void *) self);
    
    // Start the playback timer
    self.playbackTimer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(incrementTimer) userInfo:nil repeats:YES];
    // Play the sound
    AudioServicesPlaySystemSound(soundFileObject);
    
    return;
}


#pragma mark - 震动相关
static void systemAudioCallback() {
    [[HDMuteSwitch sharedHDMuteSwitch] performSelector:@selector(triggerShake) withObject:nil afterDelay:1];
}

- (void)triggerShake {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)playSystemSoundVibrate {
    [self triggerShake];
}

- (void)repeatPlaySystemSoundVibrate {
    AudioServicesAddSystemSoundCompletion(kSystemSoundID_Vibrate, NULL, NULL, systemAudioCallback, NULL);
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

- (void)removePlaySystemSoundVibrate {
    [NSObject cancelPreviousPerformRequestsWithTarget:self
                                             selector:@selector(triggerShake)
                                               object:nil];
    
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
}

@end
