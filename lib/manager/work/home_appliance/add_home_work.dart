import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'home_task_list.dart';
import '../../../provider/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AddHomeWorkPage extends StatefulWidget {
  @override
  _AddHomeWorkPageState createState() => _AddHomeWorkPageState();
}

class _AddHomeWorkPageState extends State<AddHomeWorkPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _descriptionController = TextEditingController();

  List<dynamic> _dropdownData = [];
  String? _selectedType;
  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedNumber;
  String _selectedCategory = 'Энгийн хугацаанд';

  List<String> _brands = [];
  List<String> _models = [];
  List<String> _numbers = [];

  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    _loadDropdownData();
  }

  Future<void> _loadDropdownData() async {
    String jsonString = await rootBundle.loadString('assets/json/dropdown_values.json');
    setState(() {
      _dropdownData = json.decode(jsonString)['types'];
      if (_dropdownData != null && _dropdownData.isNotEmpty) {
        _selectedType = null;
        _updateBrands();
      }
    });
  }

  void _updateBrands() {
    setState(() {
      final selectedType = _dropdownData.firstWhere((type) => type['name'] == _selectedType, orElse: () => null);
      _brands = selectedType != null ? selectedType['brands'].map((brand) => brand['name']).toList().cast<String>() : [];
      _selectedBrand = _brands.isNotEmpty ? _brands[0] : '';
      _updateModels();
    });
  }

  void _updateModels() {
    setState(() {
      final selectedBrand = _dropdownData
          .firstWhere((type) => type['name'] == _selectedType, orElse: () => null)
          ?['brands']
          ?.firstWhere((brand) => brand['name'] == _selectedBrand, orElse: () => null);
      _models = selectedBrand != null ? selectedBrand['models'].map((model) => model['name']).toList().cast<String>() : [];
      _selectedModel = _models.isNotEmpty ? _models[0] : '';
      _updateNumbers();
    });
  }

  void _updateNumbers() {
    setState(() {
      final selectedModel = _dropdownData
          .firstWhere((type) => type['name'] == _selectedType, orElse: () => null)
          ?['brands']
          ?.firstWhere((brand) => brand['name'] == _selectedBrand, orElse: () => null)
          ?['models']
          ?.firstWhere((model) => model['name'] == _selectedModel, orElse: () => null);
      _numbers = selectedModel != null ? selectedModel['numbers'].cast<String>() : [];
      _selectedNumber = _numbers.isNotEmpty ? _numbers[0] : '';
    });
  }

  Future<void> _selectImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }


  // void _submitForm() {
  // if (_formKey.currentState!.validate() &&
  //     _selectedType != null &&
  //     _selectedBrand != null &&
  //     _selectedModel != null &&
  //     _selectedNumber != null) {
  //   final task = {
  //     'name': _nameController.text,
  //     'phone': _phoneController.text,
  //     'address': _addressController.text,
  //     'description': _descriptionController.text,
  //     'type': _selectedType!,
  //     'brand': _selectedBrand!,
  //     'model': _selectedModel!,
  //     'number': _selectedNumber!,
  //     'category': _selectedCategory,
  //     'image': _selectedImage != null ? _selectedImage!.path : '',
  //   };
    
  //   // Save the task to Firebase Realtime Database
  //   final databaseURL = 'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
  // DatabaseReference tasksRef = FirebaseDatabase(databaseURL: databaseURL).reference().child('tasks');
  // tasksRef.push().set(task).then((_) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => HomeTaskListPage()),
  //   );
  // }).catchError((error) {
  //   print('Error saving task: $error');
  //   // Display an error message to the user
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text('Failed to save the task. Please try again.'),
  //     ),
  //   );
  // });}}
  void _submitForm() async {
  if (_formKey.currentState!.validate() &&
      _selectedType != null &&
      _selectedBrand != null &&
      _selectedModel != null &&
      _selectedNumber != null) {
    String imageUrl = '';
    if (_selectedImage != null) {
      // Upload the selected image to Firebase Storage
      final storageRef = FirebaseStorage.instance.ref().child('task_images').child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(_selectedImage!);
      final snapshot = await uploadTask.whenComplete(() {});
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    final task = {
      'name': _nameController.text,
      'phone': _phoneController.text,
      'address': _addressController.text,
      'description': _descriptionController.text,
      'type': _selectedType!,
      'brand': _selectedBrand!,
      'model': _selectedModel!,
      'number': _selectedNumber!,
      'category': _selectedCategory,
      'imageUrl': imageUrl,
    };

    // Save the task to Firebase Realtime Database
    final databaseURL = 'https://esource-bed3f-default-rtdb.asia-southeast1.firebasedatabase.app';
    DatabaseReference tasksRef = FirebaseDatabase(databaseURL: databaseURL).reference().child('tasks');
    tasksRef.push().set(task).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeTaskListPage()),
      );
    }).catchError((error) {
      print('Error saving task: $error');
      // Display an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save the task. Please try again.'),
        ),
      );
    });
  }
}


// hjdfgkjsdfhgl
//hasdgfjhasd
// ajshdfasdhjf
// ahsdflasdhf
// sdfhal
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Гэр ахуй',
          style: TextStyle(fontFamily: 'Mogul3', fontSize: 28),
        ),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeTaskListPage()),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4894FE)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Нэмэгдсэн ажлууд',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Ажил нэмэх',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Хэрэглэгчийн хэсэг',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Овог нэр',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Утасны дугаар',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 12.0),
                    TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        labelText: 'Гэрийн хаяг',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    
                    Text(
                      'Засвар хийлгэх хэрэгслийн тодорхойлолт',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                          _updateBrands();
                        });
                      },
                      items: _dropdownData.map<DropdownMenuItem<String>>((type) {
                        return DropdownMenuItem<String>(
                          value: type['name'],
                          child: Text(type['name']),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Төрөл сонгоно уу',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedBrand,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedBrand = newValue!;
                          _updateModels();
                        });
                      },
                      items: _brands.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Бренд сонгоно уу',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedModel,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedModel = newValue!;
                          _updateNumbers();
                        });
                      },
                      items: _models.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Загвар сонгоно уу',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    DropdownButtonFormField<String>(
                      value: _selectedNumber,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedNumber = newValue!;
                        });
                      },
                      items: _numbers.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Дугаар сонгоно уу',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 45),
                    Text(
                      'Гэмтлийн талаарх дэлгэрэнгүй',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: _selectImage,
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                fit: BoxFit.cover,
                              )
                            : Icon(
                                Icons.add_a_photo,
                                size: 50,
                                color: Colors.grey,
                              ),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    SizedBox(height: 8.0),
                    TextFormField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        labelText: 'Тайлбар оруулна уу',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 45.0),
                    Text(
                      'Хугацааны хүсэлт',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    DropdownButtonFormField<String>(
                      value: _selectedCategory,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                        });
                      },
                      items: <String>['Энгийн хугацаанд', 'Түргэн хугацаанд', 'Яаралтай']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        labelText: 'Ангилал сонгоно уу',
                        labelStyle: TextStyle(color: Colors.grey),
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text(
                        'Захиалах',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF4894FE)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}