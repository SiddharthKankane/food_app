import 'package:food_app/helpers/db_helper.dart';

class AuthService {
  // Demo credentials
  static const String demoUsername = "testkraft";
  static const String demoPassword = "testkraft";

  static Future<bool> register(String username, String password, String email, String phone, String address) async {
    try {
      await DBHelper.insert('users', {
        'username': username,
        'password': password,
        'email': email,
        'phone': phone,
        'address': address,
      });
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<Map<String, dynamic>?> login(String username, String password) async {
    // 1. Check for hardcoded demo account first
    if (username == demoUsername && password == demoPassword) {
      return {
        'id': 'demo_1',
        'username': demoUsername,
        'email': 'demo@testkraft.com',
        'phone': '1234567890',
        'address': 'Delhi, India',
      };
    }

    // 2. Otherwise, check the local SQL database for registered users
    final db = await DBHelper.database();
    final result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, password],
    );
    
    if (result.isNotEmpty) {
      return result.first;
    }
    
    return null;
  }
}
