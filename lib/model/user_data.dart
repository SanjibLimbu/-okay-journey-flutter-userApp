import 'package:flutter/material.dart';
import 'package:user_app/model/users_model.dart';
import 'package:user_app/services/users_service.dart';

class UserData extends ChangeNotifier {
  List<Result> foundUsers = [];

  List<Result> allUsers = [];

  //calling data form the api
  void getUserData() async {
    foundUsers = await UsersService.getUsersData();
    allUsers = List.from(foundUsers);
    notifyListeners();
  }

  // filter function
  void runUserFilter(String value) async {
    if (value.isEmpty) {
      foundUsers = allUsers;
    } else {
      foundUsers = allUsers
          .where(
            (user) => user.login.username.toLowerCase().startsWith(
                  value.toLowerCase(),
                ),
          )
          .toList();
    }

    notifyListeners();
  }
}
