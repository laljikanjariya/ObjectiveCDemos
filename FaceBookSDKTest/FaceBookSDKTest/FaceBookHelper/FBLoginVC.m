//
//  FBLoginVC.m
//  FaceBookSDKTest
//
//  Created by Siya9 on 07/07/16.
//  Copyright © 2016 Siya9. All rights reserved.
//

#import "FBLoginVC.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@interface FBLoginVC ()
@property (nonatomic, weak) IBOutlet UIButton * btnFaceBook;
@property (nonatomic, weak) IBOutlet UIButton * btnFaceBookpost;
@property (nonatomic, weak) IBOutlet UIImageView * imgImage;
@property (nonatomic, weak) IBOutlet UILabel * lblFirstName;
@property (nonatomic, weak) IBOutlet UILabel * lblLastName;
@end

@implementation FBLoginVC
+(instancetype)getViewFromStoryBoard{
    return (FBLoginVC *)[[UIStoryboard storyboardWithName:@"Main" bundle:NULL] instantiateViewControllerWithIdentifier:@"FBLoginVC_sid"];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self changeFaceBookLoginStatus];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)LoginToFacebook:(UIButton *)sender{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    login.loginBehavior = FBSDKLoginBehaviorWeb;
    if ([FBSDKAccessToken currentAccessToken]) {
        [login logOut];
        [self changeFaceBookLoginStatus];
    }
    else{
        [login
         logInWithReadPermissions: @[@"public_profile"]
         fromViewController:self
         handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
             [self changeFaceBookLoginStatus];
         }];
    }
}
-(IBAction)btnPostInFaceBook:(UIButton *)sender{
    self.FBLoginVCPostblock(self);
}
-(void)changeFaceBookLoginStatus{
    NSString * strButtonTitle = @"Login In";
    if ([FBSDKAccessToken currentAccessToken]) {
        strButtonTitle = @"Logout";
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"first_name, last_name, picture.type(large), email, name, id, gender"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 NSDictionary * dictUserInfo = (NSDictionary *)result;
                 _lblFirstName.text = dictUserInfo[@"first_name"];
                 _lblLastName.text = dictUserInfo[@"last_name"];
                 _btnFaceBookpost.hidden = FALSE;
                 dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.001 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                     NSString * strUrl = dictUserInfo[@"picture"][@"data"][@"url"];
                     _imgImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]]];
                 });
//
//                 
//                 NSString *previewPropertyName = @"my_namespace:my_object";
//                 
//                 NSDictionary *objectProperties = @{
//                                                    @"og:type" : @"my_namespace:my_object",
//                                                    @"og:title": @"A title",
//                                                    @"og:description" : @"A description",
//                                                    };
//                 FBSDKShareOpenGraphObject *object = [FBSDKShareOpenGraphObject objectWithProperties:objectProperties];
//                 
//                 FBSDKShareOpenGraphAction *action = [[FBSDKShareOpenGraphAction alloc] init];
//                 action.actionType = @"my_namespace:my_action";
//                 [action setObject:object forKey:previewPropertyName];
//                 
//                 FBSDKShareOpenGraphContent *content = [[FBSDKShareOpenGraphContent alloc] init];
//                 content.action = action;
//                 content.previewPropertyName = previewPropertyName;
//                 
//                 FBSDKSendButton *button = [[FBSDKSendButton alloc] init];
//                 button.shareContent = content;
//                 
//                 [self.view addSubview:button];
//                 
             }
         }];
    }
    else {
        _lblFirstName.text = @"First name";
        _lblLastName.text = @"Last name";
        _imgImage.image = [UIImage imageNamed:@"defaultProfileImage.jpg"];
        _btnFaceBookpost.hidden = FALSE;
    }
    [_btnFaceBook setTitle:strButtonTitle forState:UIControlStateNormal];
}
@end
