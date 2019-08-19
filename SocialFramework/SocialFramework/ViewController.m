//
//  ViewController.m
//  SocialFramework
//
//  Created by Siya9 on 17/09/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>

typedef void (^ UIAlertActionHandler)(UIAlertAction *action);

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

-(IBAction)sendinTwitter:(id)sender {
    [self sharePost:@"Hello GM" postImage:[UIImage imageNamed:@"radioMulti_selected"] forServiceType:SLServiceTypeTwitter];
}
-(IBAction)sendinFacebook:(id)sender {
    [self sharePost:@"Hello GM" postImage:[UIImage imageNamed:@"radioMulti_selected"] forServiceType:SLServiceTypeFacebook];
}
//-(void)sendPostInTwitter{
//
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//    {
//        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
//        
//        [tweetSheet setInitialText:@"Lalji"];
//        [tweetSheet addImage:[UIImage imageNamed:@"radioMulti_selected"]];
//        [self presentViewController:tweetSheet animated:YES completion:nil];
//        
//        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
//            
//            switch (result) {
//                case SLComposeViewControllerResultCancelled:{
//                    NSLog(@"Post canceled for twitter.");
//                    break;
//                }
//                case SLComposeViewControllerResultDone:{
//                    NSLog(@"Post successful for twitter.");
//                }
//                    
//                default:
//                    break;
//            }
//            
//            [self dismissViewControllerAnimated:YES completion:nil];
//        };
//        
//    }
//    else
//    {
//        NSLog(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Twitter account setup.");
//    }
//}
//
//
//-(void)sendPostInFacebook{
//    
//    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
//    {
//        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
//        
//        [tweetSheet setInitialText:@"Hello friends"];
//        [tweetSheet addImage:[UIImage imageNamed:@"radioMulti_selected"]];
//        [self presentViewController:tweetSheet animated:YES completion:nil];
//        
//        tweetSheet.completionHandler = ^(SLComposeViewControllerResult result) {
//            
//            switch (result) {
//                case SLComposeViewControllerResultCancelled:{
//                    NSLog(@"Post canceled for Facebook.");
//                    break;
//                }
//                case SLComposeViewControllerResultDone:{
//                    NSLog(@"Post successful for Facebook.");
//                }
//                    
//                default:
//                    break;
//            }
//            
//            [self dismissViewControllerAnimated:YES completion:nil];
//        };
//        
//    }
//    else
//    {
//        NSLog(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one Facebook account setup.");
//    }
//}

-(void)sharePost:(NSString *)sttPostContain postImage:(UIImage *) imgPost forServiceType:(NSString *)serviceType {
    NSString * strServiceType = @"";
    if (serviceType == SLServiceTypeFacebook) {
        strServiceType = @"Facebook";
    }
    else {
        strServiceType = @"Twitter";
    }
    if ([SLComposeViewController isAvailableForServiceType:serviceType])
    {
        SLComposeViewController *sharePost = [SLComposeViewController composeViewControllerForServiceType:serviceType];
        [sharePost setInitialText:sttPostContain];
        [sharePost addImage:imgPost];
        [self presentViewController:sharePost animated:YES completion:nil];
        sharePost.completionHandler = ^(SLComposeViewControllerResult result) {
            switch (result) {
                case SLComposeViewControllerResultCancelled:{
                    NSLog(@"Post canceled for %@.",strServiceType);
                    break;
                }
                case SLComposeViewControllerResultDone:{
                    NSLog(@"Post successful for %@.",strServiceType);
                }
                default:
                    break;
            }
            [self dismissViewControllerAnimated:YES completion:nil];
        };
    }
    else
    {
        NSLog(@"You can't send a tweet right now, make sure your device has an internet connection and you have at least one %@ account setup.",strServiceType);
    }
}
//-(NSString *)getPostContain{
//    NSString *strItemName = [NSString stringWithFormat:@"Item : %@\n",[itemtoPost valueForKey:@"ItemName"]];
//    NSString *strItemBarcode = [NSString stringWithFormat:@"Barcode : %@\n",[itemtoPost valueForKey:@"Barcode"]];
//    NSString *strItemPrice = [NSString stringWithFormat:@"Price : %@\n",[self.rmsDbController applyCurrencyFomatter:[itemtoPost valueForKey:@"SalesPrice"]]];
//    NSString *strItemRemark = [NSString stringWithFormat:@"Remark : %@\n",[itemtoPost valueForKey:@"Remark"]];
//    NSString *strComment = [NSString stringWithFormat:@"Comment : "];
//    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@",strItemName,strItemBarcode,strItemPrice,strItemRemark,strComment];
//}
//-(UIImage *)getPostImage{
//    
//}
@end
