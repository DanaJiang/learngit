//
//  ViewController.m
//  JQ_DynamicAnimator
//
//  Created by Midfar Sun on 2018/8/30.
//  Copyright © 2018年 Midfar Sun. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    UIDynamicAnimator *_dynamicAnimator;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat kWidth = self.view.bounds.size.width;
    
    self.view.backgroundColor = UIColor.whiteColor;
    UICollisionBehavior *collisionBehavior = [UICollisionBehavior new];
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
        UIDynamicItemBehavior *dynamicItemBehavior = ({
            UIDynamicItemBehavior *behavior = [UIDynamicItemBehavior new];
            behavior.elasticity = 0;
            behavior.friction = 0;
            behavior.density = 1;
            behavior.resistance = 0;
            behavior.allowsRotation = NO;
            behavior.angularResistance = 0;
            
            behavior;
        });

    __block UIDynamicItemBehavior *blockDynamicItemBehavior = dynamicItemBehavior;
    __block UICollisionBehavior *blockCollisionBehavior = collisionBehavior;
    
    UIView *(^itemBlock)(UIColor *)  =  ^UIView *(UIColor *color){
        CGFloat random = arc4random_uniform(kWidth - 20.f);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(random, random, 60.f, 60.f)];
        view.backgroundColor = color;
        view.layer.cornerRadius = 30;
        view.layer.masksToBounds = YES;
        [self.view addSubview:view];
    
        //碰撞行为
        [blockCollisionBehavior addItem:view];
        
        //动力系统
        CGFloat velocity = (CGFloat)arc4random_uniform(50.f) + 15;
        [blockDynamicItemBehavior addItem:view];
        [blockDynamicItemBehavior addLinearVelocity:CGPointMake(velocity,velocity) forItem:view];
        [blockDynamicItemBehavior addAngularVelocity:15 forItem:view];
        
        return view;
    };
    
    itemBlock(UIColor.redColor);
    itemBlock(UIColor.blueColor);
    itemBlock(UIColor.greenColor);
    itemBlock(UIColor.yellowColor);
    
}

@end
