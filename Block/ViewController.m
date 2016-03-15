//
//  ViewController.m
//  Block
//
//  Created by 杨晓芬 on 16/3/9.
//  Copyright © 2016年 Fanny. All rights reserved.
//

#import "ViewController.h"
#import "MyOpertion.h"

#define WIDTH   self.view.bounds.size.width
#define HEIGHT  self.view.bounds.size.height - 70

static ViewController *VC = nil;

@interface ViewController ()<MyOperionDownloadDelegate>
{
    dispatch_queue_t dispatchqueue;
    UIImageView *_imageView;
}

@property (nonatomic, strong) UITableView *tableView;


@end


/**
 *扎实的C/Object_C基础，熟练Object_C编程，熟悉Cocoa touch框架、iPhone SDK的使用；
 2、熟练UI布局纯代码及xib、 storyboard、 自定义控件及封装，代码性能优化；
 3、熟悉Socket通信、Grand Central Dispatch、常用的设计模式；
 4、熟练数据持久化，SQLite数据库，网络、内存管理机制；
 5、掌握Core Animation，Quartz2D动画，常见开源库的使用；
 *
 *
 */


//获取全局并发调度队列
/**
 *
 DISPATCH_QUEUE_PRIORITY_HIGH   高
 DISPATCH_QUEUE_PRIORITY_LOW    低
 DISPATCH_QUEUE_PRIORITY_DEFAULT  默认
 DISPATCH_QUEUE_PRIORITY_BACKGROUND   后台
 
 */

#pragma mark -  Block 学习
/**
 *  Block
 *  返回值类型 (^block名称)(参数列表) = ^(参数列表)
 *  原文链接：http://www.jianshu.com/p/17872da184fb
 *  返回值类型(^block变量名)(形参列表) = ^(形参列表) {};
 */


void (^block)(void) = ^{
    NSLog(@"最简单的block");
};

//1 block声明
//有返回值
int (^sunblock)(int, int);
//无返回值
void (^noreuslt)(int, int);

//2. 赋值block块
// 1) 先声明再赋值
void (^myblock)(int, int);
//---------------------

// 2) 声明时赋值
int (^sumBlock) (int, int) = ^(int a, int b)
{
    int sum = a + b;
    return sum;
};




/**
 *  无参无返回
 *
 *  @param ^ 代码块
 *
 *  @return nil
 */
void (^emptyBlock)() = ^(){
    NSLog(@"无参无返回的block");
};

/**
 *  有参无返回
 *
 *  @param int 参1
 *  @param int 参2
 *
 *  @return nil
 */
void (^sunBlock)(int, int) = ^(int a, int b){
    NSLog(@"%d + %d = %d", a, b, a + b);
};

/**
 *  有参有返回
 *
 *  @param NSString 参1
 *  @param NSString 参2
 *
 *  @return 返回类型
 */
NSString * (^logStringBlock)(NSString *, NSString *) = ^(NSString * s1, NSString * s2) {
    NSString * log = [s1 stringByAppendingString:s2];
    return log;
};



@implementation ViewController


// ***************************************  viewDidLoad  *************************************
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //调用
    emptyBlock();
    NSString * sss = logStringBlock(@"fanny", @"hello");
    
//    [self.view addSubview:self.tableView];
    
    
    dispatchqueue = dispatch_queue_create("com.baidui.www", NULL);
//    [self addQueue];
//    [self sentImage];
    
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 70, WIDTH, HEIGHT)];
    _imageView.backgroundColor = [UIColor orangeColor];
    
    
    //直接加载
    UIImage *im = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/b219ebc4b74543a94369f4cb1c178a82b9011442.jpg"]]];
    _imageView.image = im;
    [self.view addSubview:_imageView];

    
