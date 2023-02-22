import 'package:flutter/material.dart';

import 'package:user_app/model/users_model.dart';
import 'package:user_app/widget/user_card_body.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final Result user;

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  final GlobalKey expansionTileKey = GlobalKey();
  bool isExpanded0 = false;

//scroll expanded card to visible
  void scrollToSelectedContent({required GlobalKey expansionTileKey}) {
    final keyContext = expansionTileKey.currentContext;
    if (keyContext != null) {
      Future.delayed(const Duration(milliseconds: 200)).then(
        (value) {
          Scrollable.ensureVisible(keyContext,
              duration: const Duration(milliseconds: 200));
        },
      );
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
        expandedHeaderPadding: EdgeInsets.zero,
        children: [
          ExpansionPanel(
            
            headerBuilder: (context, isExpanded) {
              return ListTile(
                isThreeLine: true,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(widget.user.picture.thumbnail),
                ),
                title: Text(
                  widget.user.login.username,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  '${widget.user.name.title}. ${widget.user.name.first} ${widget.user.name.last}',
                  style: const TextStyle(fontSize: 13),
                ),
              );
            },
            body: UserCardBody(user: widget.user),
            isExpanded: isExpanded0,
            canTapOnHeader: true,
          )
        ],
        expansionCallback: (panelIndex, isExpanded) {
          setState(() {
            isExpanded0 = !isExpanded0;
      
            scrollToSelectedContent(expansionTileKey: expansionTileKey);
          });
        },
      ),
    );
  }
}
