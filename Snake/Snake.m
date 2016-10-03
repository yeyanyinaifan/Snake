//
//  Snake.m
//  Snake
//
//  Created by tarena on 16/9/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import "Snake.h"

@implementation Snake
- (instancetype)initWithView:(UIView *)view
{
    self = [super init];
    if (self) {
        self.speed = 10;
        self.length = 10;
        self.size = 10;
        //设置初始偏移值 往右移动
        self.xOffset = 1;
        
        self.bodys = [NSMutableArray array];
        
        for (int i=0; i<self.length; i++) {
            UIView *bView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.size, self.size)];
            bView.center = CGPointMake(100+i*5, 100);
            bView.backgroundColor = [UIColor redColor];
            bView.layer.cornerRadius = bView.bounds.size.width/2;
            bView.layer.masksToBounds = YES;
            [view addSubview:bView];
            [self.bodys addObject:bView];
        }
        
        //开timer移动蛇
        [NSTimer scheduledTimerWithTimeInterval:.08 target:self selector:@selector(moveAction) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)moveAction{
    //取出蛇头
    UIView *headView = [self.bodys lastObject];
//    得到蛇头的中心点
    CGPoint headCenter = headView.center;
    
    //根据遥感得到的XY方向的偏移壁纸 设置头的偏移
    headCenter = CGPointMake(headCenter.x+self.xOffset*self.speed, headCenter.y+self.yOffset*self.speed);
    
   
    //移动蛇头
    [UIView animateWithDuration:.2 animations:^{
        headView.center = headCenter;
    }];
    
    
    //遍历蛇的身子 去移动
    for (int i=0; i<self.bodys.count-1; i++) {
      
     
            UIView *b1 = self.bodys[i];
            UIView *b2 = self.bodys[i+1];
        [UIView animateWithDuration:.2 animations:^{
             b1.center = b2.center;
        }];
    }
    
    
    
}


-(void)addBodyWithFoods:(UIView *)food{
    
    food.layer.cornerRadius = food.bounds.size.width/2;
    food.layer.masksToBounds = YES;
    
    UIView *lastView = [self.bodys firstObject];
    //在蛇尾的基础上偏移
    food.center = CGPointMake(lastView.center.x - self.speed*self.xOffset, lastView.center.y-self.speed*self.yOffset);
    
    NSMutableArray *newBodys = [NSMutableArray array];
    [newBodys addObject:food];

//    [self.bodys addObject:food];
    for (UIView *body in self.bodys) {
        [newBodys addObject:body];
    }
    self.bodys = [newBodys mutableCopy];
    
    
    
    
}
@end
