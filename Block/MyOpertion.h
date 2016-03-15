//
//  MyOpertion.h
//  Block
//
//  Created by 杨晓芬 on 16/3/11.
//  Copyright © 2016年 Fanny. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol MyOperionDownloadDelegate <NSObject>
- (void)downloadFinishedImage:(UIImage *)image;

@end

@interface MyOpertion : NSOperation

@property (nonatomic, assign) BOOL finished;
@property (nonatomic, assign) BOOL executing;

@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) id <MyOperionDownloadDelegate> delegate;
- (id)initWithUrl:(NSString *)url delegate:(id<MyOperionDownloadDelegate>)delegate;

@end
