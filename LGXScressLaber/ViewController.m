//
//  ViewController.m
//  LGXScressLaber
//
//  Created by 兴哥哥 on 2016/10/27.
//  Copyright © 2016年 123. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{

    CAGradientLayer * gradident;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UILabel *lgxLab = [UILabel new];
    lgxLab.text = @"今天天气不错哦，出去跑着玩去吧";
    [lgxLab sizeToFit];
    lgxLab.center =CGPointMake(200, 100);
    [self.view addSubview:lgxLab];
    
    gradident =[CAGradientLayer layer];
    
    gradident.frame = lgxLab.frame;    // 设置渐变层的颜色，随机颜色渐变
    gradident.colors = @[(id)[self randomColor].CGColor, (id)[self randomColor].CGColor,(id)[self randomColor].CGColor];    // 疑问:渐变层能不能加在label上
    // 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
    
    // 添加渐变层到控制器的view图层上
    [self.view.layer addSublayer:gradident];    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
    // 设置渐变层的裁剪层
    gradident.mask = lgxLab.layer;    // 注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。
    
    
    // 父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。
    lgxLab.frame = gradident.bounds;    // 利用定时器，快速的切换渐变颜色，就有文字颜色变化效果
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(textColorChange)];
    
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];

} // 随机颜色方法
-(UIColor *)randomColor{
        
        CGFloat r = arc4random_uniform(256) / 255.0;               CGFloat g = arc4random_uniform(256) / 255.0;               CGFloat b = arc4random_uniform(256) / 255.0;               return [UIColor colorWithRed:r green:g blue:b alpha:1];
    }    
-(void)textColorChange {
        gradident.colors = @[(id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor,
                                  (id)[self randomColor].CGColor];
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
