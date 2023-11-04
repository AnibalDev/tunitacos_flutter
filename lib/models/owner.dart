import 'package:tunitacos_flutter/connection/mongo_realms_config.dart';

class OwnerModel {
  late String ownerType;
  late String? ownerId;

  OwnerModel({required this.ownerId, required this.ownerType});

  factory OwnerModel.fromMap(Map<String, dynamic> map) {
    return OwnerModel(
      ownerId: map['OwnerId'] as String?,
      ownerType: map['OwnerType'] as String,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'OwnerType': ownerType,
      'OwnerId': MongoRealmsConfig().myId,
    };
  }
}
