import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_app/model/user_data.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (enteredValue) {
        Provider.of<UserData>(context, listen: false)
            .runUserFilter(enteredValue);
      },
      decoration: InputDecoration(
        labelText: 'Search',
        prefixIcon: const Icon(Icons.search),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF2F2F2),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFF2F2F2),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(5.0),
        ),
        filled: true,
        fillColor: const Color(0xFFF2F2F2),
        border: InputBorder.none,
        contentPadding: const EdgeInsets.fromLTRB(
          15.0,
          15.0,
          15.0,
          15.0,
        ),
      ),
    );
  }
}