import 'package:http/http.dart' as http;

Future<void> loadEnv() async {
  final response = await http.get(Uri.parse('assets/.env'));
  if (response.statusCode == 200) {
    // Process your .env file contents here
    print(response.body);
  } else {
    throw Exception('Failed to load .env');
  }
}
