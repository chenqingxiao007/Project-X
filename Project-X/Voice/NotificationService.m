//
//  NotificationService.m
//  NotificationModifyService
//
//  Created by 刘旦 on 20/05/2017.
//  Copyright © 2017 danny. All rights reserved.
//

#import "NotificationService.h"
#import<AVFoundation/AVFoundation.h>


@interface NotificationService ()<AVSpeechSynthesizerDelegate>

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@property (nonatomic,strong) NSURLSessionDownloadTask *downLoadTask;

//负责播放
@property (nonatomic, strong) AVSpeechSynthesizer *aVSpeechSynthesizer;

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    // self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    // read content
    
    NSDictionary *userInfo = request.content.userInfo;
    if ([userInfo objectForKey:@"speed"]) {
        NSString *speedStr = [userInfo objectForKey:@"speed"];
        if ([speedStr floatValue]) {
            [self readContent:self.bestAttemptContent.body speed:[speedStr floatValue] * 0.5];
        }else {
            [self readContent:self.bestAttemptContent.body speed:AVSpeechUtteranceDefaultSpeechRate];
        }
    }else {
        [self readContent:self.bestAttemptContent.body speed:AVSpeechUtteranceDefaultSpeechRate];
    }
    
    /** download images
     NSString *url = request.content.userInfo[@"attach"];
     NSURL *nsurl = [NSURL URLWithString:url];
     
     self.downLoadTask = [[NSURLSession sharedSession] downloadTaskWithURL:nsurl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
     
     if (!error) {
     
     NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
     [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
     
     UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
     
     
     self.bestAttemptContent.attachments = @[attachment];
     }
     
     
     self.contentHandler(self.bestAttemptContent);
     
     }];
     
     [self.downLoadTask resume];
     **/
}

- (void)readContent:(NSString*)str speed:(float)speed{
    //AVSpeechUtterance: 可以假想成要说的一段话
    AVSpeechUtterance * aVSpeechUtterance = [[AVSpeechUtterance alloc] initWithString:str];
    
//    aVSpeechUtterance.rate = AVSpeechUtteranceDefaultSpeechRate;
    
    aVSpeechUtterance.rate = speed;
    //AVSpeechSynthesisVoice: 可以假想为人的声音
    aVSpeechUtterance.voice =[AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    aVSpeechUtterance.volume = 1.0;
    //发音
    [self.aVSpeechSynthesizer speakUtterance:aVSpeechUtterance];
    
}
- (void)stopRead{
    
    [self.aVSpeechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
}


- (void)speechSynthesizer:(AVSpeechSynthesizer *)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance *)utterance;{
    
    NSLog(@"阅读完毕");
    self.contentHandler(self.bestAttemptContent);
}


- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    [self stopRead];
    NSLog(@"cancel ");
    
    [self.downLoadTask cancel];
    self.contentHandler(self.bestAttemptContent);
}

- (AVSpeechSynthesizer *)aVSpeechSynthesizer{
    if (!_aVSpeechSynthesizer) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        
        
        
        _aVSpeechSynthesizer = [[AVSpeechSynthesizer alloc] init];
        _aVSpeechSynthesizer.delegate = self;
        
        
        
    }
    return _aVSpeechSynthesizer;
}
@end

