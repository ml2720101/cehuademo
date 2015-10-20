//
//  ViewController.m
//  抽屉效果
//
//  Created by 郭志远 on 15/9/8.
//  Copyright (c) 2015年 guozhiyuan. All rights reserved.
//

#import "ViewController.h"
#import "customView.h"
#import "UIView+MyFrame.h"

#define KScreenW [UIScreen mainScreen].bounds.size.width
#define KScreenH [UIScreen mainScreen].bounds.size.height



@interface ViewController ()<UIGestureRecognizerDelegate>

@property (nonatomic ,weak)UIView *view1;

@property (nonatomic ,assign)CGFloat prex;

@property (nonatomic ,weak)UIPanGestureRecognizer *pan;

@property (nonatomic ,assign)CGFloat endX;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [UIApplication sharedApplication].keyWindow.backgroundColor=[UIColor whiteColor];
    
    self.tableView.tableFooterView=[[UIView alloc]init];
    customView *cview=[[customView alloc]initWithFrame:[UIScreen mainScreen].bounds];

    UIPanGestureRecognizer *pan=[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pan:)];
    pan.delegate=self;
    self.pan=pan;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    tap.delegate=self;
    [cview addGestureRecognizer:pan];
    [cview addGestureRecognizer:tap];
   
    self.view1=cview;
    
    [cview.slid addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
//    self.view.frame=CGRectMake(-50, 30, self.view.bounds.size.width, self.view.bounds.size.height);
    [self.navigationController.view addSubview:cview];
    
 
//    [self.tableView insertSubview:cview atIndex:self.view.subviews.count-1];
    [[cview layer] setShadowOffset:CGSizeMake(-10,10)];
    [[cview layer] setShadowRadius:30];
    [[cview layer] setShadowOpacity:1];
    [[cview layer] setShadowColor:[UIColor blackColor].CGColor];
    NSLog(@"%@",NSStringFromCGRect(self.view.frame));
//    NSLog(@"%@",self.view.superview);
//    NSLog(@"%@",self.navigationController.view);
//
}



- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return NO;

}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
 self.view.bounds=CGRectMake(50, -64, self.view.bounds.size.width, self.view.bounds.size.height);    NSLog(@"%@",NSStringFromCGRect(self.view.bounds));
}

-(void)tap:(UIButton *)panreg{
    
//    if (!self.pan.state==UIGestureRecognizerStateBegan) {
//        
   
    NSLog(@"%@",NSStringFromCGRect(self.view1.frame));
    
    [UIView animateWithDuration:0.25 animations:^{
    if (self.view1.frame.origin.x==0
        ) {
//        self.view.transform=CGAffineTransformTranslate(self.view.transform, 50, 0);
  self.view.bounds=CGRectMake(0, -64, self.view.bounds.size.width, self.view.bounds.size.height);
      
        self.view1.frame=CGRectMake(self.view.bounds.size.width-100, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        self.view1.transform=CGAffineTransformMakeScale(1.0, (KScreenH-64*2)/KScreenH);
        
        NSLog(@"%@",NSStringFromCGAffineTransform(self.view.transform));
        self.view.alpha=1.0;

        
    }else{
//           NSLog(@"%@",NSStringFromCGAffineTransform(self.view.transform));
        self.view.bounds=CGRectMake(50, -64, self.view.bounds.size.width, self.view.bounds.size.height);
        self.view.alpha=0.0;
       
        self.view1.transform=CGAffineTransformMakeScale(1.0, 1.0);

        self.view1.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
      //        NSLog(@"%@",NSStringFromCGAffineTransform(self.view.transform));
    }

}];
//    }

}


-(void)pan:(UIPanGestureRecognizer *)reg{


    CGPoint regPoint=[reg translationInView:self.view];
    NSLog(@"%@",NSStringFromCGPoint(regPoint));
   
    CGFloat cx=regPoint.x-self.prex;
    self.prex=regPoint.x;
    
    //
    
    if (regPoint.x<0) {
        if(self.view1.x<=0){
    self.view1.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height); }
        
        
        else{
        
            self.view1.frame=CGRectMake(KScreenW-100+regPoint.x, (KScreenW-100+regPoint.x)/(KScreenW-100)*64, self.view.bounds.size.width, self.view.bounds.size.height*(KScreenH-2*(KScreenW-100+regPoint.x)/(KScreenW-100)*64)/KScreenH);
        
        
        }
        
    }else {

    [UIView animateWithDuration:0.25 animations:^{
        
        if (!self.view1.x==0) {
            
            self.view1.frame=CGRectMake(self.endX+ regPoint.x, (self.endX+ regPoint.x)/(KScreenW-100)*64, self.view.bounds.size.width, self.view.bounds.size.height*(KScreenH-2*(self.endX+ regPoint.x)/(KScreenW-100)*64)/KScreenH);

            
        }else{
        
        self.view1.frame=CGRectMake( regPoint.x, regPoint.x/(KScreenW-100)*64, self.view.bounds.size.width, self.view.bounds.size.height*(KScreenH-2*(regPoint.x)/(KScreenW-100)*64)/KScreenH);
        }
        
        if (self.view1.x>=(KScreenW-100)&&cx>=0) {
            
            
            self.view1.frame= CGRectMake(self.view.bounds.size.width-100, 64, self.view.bounds.size.width, KScreenH-2*64);

            
        }
        
        
//        self.view1.transform=CGAffineTransformMakeScale(1.0, (KScreenH-2*regPoint.x/KScreenW*64)/KScreenH);
        
     //     self.view1.transform=CGAffineTransformTranslate(self.view1.transform, regPoint.x,regPoint.x/[UIScreen mainScreen].bounds.size.width*64);
//
//        NSLog(@"%@",NSStringFromCGRect(self.view1.frame));
//     if (self.view1.transform.tx>(self.view1.bounds.size.width-80)*0.5&&regPoint.x>=0) {
//         
//         self.view1.transform=CGAffineTransformMakeTranslation(self.view.bounds.size.width-80, 64);
//    
//     
//     }else if (self.view1.transform.tx<(self.view1.bounds.size.width-80)*0.5&&regPoint.x<0){
//     
//         self.view1.transform=CGAffineTransformMakeTranslation(0, 0);
//
//     
//     }
      
 }];
    
}
//    }
    if (reg.state==UIGestureRecognizerStateCancelled||reg.state== UIGestureRecognizerStateEnded) {
        
        self.endX=  self.view1.x;
        
        [UIView animateWithDuration:0.25 animations:^{
            
            if (self.view1.x<(KScreenW-100)*0.5) {
                 self.view1.frame=CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
     

            }else{
                
                self.view1.frame= CGRectMake(self.view.bounds.size.width-100, 64, self.view.bounds.size.width, KScreenH-2*64);
                

                
            }
           
           
            
        }];
    }
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        NSLog(@"%lf",self.view1.transform.tx);
        self.view.bounds=CGRectMake(50-50*(self.view1.frame.origin.x)/([UIScreen mainScreen].bounds.size.width-80), -64, self.view.bounds.size.width, self.view.bounds.size.height);
        self.view.alpha=1.0*(self.view1.frame.origin.x)/([UIScreen mainScreen].bounds.size.width-80);
        

        
    }];
    
//    
//    [reg setTranslation:CGPointZero inView:self.view];
//

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
