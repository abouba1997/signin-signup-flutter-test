import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'user.dart';

class UserStorage {
  Future<List<User>> readUserData() async {
    List<User> users = [];
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/users.txt');
      List<String> lines = await file.readAsLines();

      for (String line in lines) {
        List<String> parts = line.split(',');
        if (parts.length == 2) {
          users.add(User(username: parts[0], password: parts[1]));
        }
      }
    } catch (e) {
      print("Impossible de lire ");
    }
    return users;
  }

  Future<File> writeUserData(List<User> users) async {
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/users.txt');
      final lines =
          users.map((user) => '${user.username},${user.password}').toList();
      return file.writeAsString(lines.join('\n'));
    } catch (e) {
      print("Couldn't write to file");
      rethrow;
    }
  }
}
