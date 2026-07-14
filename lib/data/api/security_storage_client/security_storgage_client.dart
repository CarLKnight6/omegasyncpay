// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import 'security_storage_client_type.dart';

// class SecurityStorageClient implements SecurityStorageClientType {
  
//     // Create an instance and enable secure encryption:
//   // static const storage = FlutterSecureStorage(
//   //     aOptions: AndroidOptions(encryptedSharedPreferences: true));


//    static const storage = FlutterSecureStorage();

//   @override
//   Future<void> saveData(String key, String value) async {
//     return await storage.write(key: key, value: value);
//   }

//   @override
//   Future<String?> readData(String key) async {
    
//       return  await storage.read(key: key);

//   }

//    @override
//   Future<Map<String, String>> readAllData(String key) async {
//     return await storage.readAll();
//   }

//    @override
//   Future<bool> containsData(String key) async {
//     return await storage.containsKey(key: key);
//   }

//    @override
//   Future<void> deleteData(String key) async {
//     await storage.delete(key: key);
//   }

//    @override
//   Future<void> deleteAllData() async {
//     await storage.deleteAll();
//   }
  
// }