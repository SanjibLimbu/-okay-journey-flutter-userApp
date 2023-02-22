import 'package:flutter/material.dart';
import 'package:user_app/model/users_model.dart';
import 'package:user_app/widget/card_label_value.dart';

class UserCardBody extends StatelessWidget {
  const UserCardBody({
    super.key,
    required this.user,
  });

  final Result user;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              value: '${user.name.title}. ${user.name.first} ${user.name.last}',
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
              value: user.dob.date.toString().substring(0, 10),
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
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
