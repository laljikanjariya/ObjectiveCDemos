//
//  TabVC.m
//  ContainerDemo
//
//  Created by Siya9 on 15/09/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "TabManagerVC.h"
#import "Tab1VC.h"
#import "Tab2VC.h"

@interface TabManagerVC (){
    BOOL isAnimate;
    int currentIndex;
}

@property (nonatomic,weak) IBOutlet UIView * cv;
@property (nonatomic,weak) UIViewController * currentView;
@end

@implementation TabManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isAnimate = FALSE;
    currentIndex = 0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeView:(UIButton *)sender {
    UIViewController * newVC;
    if (sender.tag != currentIndex) {
        if (sender.tag == 1) {
            newVC = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"Tab1VC"];
        }
        else if (sender.tag == 2) {
            newVC = [[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"Tab2VC"];
        }
        else if (sender.tag == 3) {
            isAnimate = !isAnimate;
        }
        if (newVC) {
            if (isAnimate) {
                [self cycleFromViewController:self.currentView toViewController:newVC withNewIndex:(int)sender.tag];
            }
            else{
                currentIndex = sender.tag;
                [self hideContentController:self.currentView];
                [self displayContentController:newVC];
            }
        }
    }
}

- (void) displayContentController: (UIViewController*) content {
    [self addChildViewController:content];
    content.view.frame = self.cv.bounds;
    [self.cv addSubview:content.view];
    [content didMoveToParentViewController:self];
    self.currentView = content;
}
- (void) hideContentController: (UIViewController*) content {
    [content willMoveToParentViewController:nil];
    [content.view removeFromSuperview];
    [content removeFromParentViewController];
}
- (void)cycleFromViewController: (UIViewController*) oldVC toViewController: (UIViewController*) newVC withNewIndex:(int)newIndex {
    // Prepare the two view controllers for the change.
    [oldVC willMoveToParentViewController:nil];
    [self addChildViewController:newVC];
    
    CGRect startFrame;
    CGRect endFrame;
    if (currentIndex < newIndex) { //next
        startFrame = oldVC.view.bounds;
        startFrame.origin.x = startFrame.size.width;
        newVC.view.frame = startFrame;
        endFrame = oldVC.view.bounds;
        endFrame.origin.x = -endFrame.size.width;
    }
    else {//prev
        startFrame = oldVC.view.bounds;
        startFrame.origin.x = -startFrame.size.width;
        newVC.view.frame = startFrame;
        endFrame = oldVC.view.bounds;
        endFrame.origin.x = endFrame.size.width;
    }
    
    // Queue up the transition animation.
    [self transitionFromViewController: oldVC toViewController: newVC
                              duration: 0.25 options:0
                            animations:^{
                                // Animate the views to their final positions.
                                newVC.view.frame = oldVC.view.frame;
                                oldVC.view.frame = endFrame;
                            }
                            completion:^(BOOL finished) {
                                // Remove the old view controller and send the final
                                // notification to the new view controller.
                                [oldVC removeFromParentViewController];
                                [newVC didMoveToParentViewController:self];
                                self.currentView = newVC;
                                currentIndex = newIndex;
                            }];
}
@end
