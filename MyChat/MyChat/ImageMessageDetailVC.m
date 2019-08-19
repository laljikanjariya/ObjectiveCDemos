//
//  ImageMessageDetailVC.m
//  MyChat
//
//  Created by Siya9 on 20/08/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "ImageMessageDetailVC.h"

@import AVFoundation;
@import AVKit;

@interface ImageMessageDetailVC ()

@property (nonatomic, weak) IBOutlet UIScrollView * objScrollView;
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIView * viewPlayerBG;

@end

@implementation ImageMessageDetailVC

-(void)viewWillAppear:(BOOL)animated{
    
    if (self.objMessages.messageType.intValue == MessageTypeImage) {
        self.objScrollView.hidden = FALSE;
        self.imageView.image = [[UIImage alloc]initWithData:[[NSData alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[self.objMessages.msgURL getUserMessageMediaImagesPath]]]];
    }
    else{
//        https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4
        self.viewPlayerBG.hidden = FALSE;
//        NSURL *url = [[NSURL alloc] initWithString:@"https://s3-eu-west-1.amazonaws.com/alf-proeysen/Bakvendtland-MASTER.mp4"];
        
        // create a player view controller
        AVPlayer * player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:[self.objMessages.msgURL getUserMessageMediaVideoPath]]];
        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
        
        [self addChildViewController:controller];
        [self.viewPlayerBG addSubview:controller.view];
        
        controller.view.frame = self.viewPlayerBG.bounds;
        controller.player = player;
        controller.showsPlaybackControls = YES;
        player.closedCaptionDisplayEnabled = NO;
        [player pause];
        [player play];

    }
}

-(IBAction)backBtnTapped:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
}
@end
