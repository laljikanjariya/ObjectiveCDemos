//
//  ViewController.m
//  SecurityCodeRMS
//
//  Created by Siya9 on 14/04/17.
//  Copyright © 2017 Siya9. All rights reserved.
//

#import "ViewController.h"
#import "NSData+Encryption.h"
#import "zlib.h"
#import "bzlib.h"
#import <zlib.h>
#import <dlfcn.h>
#import "GZIP.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self test];
//    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)test{
    NSMutableDictionary * dictParam = [NSMutableDictionary dictionary];
    dictParam[@"Name"] = @"Lalji";
    dictParam[@"Sname"] = @"Kanjariya";
    
    NSData *testData = [NSJSONSerialization dataWithJSONObject:dictParam options:NSJSONWritingPrettyPrinted error:nil];
    
    NSData * gzippedData = [testData gzippedData];
    
    NSString * strPath = [NSString stringWithFormat:@"%@/asd.txt",NSHomeDirectory()];
    [gzippedData writeToFile:strPath atomically:TRUE];
    
    NSData * gzippedData1 = [NSData dataWithContentsOfFile:strPath];
    
    NSData * gunzippedData = [gzippedData1 gunzippedData];
    
    NSDictionary * result = [NSJSONSerialization JSONObjectWithData:gunzippedData options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];

    NSLog(@"%@",result);
    
    
}

- (void)loadData {
    
    
    // Create Session Configuration Object
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString * url = @"https://rapidrmseast-rapidrmsmodulewise.azurewebsites.net/WcfService/Service.svc/RapidSecureService";
    
    
    NSMutableDictionary * itemparam = [NSMutableDictionary dictionary];
    [itemparam setValue:@"1" forKey:@"BranchId"];
    [itemparam setValue:@"102" forKey:@"RegisterId"];
    
    
    
    NSMutableDictionary * dictParam = [NSMutableDictionary dictionary];
    dictParam[@"ServiceName"] = @"RecallInvoiceList07212015";
    dictParam[@"Parameters"] = [self encriptServiceParam:itemparam];
    
    
    
    
    
    
    // Create Url Request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:
               [NSURL URLWithString:
                [url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]]];;
    
    
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:dictParam options:NSJSONWritingPrettyPrinted error:nil];
    
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)requestData.length] forHTTPHeaderField:@"Content-Length"];

    [request addValue:@"RapidRMS10015" forHTTPHeaderField:@"DBName-Header"];
    
    request.HTTPBody = requestData;
    

    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSMutableDictionary *dicResponse;
        if (data) {
            dicResponse = [self convertResponsetoDictionaryFromData:data];
        }
        NSDictionary *responseDictionary = [dicResponse valueForKey:@"RapidSecureServiceResult"][@"Parameters"];
        NSString * strData = responseDictionary[@"Data"];
        NSData * dataZIP = [strData dataUsingEncoding:NSASCIIStringEncoding];

        NSData * dataUZIP = [dataZIP gunzippedData];
        NSData * descData = [dataUZIP AES256DecryptWithKey:@"c48ce8176ee24f809eb614d3da6be396"];
        NSLog(@"%@",[[NSString alloc]initWithData:descData encoding:NSUTF8StringEncoding]);
        
        
    }] resume];
}

-(NSMutableDictionary *)convertResponsetoDictionaryFromData:(NSData *)data {
    NSMutableDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves) error:nil];
    if (dicResponse && [[dicResponse[@"RapidSecureServiceResult"] valueForKey:@"IsError"] integerValue] == -786) {
        dicResponse = nil;
    }
    return dicResponse;
}

#pragma mark - Encription -

-(NSString *)encriptServiceName:(NSString *)object{
    NSData * encodedData=[self encryptString:object];
    return [encodedData base64EncodedStringWithOptions:0];
}

-(NSString *)encriptServiceParam:(NSDictionary *)object{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSData * encodedData=[self encryptString:jsonString];
    return [encodedData base64EncodedStringWithOptions:0];
}

- (NSData*) encryptString:(NSString*)plaintext{
    return [[plaintext dataUsingEncoding:NSUTF8StringEncoding] AES256EncryptWithKey:@"c48ce8176ee24f809eb614d3da6be396"];
}

@end
