import 'package:shared_preferences/shared_preferences.dart';

Future<SharedPreferences> initSharedPreferences() async {
  return await SharedPreferences.getInstance();
}

void setPreferenceValue(String key, dynamic value) async {
  SharedPreferences prefs = await initSharedPreferences();

  print('Set pref for "$key" to ${value.toString()}');

  if (value is bool)
    prefs.setBool(key, value);
  else if (value is double)
    prefs.setDouble(key, value);
  else if (value is int)
    prefs.setInt(key, value);
  else if (value is String)
    prefs.setString(key, value);
  else if (value is List<String>)
    prefs.setStringList(key, value);
  else
    return;
}
