#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;
@property (nonatomic,strong) NSURLSessionDownloadTask *downLoadTask;//下载的task 用于取消

@end

@implementation NotificationService

- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    // self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    //以上代码均有系统自动生成
    
    //获取下载的资源地址 这里和服务端约定好即可
    NSString *url = request.content.userInfo[@"attach"];
    NSURL *nsurl = [NSURL URLWithString:url];
    
    //开始下载
    self.downLoadTask = [[NSURLSession sharedSession] downloadTaskWithURL:nsurl completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        if (!error) {
            
            //将下载后的文件进行 移动到沙盒 切记这里的文件要及时清理
            NSString *path = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
            [[NSFileManager defaultManager] moveItemAtURL:location toURL:[NSURL fileURLWithPath:path] error:nil];
            
            //为 Notification 增加 attachment
            UNNotificationAttachment *attachment = [UNNotificationAttachment attachmentWithIdentifier:@"attachment" URL:[NSURL fileURLWithPath:path] options:nil error:nil];
            
            
            self.bestAttemptContent.attachments = @[attachment];
        }
        
        //不管成功失败 返回结果
        self.contentHandler(self.bestAttemptContent);
        
    }];
    
    [self.downLoadTask resume];
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    NSLog(@"cancel ");
    //取消下载
    [self.downLoadTask cancel];
    self.contentHandler(self.bestAttemptContent);
}

@end
