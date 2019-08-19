///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGPaperContentArchiveDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `PaperContentArchiveDetails` struct.
///
/// Archived Paper doc or folder.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGPaperContentArchiveDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Event unique identifier.
@property (nonatomic, readonly, copy) NSString *eventUuid;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param eventUuid Event unique identifier.
///
/// @return An initialized instance.
///
- (instancetype)initWithEventUuid:(NSString *)eventUuid;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `PaperContentArchiveDetails` struct.
///
@interface DBTEAMLOGPaperContentArchiveDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGPaperContentArchiveDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGPaperContentArchiveDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGPaperContentArchiveDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGPaperContentArchiveDetails *)instance;

///
/// Deserializes `DBTEAMLOGPaperContentArchiveDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGPaperContentArchiveDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGPaperContentArchiveDetails`
/// object.
///
+ (DBTEAMLOGPaperContentArchiveDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
