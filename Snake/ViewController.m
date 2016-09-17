//
//  ViewController.m
//  Snake
//
//  Created by V.Valentino on 16/9/14.
//  Copyright © 2016年 huyifan. All rights reserved.
//

#import "ViewController.h"
#import "Snake.h"

@interface ViewController ()
@property (nonatomic, strong)Snake *snake;
@property (nonatomic)CGPoint beginPoint;
@property (nonatomic, strong)UIView *controlView;
@property (nonatomic, strong)NSMutableArray *foods;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.foods = [NSMutableArray array];
    
    self.snake = [[Snake alloc]initWithView:self.view];
    
    //添加食物
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(addFoods) userInfo:nil repeats:YES];
    
    
    //碰撞检测
    [NSTimer scheduledTimerWithTimeInterval:1.0/60 target:self selector:@selector(checkingCrash) userInfo:nil repeats:YES];
}

-(void)checkingCrash{
    //取出蛇头
    UIView *headView = [self.snake.bodys lastObject];
    for (UIView *v in self.foods) {
        if (CGRectIntersectsRect(headView.frame, v.frame)) {
            //假装吃掉了食物
            v.center = CGPointMake(headView.center.x - self.snake.speed*self.snake.xOffset, headView.center.y-self.snake.speed*self.snake.yOffset);
            v.layer.cornerRadius = v.bounds.size.width/2;
            v.layer.masksToBounds = YES;
            break;
        }
    }

    

    //取出蛇尾
    UIView *lastView = [self.snake.bodys firstObject];
    
    for (UIView *v in self.foods) {
        if (CGRectIntersectsRect(lastView.frame, v.frame)) {
   
            [self.foods removeObject:v];
            //让蛇增加长度
            [self.snake addBodyWithFoods:v];
            break;
        }
    }
    
    
}
-(void)addFoods{
    UIView *v = [[UIView alloc]initWithFrame:CGRectMake(arc4random()%365, arc4random()%657, 10, 10)];
    
    v.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    [self.view addSubview:v];
    
    [self.foods addObject:v];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *t = [touches anyObject];
    
    self.beginPoint = [t locationInView:self.view];
    
    self.controlView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.controlView.alpha = .5;
    self.controlView.layer.cornerRadius = 25;
    self.controlView.layer.masksToBounds = YES;
    
    [self.view addSubview:self.controlView];
    self.controlView.backgroundColor = [UIColor purpleColor];
    self.controlView.center = self.beginPoint;
    
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *t = [touches anyObject];
    
    CGPoint currentPoint = [t locationInView:self.view];
    
    float x = currentPoint.x-self.beginPoint.x;
    float y = currentPoint.y-self.beginPoint.y;
    
    float xOffset = fabs(x)/(fabs(x)+fabs(y));
    float yOffset = fabs(y)/(fabs(x)+fabs(y));
    if (x<0) {
        xOffset*=-1;
    }
    if (y<0) {
        yOffset*=-1;
    }
    NSLog(@"偏移值x=%f  y=%f",xOffset,yOffset);
    self.snake.xOffset = xOffset;
    self.snake.yOffset = yOffset;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.controlView removeFromSuperview];
}

@end
