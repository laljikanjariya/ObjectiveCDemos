///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMLOGShmodelTeamViewDetails;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - API Object

///
/// The `ShmodelTeamViewDetails` struct.
///
/// Opened a team member's link.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMLOGShmodelTeamViewDetails : NSObject <DBSerializable, NSCopying>

#pragma mark - Instance fields

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @return An initialized instance.
///
- (instancetype)initDefault;

- (instancetype)init NS_UNAVAILABLE;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `ShmodelTeamViewDetails` struct.
///
@interface DBTEAMLOGShmodelTeamViewDetailsSerializer : NSObject

///
/// Serializes `DBTEAMLOGShmodelTeamViewDetails` instances.
///
/// @param instance An instance of the `DBTEAMLOGShmodelTeamViewDetails` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMLOGShmodelTeamViewDetails` API object.
///
+ (nullable NSDictionary *)serialize:(DBTEAMLOGShmodelTeamViewDetails *)instance;

///
/// Deserializes `DBTEAMLOGShmodelTeamViewDetails` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMLOGShmodelTeamViewDetails` API object.
///
/// @return An instantiation of the `DBTEAMLOGShmodelTeamViewDetails` object.
///
+ (DBTEAMLOGShmodelTeamViewDetails *)deserialize:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
