import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/user_data.dart';
import 'package:user_app/widget/search_widget.dart';
import 'package:user_app/widget/user_list.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<UserData>(context, listen: false).getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UserApp'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            children: const [
              SizedBox(
                height: 10,
              ),
              //search field
              SearchWidget(),
              SizedBox(
                height: 15,
              ),
              UserList()
            ],
          ),
        ),
      ),
    );
  }
}


