//
//  FannyViewContrller.h
//  Block
//
//  Created by 杨晓芬 on 16/3/9.
//  Copyright © 2016年 Fanny. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  定义交换颜色的block
 *
 *  @param id 参数
 */

typedef void(^changeColor) (id);


@interface FannyViewContrller : UIViewController

@property (nonatomic, strong) changeColor backgroundcolor;

@end
