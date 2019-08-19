//
//  ViewController.m
//  SpeechFramworkDemo
//
//  Created by Siya9 on 03/01/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import <Speech/Speech.h>

@interface ViewController ()<SFSpeechRecognizerDelegate>
@property (nonatomic, weak) IBOutlet UITextView * txtvInput;
@property (nonatomic, weak) IBOutlet UIButton * btnRecord;
@property (nonatomic, strong) SFSpeechRecognizer * speechRecognizer;
@property (nonatomic, strong) SFSpeechAudioBufferRecognitionRequest *recognitionRequest;
@property (nonatomic, strong) SFSpeechRecognitionTask * recognitionTask;
@property (nonatomic, strong) AVAudioEngine * audioEngine;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.speechRecognizer = [[SFSpeechRecognizer alloc]initWithLocale:([[NSLocale alloc] initWithLocaleIdentifier:@"en-US"])];
    self.speechRecognizer.delegate = self;
    self.audioEngine = [[AVAudioEngine alloc]init];
    [SFSpeechRecognizer requestAuthorization:^(SFSpeechRecognizerAuthorizationStatus status) {
        BOOL isButtonEnabled = false;
        
        switch(status) {  //5
        case SFSpeechRecognizerAuthorizationStatusNotDetermined:
                isButtonEnabled = FALSE;
                NSLog(@"Speech recognition Not Determined");
                break;
        case SFSpeechRecognizerAuthorizationStatusDenied:
                isButtonEnabled = FALSE;
                NSLog(@"User denied access to speech recognition");
                break;
        case SFSpeechRecognizerAuthorizationStatusRestricted:
                isButtonEnabled = FALSE;
                NSLog(@"Speech recognition restricted on this device");
                break;
        case SFSpeechRecognizerAuthorizationStatusAuthorized:
                isButtonEnabled = TRUE;
                NSLog(@"Speech recognition authorized");
                break;
        }
        self.btnRecord.enabled = isButtonEnabled;
    }];
}

// Called when the availability of the given recognizer changes
- (void)speechRecognizer:(SFSpeechRecognizer *)speechRecognizer availabilityDidChange:(BOOL)available {
    self.btnRecord.enabled = available;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)microphoneTapped:(UIButton *)sender{
    if (self.audioEngine.isRunning) {
        [self.audioEngine stop];
        [self.recognitionRequest endAudio];
        sender.enabled = TRUE;
        [sender setTitle:@"Start Recording" forState:UIControlStateNormal];
    }
    else{
        [self startRecording];
        [sender setTitle:@"Stop Recording" forState:UIControlStateNormal];
    }
}
-(void)startRecording{
    if (self.recognitionTask) {
        [self.recognitionTask cancel];
        self.recognitionTask = nil;
    }
    AVAudioSession * adSession = [AVAudioSession sharedInstance];
    NSError * errorRecord;
    NSError * errorModeMeasurement;
    NSError * errorActive;
    [adSession setCategory:AVAudioSessionCategoryRecord error:&errorRecord];
    [adSession setMode:AVAudioSessionModeMeasurement error:&errorModeMeasurement];
    [adSession setActive:TRUE error:&errorActive];
    
    self.recognitionRequest = [[SFSpeechAudioBufferRecognitionRequest alloc]init];
    
    AVAudioInputNode *inputNode = self.audioEngine.inputNode;
    if(!inputNode) {
        NSLog(@"Audio engine has no input node");
    }
    if (!self.recognitionRequest) {
        NSLog(@"Unable to create an SFSpeechAudioBufferRecognitionRequest object");
    }
    self.recognitionRequest.shouldReportPartialResults = TRUE;
    self.recognitionTask = [self.speechRecognizer recognitionTaskWithRequest:self.recognitionRequest resultHandler:^(SFSpeechRecognitionResult * _Nullable result, NSError * _Nullable error) {
        BOOL isFinal = FALSE;
        
        if (result) {
            self.txtvInput.text = result.bestTranscription.formattedString;
            isFinal = result.isFinal;
        }
        if (error != nil || isFinal) {
            [self.audioEngine stop];
            [inputNode removeTapOnBus:0];
            
            self.recognitionRequest = nil;
            self.recognitionTask = nil;
            self.btnRecord.enabled = TRUE;
        }
    }];
    
    AVAudioFormat * recordingFormat = [inputNode outputFormatForBus:0];

    [inputNode installTapOnBus:0 bufferSize:1024 format:recordingFormat block:^(AVAudioPCMBuffer * _Nonnull buffer, AVAudioTime * _Nonnull when) {
        [self.recognitionRequest appendAudioPCMBuffer:buffer];
    }];
    
    [self.audioEngine prepare];
    [self.audioEngine startAndReturnError:nil];
    
    _txtvInput.text = @"Say something, I'm listening!";
}
@end
