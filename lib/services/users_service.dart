import 'package:http/http.dart' as http;
import 'package:user_app/model/users_model.dart';

class UsersService {
  static Future<List<Result>> getUsersData() async {
    http.Response response = await http.get(
      Uri.parse('https://randomuser.me/api/?results=20'),
    );

    try {
      if (response.statusCode == 200) {
        return userModelFromJson(response.body).results;
      } else {
        return Future.error('Error fetching data');
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}
