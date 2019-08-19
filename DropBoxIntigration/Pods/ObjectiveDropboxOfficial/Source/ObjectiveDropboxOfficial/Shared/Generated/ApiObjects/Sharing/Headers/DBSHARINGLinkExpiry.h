///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGLinkExpiry;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `LinkExpiry` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGLinkExpiry : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

/// The `DBSHARINGLinkExpiryTag` enum type represents the possible tag states
/// with which the `DBSHARINGLinkExpiry` union can exist.
typedef NS_ENUM(NSInteger, DBSHARINGLinkExpiryTag) {
  /// Remove the currently set expiry for the link.
  DBSHARINGLinkExpiryRemoveExpiry,

  /// Set a new expiry or change an existing expiry.
  DBSHARINGLinkExpirySetExpiry,

  /// (no description).
  DBSHARINGLinkExpiryOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBSHARINGLinkExpiryTag tag;

/// Set a new expiry or change an existing expiry. @note Ensure the
/// `isSetExpiry` method returns true before accessing, otherwise a runtime
/// exception will be raised.
@property (nonatomic, readonly) NSDate *setExpiry;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "remove_expiry".
///
/// Description of the "remove_expiry" tag state: Remove the currently set
/// expiry for the link.
///
/// @return An initialized instance.
///
- (instancetype)initWithRemoveExpiry;

///
/// Initializes union class with tag state of "set_expiry".
///
/// Description of the "set_expiry" tag state: Set a new expiry or change an
/// existing expiry.
///
/// @param setExpiry Set a new expiry or change an existing expiry.
///
/// @return An initialized instance.
///
- (instancetype)initWithSetExpiry:(NSDate *)setExpiry;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (instancetype)initWithOther;

- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "remove_expiry".
///
/// @return Whether the union's current tag state has value "remove_expiry".
///
- (BOOL)isRemoveExpiry;

///
/// Retrieves whether the union's current tag state has value "set_expiry".
///
/// @note Call this method and ensure it returns true before accessing the
/// `setExpiry` property, otherwise a runtime exception will be thrown.
///
/// @return Whether the union's current tag state has value "set_expiry".
///
- (BOOL)isSetExpiry;

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
/// The serialization class for the `DBSHARINGLinkExpiry` union.
///
@interface DBSHARINGLinkExpirySerializer : NSObject

///
/// Serializes `DBSHARINGLinkExpiry` instances.
///
/// @param instance An instance of the `DBSHARINGLinkExpiry` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGLinkExpiry` API object.
///
+ (nullable NSDictionary *)serialize:(DBSHARINGLinkExpiry *)instance;

///
/// Deserializes `DBSHARINGLinkExpiry` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGLinkExpiry` API object.
///
/// @return An instantiation of the `DBSHARINGLinkExpiry` object.
///
+ (DBSHARINGLinkExpiry *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
