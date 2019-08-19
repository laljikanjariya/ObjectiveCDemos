///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMGroupFullInfo;
@class DBTEAMGroupMembersChangeResult;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `GroupMembersChangeResult` struct.
///
/// Result returned by `groupsMembersAdd` and `groupsMembersRemove`.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMGroupMembersChangeResult : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The group info after member change operation has been performed.
@property (nonatomic, readonly) DBTEAMGroupFullInfo *groupInfo;

/// An ID that can be used to obtain the status of granting/revoking group-owned
/// resources.
@property (nonatomic, readonly, copy) NSString *asyncJobId;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param groupInfo The group info after member change operation has been
/// performed.
/// @param asyncJobId An ID that can be used to obtain the status of
/// granting/revoking group-owned resources.
///
/// @return An initialized instance.
///
- (instancetype)initWithGroupInfo:(DBTEAMGroupFullInfo *)groupInfo asyncJobId:(NSString *)asyncJobId;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `GroupMembersChangeResult` struct.
///
@interface DBTEAMGroupMembersChangeResultSerializer : NSObject

///
/// Serializes `DBTEAMGroupMembersChangeResult` instances.
///
/// @param instance An instance of the `DBTEAMGroupMembersChangeResult` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMGroupMembersChangeResult` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMGroupMembersChangeResult *)instance;

///
/// Deserializes `DBTEAMGroupMembersChangeResult` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMGroupMembersChangeResult` API object.
///
/// @return An instantiation of the `DBTEAMGroupMembersChangeResult` object.
///
+ (DBTEAMGroupMembersChangeResult *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END