// import 'dart:convert';
// import 'dart:io';

// class Item {
//   final String name;
//   final String code;
//   final int quantity;
//   final int price;
//   final String imagePath;

//   Item({
//     required this.name,
//     required this.code,
//     required this.quantity,
//     required this.price,
//     required this.imagePath,
//   });

//   Map<String, dynamic> toJson() {
//     return {
//       'name': name,
//       'code': code,
//       'quantity': quantity,
//       'price': price,
//       'imagePath': imagePath,
//     };
//   }

//   Future<void> saveToFile(String filePath) async {
//     // Convert item to JSON object
//     Map<String, dynamic> jsonItem = toJson();

//     // Convert JSON object to JSON string
//     String jsonString = jsonEncode(jsonItem);

//     // Write JSON string to file
//     File file = File(filePath);
//     await file.writeAsString(jsonString);
//   }
// }
