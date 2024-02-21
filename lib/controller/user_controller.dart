import 'package:get/get.dart';
import 'package:hegra_holdings/models/user_model.dart';
import 'package:hegra_holdings/repository/user_repository.dart';

final UserRepo = Get.put(UserRepository());

void createUser(UserModel user) {
  UserRepo.createUser(user);
}
