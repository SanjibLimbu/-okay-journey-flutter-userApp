import 'package:flutter/material.dart';
import 'package:user_app/model/users_model.dart';

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

  //show whole user card on expansion
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
                    LabelValue(
                      label: 'Name',
                      value:
                          '${user.name.title}. ${user.name.first} ${user.name.last}',
                    ),
                    LabelValue(
                      label: 'Gender',
                      value: user.gender,
                    ),
                    LabelValue(
                      label: 'Email',
                      value: user.email,
                    ),
                    LabelValue(
                      label: 'Phone',
                      value: user.phone,
                    ),
                    LabelValue(
                      label: 'Cell',
                      value: user.cell,
                    ),
                    LabelValue(
                      label: 'DOB',
                      value: user.dob.date.toString().substring(0, 9),
                    ),
                    LabelValue(
                      label: 'Age',
                      value: user.dob.age.toString(),
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
  }
}

class LabelValue extends StatelessWidget {
  const LabelValue({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(label),
        ),
        Expanded(
            flex: 5,
            child: Text(
              value,
              textAlign: TextAlign.left,
            ))
      ],
    );
  }
}
