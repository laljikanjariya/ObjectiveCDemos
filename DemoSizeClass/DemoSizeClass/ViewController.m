//
//  ViewController.m
//  DemoSizeClass
//
//  Created by Siya Infotech on 16/06/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    IBOutlet UIImageView* animatedImageView ;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    animatedImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"loadingGif.gif"],
//                                         [UIImage imageNamed:@"loadingGif2.gif"],
//                                         [UIImage imageNamed:@"loadingGif3.gif"],
//                                         [UIImage imageNamed:@"loadingGif4.gif"],
//                                         [UIImage imageNamed:@"loadingGif5.gif"],
//                                         [UIImage imageNamed:@"loadingGif6.gif"],
//                                         [UIImage imageNamed:@"loadingGif7.gif"],
//                                         [UIImage imageNamed:@"loadingGif8.gif"],
//                                         [UIImage imageNamed:@"loadingGif9.gif"],
//                                         [UIImage imageNamed:@"loadingGif10.gif"],
//                                         [UIImage imageNamed:@"loadingGif11.gif"],
//                                         [UIImage imageNamed:@"loadingGif12.gif"],
//                                         [UIImage imageNamed:@"loadingGif13.gif"],
//                                         [UIImage imageNamed:@"loadingGif14.gif"],
//                                         [UIImage imageNamed:@"loadingGif15.gif"],
//                                         [UIImage imageNamed:@"loadingGif16.gif"],
//                                         [UIImage imageNamed:@"loadingGif17.gif"],
//                                         [UIImage imageNamed:@"loadingGif18.gif"],
//                                         [UIImage imageNamed:@"loadingGif19.gif"],
//                                         [UIImage imageNamed:@"loadingGif20.gif"],
//                                         [UIImage imageNamed:@"loadingGif21.gif"],
                                         nil];
    
    NSMutableArray * arrGlobel =[[NSMutableArray alloc] init];
    NSMutableDictionary * dict =[[NSMutableDictionary alloc]init];
    [dict setObject:@"lalji" forKey:@"name"];
    [dict setObject:@"kanjariya" forKey:@"sname"];
    [arrGlobel addObject:dict];
    
    NSMutableArray * arrDisp =[NSMutableArray arrayWithArray:arrGlobel];
    
    NSMutableDictionary * dictChange =[arrDisp firstObject];
    [dictChange setObject:@"rajnikant" forKey:@"name"];
    
    
    animatedImageView.animationDuration = 1.0f;
    animatedImageView.animationRepeatCount = 0;
    [animatedImageView startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
