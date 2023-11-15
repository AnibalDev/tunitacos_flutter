import 'dart:developer';
import 'package:realm/realm.dart';

class MongoRealmsConfig {
  static final MongoRealmsConfig _instance = MongoRealmsConfig._internal();
  late AppConfiguration appConfig;
  late App app;
  late EmailPasswordAuthProvider authProvider;
  late String? _myId;
  late String? _myEmail;
  late int _passwordHash;

  factory MongoRealmsConfig() {
    return _instance;
  }

  String get myId => _myId!;
  String get myEmail => _myEmail!;

  MongoRealmsConfig._internal() {
    appConfig = AppConfiguration('tunitacos-fluttter-usnhj');
    app = App(appConfig);
    authProvider = EmailPasswordAuthProvider(app);
  }
  Future<void> login(Credentials credentials,
      {required Function onLogin,
      required Function onError,
      required int passwordHash}) async {
    try {
      await app.logIn(credentials);
      _passwordHash = passwordHash;
      _myId = app.currentUser?.id;
      _myEmail = app.currentUser?.profile.email;
      log("Log: the user id is : $_myId");
      onLogin();
    } catch (e) {
      onError();
    }
  }

  Future<void> resetPasswordEmail(String email) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    await authProvider.resetPassword(email);
  }

  Future<void> resetPasswordFunction(
      String password, String oldPassword) async {
    EmailPasswordAuthProvider authProvider = EmailPasswordAuthProvider(app);
    if (oldPassword.hashCode != _passwordHash) return;

    await authProvider.callResetPasswordFunction(_myEmail!, password);
  }

  Future<void> createAccount(String email, String password) async {
    await authProvider.registerUser(email, password);
  }
}
