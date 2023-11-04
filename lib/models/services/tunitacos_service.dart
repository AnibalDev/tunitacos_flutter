import 'package:mongo_dart/mongo_dart.dart';
import 'package:tunitacos_flutter/models/services/database_service.dart';

class TacoService extends MongoService {
  @override
  Future getCollection(String collectionName) async {
    dynamic responseJson;
    try {
      var db = await Db.create(mongoUrl);
      await db.open();
      var collection = db.collection(collectionName);
      responseJson = await collection.find().toList();
      db.close();
    } on Exception {
      throw Exception('Fatal Error');
    }
    return responseJson;
  }

  @override
  Future getPedidoState() async {
    dynamic responseJson;
    try {
      var db = await Db.create(mongoUrl);
      await db.open();
      var collection = db.collection('pedidos');
      responseJson = await collection.find().toList();
      db.close();
    } on Exception {
      throw Exception('Fatal Error');
    }
    return responseJson;
  }

  @override
  Future insertCollection(
      String collectionName, Map<String, dynamic> document) async {
    var db = await Db.create(mongoUrl);
    await db.open();
    var usersCollection = db.collection(collectionName);
    await usersCollection.insertOne(document);
  }
}