#pragma mark --------------------------- dispatch c d  --------------------------------------
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    dispatch_async(queue, ^{
//        
//        NSLog(@"-子线程-- 开始下载图片--%@",[NSThread currentThread]);
//        
//        //下载数据是耗时操作放到子线程
//        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/b219ebc4b74543a94369f4cb1c178a82b9011442.jpg"]]];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"-主线程-- 刷新UI--%@",[NSThread currentThread]);
//            //回到主线程刷新UI
//            _imageView.image = image;
//        });
//    });
    
    
//        [self yanshicaozuoExample1];    //GCD

#pragma makr ------------------------------- operation  -------------------------------------------
    
//    [self test1];   //NSInvocationOperation
    
//    [self operation];   //NSOperationQueue
    
//    [self downloadImageWithMyOpertion];   //自定义 MyOpertion
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






#pragma mark - GCD

/**
 *  全集并发列队
 第一个参数是四种()之一, 参数二是预留的
 */
- (void)global
{
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}

/**
 *  串行多列 一次只能执行一个  当前执行完成后在执行下一个
 * 参数1通常是公司反域名 参数2通常为NULL
 */
- (void)create
{
    dispatch_queue_t create = dispatch_queue_create("com.baidui.www", NULL);
}


/**
 *  获取公共列队
 *  dispatch_get_current_queue：在iOS 6.0之后已经废弃，用于获取当前正在执行任务的队列，主要用于调试
 *  dispatch_get_main_queue： 最常用的，用于获取应用主线程关联的串行调度队列
 *  dispatch_get_global_queue：最常用的，用于获取应用全局共享的并发队列
 */


/**
 *  T添加任务到调度队列
 *  注:   并发队列数量不能过多 最多4个左右,太多会消耗
 */

- (void)addQueue
{
    //创建队列
    
    dispatch_async(dispatchqueue, ^{
        NSLog(@"添加一个异步队列 当前队列%@", [NSThread currentThread]);
    });

   dispatch_sync(dispatchqueue, ^{
       NSLog(@"添加一个同步队列 当前队列%@", [NSThread currentThread]);
   });
}



//并发地循环迭代任务   用 dispatch_apply  代替for循环
/**
 *  注意：dispatch_apply或dispatch_apply_f函数也是在所有迭代完成之后才会返回，因此这两个函数会阻塞当前线程。当我们在主线程中使用时，一定要小心，很容易造成事件无法响应，所以如果循环代码需要一定的时间执行,可考虑在另一个线程中调用这两个函数。如果所传递的参数是串行queue，而且正是执行当前代码的queue,就会产生死锁。
 */

- (void)sentImage
{
    dispatch_queue_t gqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    size_t  s = 10;
    dispatch_apply(s, gqueue, ^(size_t i) {
        NSLog(@"发送照片%ld", (long)i);
    });
}

/**
 *  异步加载图片
 */

-(void)downloadImage{
    dispatch_async((dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)), ^{
        NSURL *imageurl = [NSURL URLWithString:@""];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imageurl]];
        
        //回到主线程加载图片
        dispatch_async(dispatch_get_main_queue(), ^{
            _imageView.image = image;
        });
    });
}

/**
 *   暂停 继续队列
 *  dispatch_suspend(gqueue);   queue的引用计数增加
 *  dispatch_resume(gqueue);    queue的引用计数减少
 */


/**
 *  dispatch_queue_t
 *  调度组（Dispatch Group）的使用
 *  当我们需要下载多张图片并且图片要求这几张图片都下载完成以后才能更新UI，那么这种情况下，我们就需要使用dispatch_group_t来完成了。
 */
/**
 *  知道队列任务执行完
 *  1) 串行队列: 把回调的block加入到队列末尾
 *  2) 并发队列: dispatch_group
 */

- (void)updateImage {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    __block UIImage *image1 = nil;
    __block UIImage *image2 = nil;
    
    dispatch_group_async(group, (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)), ^{
        [self downloadImage:@"baidu.com"];
    });
    dispatch_group_async(group, (dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)), ^{
        [self downloadImage:@"fannu.com"];
    });
    
    //队列组完成后进入主线程跟新UI
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        _imageView.image = image1;
    });
}

- (void)downloadImage:(NSString *)url
{
}



/**
 *  dispatch_after
 *  利用dispatch来延迟执行
 */

// 1)     [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>]

// 2)   用timer

// 3) dispatch  倒计时按钮可以用这个方式做
- (void)afterTenMius
{
    CGFloat  time = 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       // time秒后异步执行这里的代码...
                       
                   });
}


- (void)yanshicaozuoExample1
{
    //获取全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //延时多久
    dispatch_time_t whentime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC));
    //Y延时操作,根据whentime
    dispatch_after(whentime, queue, ^{
        NSLog(@"倒计时结束");
        dispatch_async(queue, ^{
            NSLog(@"线程开始下载图片%@", [NSThread currentThread]);
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://b.hiphotos.baidu.com/image/pic/item/b219ebc4b74543a94369f4cb1c178a82b9011442.jpg"]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"线程开始更新UI%@", [NSThread currentThread]);
                _imageView.image = image;
            });
        });
    });
}






/**
 *  dispatch_once_t
 *  GCD执行一次性   如单列
 */
- (ViewController *)shareInstans
{
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
       //代码只执行一次
        if (!VC) {
            VC = [[ViewController alloc] init];
        }
    });
    return VC;
}


/**
 * 设置队列优先级
 dispatch_set_target_queue
 */

- (void)adjustpriority
{
    dispatch_queue_t queue = dispatch_queue_create("com.example.queue", NULL);
    //将全局并发队列改为后台
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    //队列的优先级改为后台了
    dispatch_set_target_queue(queue, global);
}





