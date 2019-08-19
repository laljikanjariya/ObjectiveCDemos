//
//  MyPlayerVC.m
//  MySongs
//
//  Created by Siya Infotech on 29/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "MyPlayerVC.h"
#import "DatabaseManager.h"
#import "PlayListVC.h"
#import "SongsListVC.h"
#import "SongPalyVC.h"
#import "SongPlayListEditVC.h"
#include "Constants.h"
#import <AVFoundation/AVFoundation.h>


@interface MyPlayerVC () <ChangeCurrentPlayList>{
    IBOutlet UIView * viewSongPlay;
    IBOutlet NSLayoutConstraint * layActivityHeight;
    IBOutlet UIImageView * imgActivitySucces;
    IBOutlet UILabel * lblActivityMessage;
}
@property (nonatomic, strong) NSManagedObjectContext * managedObjectContext;
@property (nonatomic, strong) AVAudioPlayer * audioPlayer;
@property (nonatomic, strong) PlayLists * defaultPlayList;
@property (nonatomic, weak) PlayListVC * playListVC;
@property (nonatomic, weak) SongsListVC * songsListVC;
@property (nonatomic, strong) SongPalyVC * songPalyVC;
@end

@implementation MyPlayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.managedObjectContext = [DatabaseManager sharedInstance].managedObjectContext;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewActivity:) name:PLAYER_SHOW_ACTIVITY object:nil];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated {
    if (!self.songPalyVC) {
        self.songPalyVC =
        [[UIStoryboard storyboardWithName:@"IpadStoryboard"
                                   bundle:NULL] instantiateViewControllerWithIdentifier:@"SongPalyVC_sid"];
        [self.songPalyVC.view setFrame:viewSongPlay.bounds];
        [viewSongPlay addSubview:self.songPalyVC.view];
    }
}
-(void)viewDidAppear:(BOOL)animated {
    [self sendActivity:@"0" withMessage:@"Please wait scan new songs"];
    [self performSelector:@selector(ScanNewSong:) withObject:nil afterDelay:1.0];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)sendActivity:(NSString *)isSucces withMessage:(NSString *)strMessage{
    NSDictionary * dictActivity = @{@"isSeccue":isSucces,@"message":strMessage};
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYER_SHOW_ACTIVITY object:dictActivity];
}

