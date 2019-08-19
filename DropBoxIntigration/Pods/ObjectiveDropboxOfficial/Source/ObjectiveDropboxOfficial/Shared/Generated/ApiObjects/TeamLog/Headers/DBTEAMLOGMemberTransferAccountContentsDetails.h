///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGMemberTransferAccountContentsDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `MemberTransferAccountContentsDetails` struct.
///
/// Transferred contents of a removed team member account to another member.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGMemberTransferAccountContentsDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// Source participant position in the Participants list.
@property (nonatomic, readonly) NSNumber *srcParticipantIndex;

/// Destination participant position in the Participants list.
@property (nonatomic, readonly) NSNumber *destParticipantIndex;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param srcParticipantIndex Source participant position in the Participants
/// list.
/// @param destParticipantIndex Destination participant position in the
/// Participants list.
///
/// @return An initialized instance.
///
- (instancetype)initWithSrcParticipantIndex:(NSNumber *)srcParticipantIndex
                       destParticipantIndex:(NSNumber *)destParticipantIndex;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `MemberTransferAccountContentsDetails`
/// struct.
///
@interface DBTEAMLOGMemberTransferAccountContentsDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGMemberTransferAccountContentsDetails` instances.
///
/// @param instance An instance of the
/// `DBTEAMLOGMemberTransferAccountContentsDetails` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGMemberTransferAccountContentsDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGMemberTransferAccountContentsDetails *)instance;

///
/// Deserializes `DBTEAMLOGMemberTransferAccountContentsDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGMemberTransferAccountContentsDetails` API object.
///
/// @return An instantiation of the
/// `DBTEAMLOGMemberTransferAccountContentsDetails` object.
///
+ (DBTEAMLOGMemberTransferAccountContentsDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
