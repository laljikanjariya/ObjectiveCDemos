//
//  ViewController.m
//  ShareExtension
//
//  Created by Siya9 on 30/05/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    for (NSItemProvider* itemProvider in ((NSExtensionItem*)self.extensionContext.inputItems[0]).attachments )
    {
        if([itemProvider hasItemConformingToTypeIdentifier:@"public.image"])
        {
            [itemProvider loadItemForTypeIdentifier:@"public.image" options:nil completionHandler:
             ^(id<NSSecureCoding> item, NSError *error)
             {
                 UIImage *sharedImage = nil;
                 if([(NSObject*)item isKindOfClass:[NSURL class]])
                 {
                     sharedImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:(NSURL*)item]];
                 }
                 if([(NSObject*)item isKindOfClass:[UIImage class]])
                 {
                     sharedImage = (UIImage*)item;
                 }
             }];
        }
    }
}
@end