-(IBAction)ScanNewSong:(id)sender {
    NSLog(@"%@",NSHomeDirectory());
    self.songPalyVC.songDetail.songName = @"Test";
    [self setDefaultPlayList];
    [self addjnewMp3SongsToDatabasePath];
    [self sendActivity:@"1" withMessage:@"scan new songs Succes"];
}
-(IBAction)managePlayList:(id)sender {
    SongPlayListEditVC * songPlayListEditVC =
    [[UIStoryboard storyboardWithName:@"IpadStoryboard"
                               bundle:NULL] instantiateViewControllerWithIdentifier:@"SongPlayListEditVC_sid"];
    
    [self.navigationController pushViewController:songPlayListEditVC animated:YES];
}
-(void)addjnewMp3SongsToDatabasePath{
    NSString * strApppath = NSHomeDirectory();
    NSError * error;
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSArray * arrAllFiles = [fileManager contentsOfDirectoryAtPath:strApppath error:&error];
    
    if (error == nil) {
        NSManagedObjectContext * moc =[QueryManager privateConextFromParentContext:self.managedObjectContext];
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Songs"];
        
        for (NSString * strFileName in arrAllFiles) {
            
            NSString * strFromPath = [NSString stringWithFormat:@"%@/%@",NSHomeDirectory(),strFileName];
            NSString * strToPath = [NSString stringWithFormat:@"%@/Documents/Songs/%@",NSHomeDirectory(),strFileName];
            NSString *escapedUrlString  = [strFromPath stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
;
            if ([[[[NSURL URLWithString:escapedUrlString] pathExtension] lowercaseString] isEqualToString:@"mp3"]) {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",strFileName];
                [fetchRequest setPredicate:predicate];
                NSError *error      = nil;
                NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                                               error:&error];
                
                if (results.count == 0) {
                    Songs * newSong = (Songs *)[QueryManager InsertObject:@"Songs" withContext:moc isSave:NO];
                    NSError *error;

                    NSURL * fileUrl = [[NSURL alloc] initWithString:[strFromPath stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet]];
                    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
                    self.audioPlayer.numberOfLoops = 0;

                    if (self.audioPlayer) {
                        [self.audioPlayer prepareToPlay];
                        newSong.duration = [NSNumber numberWithFloat:self.audioPlayer.duration];
                    }
                    self.audioPlayer = nil;
                    newSong.name = strFileName;
                    newSong.path = strToPath;
                    [newSong addPalylistObject:[moc objectWithID:self.defaultPlayList.objectID]];
                    [fileManager moveItemAtPath:strFromPath toPath:strToPath error:nil];
                }
                NSError *error1 = nil;
                if ([fileManager fileExistsAtPath:strFromPath]) {
                    [fileManager removeItemAtPath:strFromPath error:&error1];
                    NSLog(@"%@",error1);
                }
            }
        }
        [moc save:nil];
        [[DatabaseManager sharedInstance] saveContext];
    }
    else {
        NSLog(@"%@",error);
    }
}
-(void)setDefaultPlayList {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"PlayLists"];
    //    fetchRequest.resultType = NSDictionaryResultType;
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"pname == %@",@"Default"];
    [fetchRequest setPredicate:predicate];
    NSError *error      = nil;
    NSArray *results    = [self.managedObjectContext executeFetchRequest:fetchRequest
                           
                                                                   error:&error];
    
    if (!self.managedObjectContext) {
        self.managedObjectContext = [DatabaseManager sharedInstance].managedObjectContext;
    }
    if (results.count == 0) {
        NSManagedObjectContext * moc =[QueryManager privateConextFromParentContext:self.managedObjectContext];
        self.defaultPlayList = (PlayLists *)[QueryManager InsertObject:@"PlayLists" withContext:moc isSave:NO];
        self.defaultPlayList.pname = @"Default";
        [moc save:nil];
    }
    else {
        self.defaultPlayList = (PlayLists *)[results objectAtIndex:0];
    }
    self.defaultPlayList = [self.managedObjectContext objectWithID:self.defaultPlayList.objectID];
}
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"PlayList"]) {
        self.playListVC = (PlayListVC *)segue.destinationViewController;
        self.playListVC.delegate = self;
    }
    else if([segue.identifier isEqualToString:@"SongList"]) {
        self.songsListVC = (SongsListVC *)segue.destinationViewController;
//        if (!self.defaultPlayList) {
//            [self setDefaultPlayList];
//        }
//        self.songsListVC.selectedPlayList = self.defaultPlayList;
        self.songsListVC.isEditing = FALSE;
    }
}
#pragma mark - ChangeCurrentPlayList -

-(void)changeCurrentPlayListToNew:(PlayLists *)selectedPlayList {
    self.songsListVC.selectedPlayList = selectedPlayList;
}
#pragma mark - Activity View -
-(void)showNewActivity:(NSNotification *)notification {
    layActivityHeight.constant = 60;
    NSDictionary * dictActivity = (NSDictionary *)notification.object;
    if ([[dictActivity objectForKey:@"isSeccue"] isEqualToString:@"1"]) {
        imgActivitySucces.image = [UIImage imageNamed:@"succes.png"];
    }
    else {
        imgActivitySucces.image = [UIImage imageNamed:@"fail.png"];
    }
    lblActivityMessage.text = [dictActivity objectForKey:@"message"];
    [UIView animateWithDuration:0.5 animations:^{[self.view layoutIfNeeded];}];
    [self performSelector:@selector(hideActivity) withObject:nil afterDelay:3.0];
}
-(void)hideActivity{
    layActivityHeight.constant = 0;
    [UIView animateWithDuration:0.5 animations:^{[self.view layoutIfNeeded];}];
}
-(Songs *)getPlaingSong{
    return nil;
}
@end
