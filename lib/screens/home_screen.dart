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

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.foundUsers,
  });

  final Result foundUsers;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool _expanded = false;

  late Result user = widget.foundUsers;

  final GlobalKey expansionTileKey = GlobalKey();

  void _scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then((value) {
        Scrollable.ensureVisible(keyContext,
            duration: const Duration(milliseconds: 200));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: ExpansionPanelList(
        elevation: 0,
        key: expansionTileKey,
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(user.picture.thumbnail)),
                title: Text(user.login.username),
                subtitle: Text(
                  '${user.name.title}. ${user.name.first} ${user.name.last}',
                ),
              );
            },
            body: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: 16,
              ),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Name'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              '${user.name.title}. ${user.name.first} ${user.name.last}',
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Gender'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              user.gender,
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Email'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              user.email,
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Phone'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              user.phone,
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Cell'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              user.cell,
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('DOB'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              user.dob.date.toString().substring(0, 9),
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Age'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Text(
                              user.dob.age.toString(),
                              textAlign: TextAlign.left,
                            ))
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Expanded(
                          flex: 2,
                          child: Text('Location'),
                        ),
                        Expanded(
                            flex: 5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Country - ${user.location.country}'),
                                Text('State - ${user.location.state}'),
                                Text('City - ${user.location.city}'),
                                Text('Postcode - ${user.location.postcode}'),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          )
        ],
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            _expanded = !_expanded;
            _scrollToSelectedContent(expansionTileKey: expansionTileKey);
          });
        },
      ),
    );
    ;
  }
}
