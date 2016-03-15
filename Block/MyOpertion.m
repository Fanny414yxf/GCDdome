//
//  MyOpertion.m
//  Block
//
//  Created by 杨晓芬 on 16/3/11.
//  Copyright © 2016年 Fanny. All rights reserved.
//

#import "MyOpertion.h"

@implementation MyOpertion


- (id)initWithUrl:(NSString *)url delegate:(id<MyOperionDownloadDelegate>)delegate
{
    if (self = [super init]) {
        self.url = url;
        self.delegate = delegate;
    }
    return self;
}

//使用 main 方法非常简单，开发者不需要管理一些状态属性（例如 isExecuting 和 isFinished），当 main 方法返回的时候，这个 operation 就结束了。这种方式使用起来非常简单，但是灵活性相对重写 start 来说要少一些， 因为main方法执行完就认为operation结束了，所以一般可以用来执行同步任务。

// 在 main 和 start 中都可以操作
- (void)main
{
    @autoreleasepool {
        NSURL *url = [NSURL URLWithString:self.url];
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        if (self.isCancelled) {
            url = nil;
            data = nil;
            return;
        }
        UIImage *image = [UIImage imageWithData:data];
        if (self.isCancelled) {
            url = nil;
        }
        if (self.delegate && [_delegate respondsToSelector:@selector(downloadFinishedImage:)]) {
            [(NSObject *)self.delegate performSelectorOnMainThread:@selector(downloadFinishedImage:) withObject:image waitUntilDone:NO];
        }
    }
}



- (void)start
{
    
}


- (void)finish
{
    self.executing = NO;
    self.finished = YES;
    
    //手动发送通知消息KVO
//    [self willChangeValueForKey:@"isCancelled"];
//    _isCancelled = YES;
//    [self didChangeValueForKey:@"isCancelled"];

}






@end
