//
//  SongPlayListEditVC.m
//  MySongs
//
//  Created by Siya Infotech on 30/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "SongPlayListEditVC.h"
#import "PlayListEditVC.h"
#import "SongsListEditVC.h"
#import "DatabaseManager.h"

@interface SongPlayListEditVC () <ChangeCurrentPlayList>{
    IBOutlet UIView * viewPlayListBG;
    IBOutlet UIView * viewSongListBG;
}
@property (nonatomic, strong) PlayListEditVC * playListEditVC;
@property (nonatomic, strong) SongsListEditVC * songsListEditVC;
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@end

@implementation SongPlayListEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [DatabaseManager sharedInstance].managedObjectContext;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    self.playListEditVC =
    [[UIStoryboard storyboardWithName:@"IpadStoryboard"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"PlayListEditVC_sid"];
    [self.playListEditVC.view setFrame:viewPlayListBG.bounds];
    self.playListEditVC.delegate = self;
    [viewPlayListBG addSubview:self.playListEditVC.view];
    
    self.songsListEditVC =
    [[UIStoryboard storyboardWithName:@"IpadStoryboard"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"SongsListEditVC_sid"];
    self.songsListEditVC.isEditing = TRUE;
    [self.songsListEditVC.view setFrame:viewSongListBG.bounds];
    [viewSongListBG addSubview:self.songsListEditVC.view];
}
-(IBAction)backToView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ChangeCurrentPlayList -

-(void)changeCurrentPlayListToNew:(PlayLists *)selectedPlayList {
    self.songsListEditVC.selectedPlayList = selectedPlayList;
}

@end
