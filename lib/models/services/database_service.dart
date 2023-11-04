abstract class MongoService {
  final String mongoUrl =
      "mongodb+srv://user_node_cafe:zeqnU7-qeznem-wofsir@cluster0.umcsmfi.mongodb.net/tunitacos/?retryWrites=true&w=majority";

  Future<dynamic> getCollection(String collectionName);
  Future<void> insertCollection(
      String collectionName, Map<String, dynamic> document);
  Future<dynamic> getPedidoState();
}
