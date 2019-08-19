//
//  WebServiceCall.h
//  NetworkManager
//
//  Created by Siya Infotech on 12/09/15.
//  Copyright (c) 2015 Siya Infotech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebServiceCall : NSObject <NSURLConnectionDelegate>

/*!
 *  call webservice with post methods
 *
 *  @param strUrl          Requset Full url
 *  @param dictParameters  Request Parameters
 *  @param strJSONKey      Server send data key
 *  @param strNotification Riceved Responce Whice Notification
 */
-(void)requestWithPOSTMethodStringUrl:(NSString *)strUrl requestParameters:(NSDictionary *)dictParameters requestJsonKey:(NSString *)strJSONKey sendResponceWithNotificationName:(NSString *) strNotification;


/*!
 *  call webservice with post methods
 *
 *  @param strUrl         Requset Full url
 *  @param dictParameters Request Parameters
 *  @param strJSONKey     Server send data key
 *  @param target         whice class sends responce
 *  @param selecter       whice methods called
 */
-(void)requestWithPOSTMethodStringUrl:(NSString *)strUrl requestParameters:(NSDictionary *) dictParameters requestJsonKey:(NSString *)strJSONKey sendResponceTarget:(id) target andSelecter:(SEL)selecter;

/*!
 *  url encode if needed
 *
 *  @param strUrl unencoded url
 *
 *  @return encoded url
 */
+ (NSString *)urlEncodeValue:(NSString *)strUrl;

@end
