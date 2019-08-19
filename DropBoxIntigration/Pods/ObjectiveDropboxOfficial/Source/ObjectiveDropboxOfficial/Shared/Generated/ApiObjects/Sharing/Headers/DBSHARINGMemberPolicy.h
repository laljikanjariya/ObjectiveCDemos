///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGMemberPolicy;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `MemberPolicy` union.
///
/// Policy governing who can be a member of a shared folder. Only applicable to
/// folders owned by a user on a team.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGMemberPolicy : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBSHARINGMemberPolicyTag` enum type represents the possible tag states
/// with which the `DBSHARINGMemberPolicy` union can exist.
typedef NS_ENUM(NSInteger, DBSHARINGMemberPolicyTag) {
  /// Only a teammate can become a member.
  DBSHARINGMemberPolicyTeam,

  /// Anyone can become a member.
  DBSHARINGMemberPolicyAnyone,

  /// (no description).
  DBSHARINGMemberPolicyOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBSHARINGMemberPolicyTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "team".
///
/// Description of the "team" tag state: Only a teammate can become a member.
///
/// @return An initialized instance.
///
- (instancetype)initWithTeam;

///
/// Initializes union class with tag state of "anyone".
///
/// Description of the "anyone" tag state: Anyone can become a member.
///
/// @return An initialized instance.
///
- (instancetype)initWithAnyone;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "team".
///
/// @return Whether the union's current tag state has value "team".
///
- (BOOL)isTeam;

///
/// Retrieves whether the union's current tag state has value "anyone".
///
/// @return Whether the union's current tag state has value "anyone".
///
- (BOOL)isAnyone;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString *)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBSHARINGMemberPolicy` union.
///
@interface DBSHARINGMemberPolicySerializer : NSObject

///
/// Serializes `DBSHARINGMemberPolicy` instances.
///
/// @param instance An instance of the `DBSHARINGMemberPolicy` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGMemberPolicy` API object.
///
+ (nullable NSDictionary *)serialize:(DBSHARINGMemberPolicy *)instance;

///
/// Deserializes `DBSHARINGMemberPolicy` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGMemberPolicy` API object.
///
/// @return An instantiation of the `DBSHARINGMemberPolicy` object.
///
+ (DBSHARINGMemberPolicy *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
