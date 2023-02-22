import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/user_data.dart';
import 'package:user_app/model/users_model.dart';
import 'package:user_app/widget/user_card.dart';

class UserList extends StatelessWidget {
  const UserList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Consumer<UserData>(
        builder: (context, userData, child) {
          if (userData.foundUsers.isNotEmpty) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: userData.foundUsers.length,
              itemBuilder: (BuildContext context, int index) {
                Result user = userData.foundUsers[index];
                return UserCard(user: user);
              },
            );
          } else if (userData.isLoading==null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Text('No Result Found'),
            );
          }
        },
      ),
    );
  }
}
