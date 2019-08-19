//
//  SongPalyVC.m
//  MySongs
//
//  Created by Siya Infotech on 30/12/15.
//  Copyright © 2015 Siya Infotech. All rights reserved.
//

#import "SongPalyVC.h"
#import "Constants.h"
#import "Songs+CoreDataProperties.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "DatabaseManager.h"

@interface SongPalyVC () <AVAudioPlayerDelegate> {
    IBOutlet UILabel * lblSongName;
    IBOutlet UIImageView * imgSongImage;
    IBOutlet UISlider * proVolume;
    IBOutlet UISlider * proTimeOfSong;
    IBOutlet UIButton * btnPlay;
    IBOutlet UIButton * btnStop;
    IBOutlet UIButton * btnNext;
    IBOutlet UIButton * btnPrev;
    NSTimer * timer;
    Songs * songInfo;
}
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;

@end

@implementation SongPalyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCurrentPlayingSong:) name:PLAYER_CHANGE_SONG object:nil];
    self.songDetail = [[SongDetail alloc] init];
    [self.songDetail addObserver:self forKeyPath:@"songName" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
-(void)viewWillAppear:(BOOL)animated {
    if (self.audioPlayer == nil) {
        NSString * strSongName = [(NSString *)[NSUserDefaults standardUserDefaults] valueForKey:PLAYER_CURRENT_PLAYING_SONG_NAME];
        if (strSongName) {
//            [[NSNotificationCenter defaultCenter] postNotificationName:PLAYER_CHANGE_SONG object:[[DatabaseManager sharedInstance].managedObjectContext objectWithID:objId]];
        }
    }
}
-(IBAction)ChangeVolume:(UISlider *)sender {
    self.audioPlayer.volume = sender.value;
}
-(IBAction)skeepTo:(UISlider *)sender {
    self.audioPlayer.volume = 0;
    self.audioPlayer.currentTime = sender.value*self.audioPlayer.duration;
    self.audioPlayer.volume = proVolume.value;
}
-(void)setCurrentTimeInProgresView:(id)sender {
    proTimeOfSong.value = self.audioPlayer.currentTime/self.audioPlayer.duration;
}
-(IBAction)btnNextSongTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYER_CHANGE_NEXT_SONG object:songInfo.objectID];
}

-(IBAction)btnPrevSongTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:PLAYER_CHANGE_PREV_SONG object:songInfo.objectID];
}
-(IBAction)btnPlaySongTapped:(UIButton *)sender {
    if (sender.selected) {
        [self.audioPlayer stop];
    }
    else {
        [self.audioPlayer play];
    }
    sender.selected = !sender.selected;
}
-(void)changeCurrentPlayingSong:(NSNotification *) notification {
    songInfo = (Songs *)notification.object;
    [[NSUserDefaults standardUserDefaults] setObject:songInfo.name forKey:PLAYER_CURRENT_PLAYING_SONG_NAME];
    [timer invalidate];
    timer = nil;
    NSError *error;
    NSString * strFromPath = [NSString stringWithFormat:@"%@/Documents/Songs/%@",NSHomeDirectory(),songInfo.name];
    strFromPath = [strFromPath stringByAddingPercentEncodingWithAllowedCharacters:NSCharacterSet.URLQueryAllowedCharacterSet];
    lblSongName.text = songInfo.name;
    NSURL * fileUrl = [[NSURL alloc] initWithString:strFromPath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:&error];
    self.audioPlayer.numberOfLoops = 0;
    self.audioPlayer.delegate = self;
    if (self.audioPlayer == nil) {
        NSLog(@"AudioPlayer did not load properly: %@", [error description]);
    } else {
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        self.audioPlayer.volume = proVolume.value;
    }
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    btnPlay.selected = TRUE;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setImage];
    });
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(setCurrentTimeInProgresView:) userInfo:nil repeats:YES];
}
-(void)setImage{
//    @try {
//        NSString *filePath = songInfo.path;
//        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
//        
//        AVAsset *asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
//        
//        NSArray *keys = [NSArray arrayWithObjects:@"commonMetadata", nil];
//        [asset loadValuesAsynchronouslyForKeys:keys completionHandler:^{
//            NSArray *artworks = [AVMetadataItem metadataItemsFromArray:asset.commonMetadata
//                                                               withKey:AVMetadataCommonKeyArtwork
//                                                              keySpace:AVMetadataKeySpaceCommon];
//            
//            for (AVMetadataItem *item in artworks) {
//                if ([item.keySpace isEqualToString:AVMetadataKeySpaceID3]) {
//                    NSDictionary *dict = [item.value copyWithZone:nil];
//                    imgSongImage.image = [UIImage imageWithData:[dict objectForKey:@"data"]];
//                } else if ([item.keySpace isEqualToString:AVMetadataKeySpaceiTunes]) {
//                    imgSongImage.image = [UIImage imageWithData:[item.value copyWithZone:nil]];
//                }
//            }
//        }];
//    }
//    @catch (NSException *exception) {
//        
//    }
//    @finally {
//        
//    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [self btnNextSongTapped:nil];
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    
}

@end
