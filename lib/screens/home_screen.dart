import 'package:flutter/material.dart';
import 'package:user_app/model/users_model.dart';
import 'package:user_app/services/users_service.dart';

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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field can\'t be empty';
                    }
                    return null;
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
                    // prefixIcon: const Icon(Icons.menu),
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
                          return UserCard(foundUsers: _foundUsers[index]);
                        })
                    : const Text(
                        'No results found',
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

class UserCard extends StatefulWidget {
  const UserCard({super.key, required this.foundUsers});

  final Result foundUsers;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _expanded = false;

  late Result user = widget.foundUsers;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: ExpansionPanelList(
        elevation: 0,
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(

                leading: Image.network(user.picture.thumbnail),
                title: Text(user.login.username),
                subtitle: Text('${user.name.title}. ${user.name.first} ${user.name.last}'),
              );
            },
            body: Column(
              children: [],
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          )
        ],
        expansionCallback: (panelIndex, isExpanded) {
          _expanded = !_expanded;
          setState(() {});
        },
      ),
    );
    ;
  }
}
