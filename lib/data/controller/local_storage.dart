import 'package:get_storage/get_storage.dart';

class LocalStorageManager {
  // Initialize the GetStorage instance
  static final GetStorage _box = GetStorage();

  /// Save data to local storage (ensures no unnecessary storage usage)
  static Future<void> saveData(String key, dynamic value) async {
    if (value == null) {
      // Remove if the value is null to avoid unnecessary storage
      await removeData(key);
    } else {
      _box.write(key, value);
    }
  }

  /// Retrieve data from local storage
  static T? readData<T>(String key) {
    return _box.read<T>(key);
  }

  /// Check if a key exists in local storage
  static bool containsKey(String key) {
    return _box.hasData(key);
  }

  /// Remove data by key
  static Future<void> removeData(String key) async {
    if (_box.hasData(key)) {
      await _box.remove(key);
    }
  }

  /// Clear all local storage data (use with caution)
  static Future<void> clearAllData() async {
    await _box.erase();
  }

  /// Debug: Print all stored data
  static void printAllStoredData() {
    print("Stored Keys: ${_box.getKeys()} " +
        "->" +
        "Stored Data: ${_box.getValues()}");
  }

  static String getToken() {
    String? token = LocalStorageManager.readData('token');
    return token ?? '';
  }

  static String getUserId() {
    String? userId = LocalStorageManager.readData('userId');
    return userId ?? '';
  }
}
