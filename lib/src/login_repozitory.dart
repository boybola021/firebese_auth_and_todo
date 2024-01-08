import 'dart:convert';
import 'package:firebase_auth_and_todo/src/user_model.dart';

import 'local_data_source.dart';

abstract class UserRepository{
  Future<bool> storeUser(UserSRC login);
 // Future<bool> storeHistory(List<OrderModelProduct> history);
  //Future<bool> deleteProduct();
  List<UserSRC> readUser();
  Future<bool> deleteUser();
  Future<bool> clareCache();
  Future<bool> editUser(UserSRC login);
}
class UserRepositoryImplements implements UserRepository{
  final LocalDataSource dataSource;
  const UserRepositoryImplements({required this.dataSource});
  @override
  Future<bool> clareCache() {
    return dataSource.remove(StorageLogInKey.login);
  }

  @override
  Future<bool> deleteUser() {
    final list = readUser();
    list.clear();
    final json = list.map((e) => e.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageLogInKey.login, data);
  }


  @override
  List<UserSRC> readUser() {
    String data = dataSource.read(StorageLogInKey.login) ?? "[]";
    final json = jsonDecode(data) as List;
    return json.map((item) => UserSRC.fromJson(item as Map<String,Object?>)).toList();
  }

  @override
  Future<bool> storeUser(UserSRC login) async{
    final list = readUser();
    list.clear();
    list.add(login);
    final json = list.map((login) => login.toJson()).toList();
    final data = jsonEncode(json);
    return await dataSource.store(StorageLogInKey.login, data);
  }

  @override
  Future<bool> editUser(UserSRC login) {
    final list = readUser();
    list.removeWhere((element) => element.id == login.id);
    list.add(login);
    final json = list.map((e) => e.toJson()).toList();
    final data = jsonEncode(json);
    return dataSource.store(StorageLogInKey.login, data);
  }

  // @override
  // Future<bool> storeHistory(List<OrderModelProduct>? history)async{
  //   final list = readUser();
  //   final cart = history ?? [];
  //   list.first.history.addAll(cart);
  //   final json = list.map((login) => login.toJson()).toList();
  //   final data = jsonEncode(json);
  //   return  await dataSource.store(StorageLogInKey.login, data);
  // }
  //
  // @override
  // Future<bool> deleteProduct()async{
  //   final list = readUser();
  //   list.first.history.clear();
  //   final json = list.map((e) => e.toJson()).toList();
  //   final data = jsonEncode(json);
  //   return dataSource.store(StorageLogInKey.login, data);
  // }
}