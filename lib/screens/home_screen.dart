import 'package:flutter/material.dart';
import 'package:user_app/model/users_model.dart';
import 'package:user_app/services/users_service.dart';
import 'package:user_app/widget/user_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Result> _foundUsers = [];

  List<Result> _allUsers = [];
  final GlobalKey expansionTileKey = GlobalKey();

  //calling data form the api
  void getUserData() async {
    _foundUsers = await UsersService.getUsersData();
    _allUsers = List.from(_foundUsers);
    setState(() {});
  }

  // filter function
  void _runUserFilter(String value) async {
    if (value.isEmpty) {
      _foundUsers = _allUsers;
    } else {
      _foundUsers = _allUsers
          .where(
            (user) => user.login.username.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
    }

    setState(() {});
  }

  // item controller
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('UserApp'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              //search field
              Form(
                key: _formKey,
                child: TextFormField(
                  controller: searchController,
                  onChanged: (enteredValue) {
                    _runUserFilter(enteredValue);
                  },
                  decoration: InputDecoration(
                    labelText: 'Search',
                    prefixIcon: const Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF2F2F2),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFF2F2F2),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    filled: true,
                    fillColor: const Color(0xFFF2F2F2),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(
                      20.0,
                      15.0,
                      20.0,
                      15.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),

              Expanded(
                child: _foundUsers.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: _foundUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return UserCard(
                            foundUsers: _foundUsers[index],
                          );
                        })
                    : const Text(
                        'No User found',
                        style: TextStyle(fontSize: 24),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
