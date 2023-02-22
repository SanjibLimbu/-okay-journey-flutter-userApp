import 'package:connectivity_plus/connectivity_plus.dart';
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
    callConnectionCheck();

    super.initState();
  }

  bool? checkConnection;

  //check connection;
  callConnectionCheck() async {
    Provider.of<UserData>(context, listen: false).getUserData();
    ConnectivityResult connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        checkConnection = false;
      });
    } else {
      setState(() {
        checkConnection = true;
      });
    }
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
            children: [
              const SizedBox(
                height: 10,
              ),
              //search field
              const SearchWidget(),
              const SizedBox(
                height: 15,
              ),

              if (checkConnection == true)
                const UserList()
              else
                Expanded(
                  child: Center(
                    child: ListTile(
                      title: const Text(
                        'No Connection.',
                        textAlign: TextAlign.center,
                      ),
                      subtitle: TextButton(
                        onPressed: () {
                          callConnectionCheck();
                        },
                        child: const Text('Refresh'),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
