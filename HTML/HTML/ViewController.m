//
//  ViewController.m
//  HTML
//
//  Created by Siya9 on 19/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet UIWebView * obj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * html = [[NSBundle mainBundle] pathForResource:@"emailReceipt" ofType:@"html"];
    html = [NSString stringWithContentsOfFile:html encoding:NSUTF8StringEncoding error:nil];
    
    NSString *fileURLString = [[[NSBundle mainBundle] URLForResource:@"zigzag" withExtension:@"png"] absoluteString];
    html = [html stringByReplacingOccurrencesOfString:@"$$IMG_HTML$$" withString:[NSString stringWithFormat:@"src=\"%@\"",fileURLString]];
    
    [self.obj loadHTMLString:html baseURL:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
