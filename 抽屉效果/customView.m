//
//  customView.m
//  抽屉效果
//
//  Created by 郭志远 on 15/9/8.
//  Copyright (c) 2015年 guozhiyuan. All rights reserved.
//

#import "customView.h"

@implementation customView

-(instancetype)initWithFrame:(CGRect)frame{

    if (self=[super initWithFrame:frame]) {
    
        
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
        [btn setTitle:@"pre" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:btn];
        self.slid=btn;
        self.backgroundColor=[UIColor blueColor];
        
        
    }

    return self;
}
@end
