//
//  Snake.h
//  Snake
//
//  Created by tarena on 16/9/6.
//  Copyright © 2016年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Snake : NSObject
@property (nonatomic)int length;
@property (nonatomic)float speed;
@property (nonatomic)float size;

@property (nonatomic)float xOffset;
@property (nonatomic)float yOffset;

@property (nonatomic, strong)NSMutableArray *bodys;
- (instancetype)initWithView:(UIView *)view;

- (void)addBodyWithFoods:(UIView *)food;
@end