#pragma mark - NSOperation 和 NSOperationQueue
/**
 *  原文链接：http://www.jianshu.com/p/a044cd145a3d
 *  NSOperation      NSOperation
 *  1)状态: ready cancelled  executing    finished  这些属性相互独立 只有一个状态yes
 *  注: finished这个状态在操作完成后请及时设置为YES，因为NSOperationQueue所管理的队列中，只有isFinished为YES时才将其移除队列，这点在内存管理和避免死锁很关键。
 *  2)依赖: addDependency  完成每个操作时把isfinished改为yes, 不然后续的操作不会进行
 *  3)执行: 2种:直接start  加入到operationqueue中去
 *
 */
//创建主列队和自定义列队
- (void)operation
{
    //NSOperationQueue
    NSOperationQueue *mainqueue = [NSOperationQueue mainQueue];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        //执行任务
    }];
    [queue addOperation:operation];
    //maxConcurrentOperationCount 为1则为 串行队列
    queue.maxConcurrentOperationCount = 1;
    
    
    
    
    /* 基类: NSOperation   子类: NSBlockOperation, NSInvocationOperation
     通过重写main 或者 start 自定义operation
     注:当实现start时默认执行start 而不执行main
    */
    
//isExecuting 执行   isCancelled 取消状态  isReady 是否准备   isFinished 是否完成  isAsynchronous 同异步
    NSOperation *baseOperation = [[NSOperation alloc] init];
    if (!baseOperation.isExecuting) {
        [baseOperation start];
    }
    if (!baseOperation.isCancelled) {
        [baseOperation cancel];
    }
    
    /**
     *  判断同步 异步
     *  NSOperation提供的isConcurrent可判断是同步还是异步执行。isConcurrent默认值为NO,表示操作与调用线程同步执行  ios7以后为isAsynchronous
     */
    
    if ([UIDevice currentDevice].systemVersion.integerValue > 7.0) {
        if (baseOperation.isAsynchronous) {
            NSLog(@"同步");
        }else{
            NSLog(@"异步");
        }
    }else{
        if (baseOperation.isConcurrent) {
           NSLog(@"同步");
        }else{
            NSLog(@"异步");
        }
    }
    
    
    //任务完成回调 2 种
    baseOperation.completionBlock = ^(){
        NSLog(@"完成了后的回调 执行完毕");
    };
    
    [baseOperation setCompletionBlock:^{
        
    }];
    
    //NSInvocationOperation 通过target方法来进行任务  当有现成的方法时直接用NSInvocationOperation来调用 (默认同步执行)
    NSInvocationOperation *invocation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocation) object:nil];
    
    [invocation start];
    
    
    
    
    //NSBlockOperation是直接继承于NSOperation的子类，它能够并发地执行一个或多个block对象，所有的block都执行完之后,操作才算真正完成。
    NSBlockOperation *blockOperation = [NSBlockOperation blockOperationWithBlock:^{
        
    NSLog(@"这是第一个任务在线程-------1 ：%@执行，isMainThread: %d，isAync: %d",
              [NSThread currentThread],
              [NSThread isMainThread],
              [blockOperation isAsynchronous]);
    }];
    
    //添加任务
    __weak typeof(blockOperation)weakOperation = blockOperation;
    [blockOperation addExecutionBlock:^{
        NSLog(@"这是第二个任务在线程------2：%@执行，isMainThread: %d，isAync: %d",
              [NSThread currentThread],
              [NSThread isMainThread],
              [weakOperation isAsynchronous]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"这是第三个任务在线程-----------3：%@执行，isMainThread: %d，isAync: %d",
              [NSThread currentThread],
              [NSThread isMainThread],
              [weakOperation isAsynchronous]);
    }];
    [blockOperation addExecutionBlock:^{
        NSLog(@"这是第四个任务在线程----------4：%@执行，isMainThread: %d，isAync: %d",
              [NSThread currentThread],
              [NSThread isMainThread],
              [weakOperation isAsynchronous]);
    }];
    [blockOperation addExecutionBlock:^{
        
        //异步执行
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSLog(@"这是第五个任务在线程--------5：%@执行，isMainThread: %d，isAync: %d",
                  [NSThread currentThread],
                  [NSThread isMainThread],
                  [weakOperation isAsynchronous]);
        });
        
    }];
    [blockOperation start];
}

//下载图片
- (void)test1 {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage1:) object:@"http://ww2.sinaimg.cn/bmiddle/612ccd83gw1f1syrm5rzlj20qo0qowjl.jpg"];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperation:operation];
}

- (void)downloadImage1:(NSString *)url {
    NSURL *nsUrl = [NSURL URLWithString:url];
    NSData *data = [[NSData alloc] initWithContentsOfURL:nsUrl];
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _imageView.image = image;
    });
}


- (void)downloadImageWithMyOpertion
{
    MyOpertion * myopertion = [[MyOpertion alloc] initWithUrl:@"http://ww4.sinaimg.cn/thumb180/b8b73ba1gw1f1vjta58rjj20dc0a0wg1.jpg" delegate:self];
    [myopertion main];
//    [myopertion start];
}

- (void)downloadFinishedImage:(UIImage *)image
{
    _imageView.image = image;
}

@end
