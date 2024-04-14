
import 'datepicker.dart';
// import 'package:carx/timeselect.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
 
class Booking extends StatefulWidget {
  const Booking({Key? key}) : super(key: key);
 
  @override
  State<Booking> createState() => _BookingState();
}
 
class _BookingState extends State<Booking> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  List<Contact> contacts = List.empty(growable: true);
  int selectedIndex = -1;
  String selectedDate = '';
  String selectedTime = '';
 
  void resetFields() {
    nameController.clear();
    contactController.clear();
    setState(() {
      selectedDate = '';
      selectedTime = '';
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF3F4FF),
        title: Text(
          'Захиалга',
          style: TextStyle(fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              Icons.mail_outlined,
              size: 33,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Захиалагчийн нэр",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 42.0,
                  child: TextField(
                    controller: nameController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(25, 0, 20, 5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1F2EBB),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1F2EBB)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Утасны дугаар",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Container(
                  height: 42.0,
                  child: TextField(
                    controller: contactController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.fromLTRB(25, 0, 20, 5),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1F2EBB),
                        ),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xff1F2EBB)),
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Огноо",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(height: 5),
              DatePickerTextField(
                onDateSelected: (selectedDate) {
                  setState(() {
                    this.selectedDate = selectedDate;
                  });
                },
                initialDate: '',
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Цаг",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              // BookingTimePicker(
              //   onTimeSelected: (selectedTime) {
              //     setState(() {
              //       this.selectedTime = selectedTime;
              //     });
              //   },
              // ),
              SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  String name = nameController.text.trim();
                  String contact = contactController.text.trim();
                  if (name.isNotEmpty &&
                      contact.isNotEmpty &&
                      selectedDate.isNotEmpty &&
                      selectedTime.isNotEmpty) {
                    if (selectedIndex != -1) {
                      setState(() {
                        contacts[selectedIndex] = Contact(
                          name: name,
                          contact: contact,
                          date: selectedDate,
                          time: selectedTime,
                        );
                        resetFields();
                        selectedIndex = -1;
                      });
                    } else {
                      setState(() {
                        contacts.add(Contact(
                          name: name,
                          contact: contact,
                          date: selectedDate,
                          time: selectedTime,
                        ));
                        resetFields();
                      });
                    }
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Алдаа'),
                          content: Text('Бүх мэдээллийг бөглөнө үү!'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('За'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff4552CB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  fixedSize: Size(380, 50),
                ),
                child: Text(
                  'Хадгалах',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if (contacts.isEmpty)
                const Text(
                  'Одоогоор захиалга алга...',
                  style: TextStyle(fontSize: 22),
                ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) => getRow(index),
                ),
              )
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Navbar(),
      backgroundColor: Color(0xFFF3F4FF),
    );
  }
 
  Widget getRow(int index) {
    List<Color> avatarColors = [
      Colors.deepPurpleAccent,
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
    ];
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xff1F2EBB)),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: avatarColors[index % avatarColors.length],
          foregroundColor: Colors.white,
          child: Text(
            contacts[index].name[0],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  contacts[index].name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  contacts[index].contact,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              'Date: ${contacts[index].date}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 4),
            Text(
              'Time: ${contacts[index].time}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            children: [
              InkWell(
                  onTap: () {
                    nameController.text = contacts[index].name;
                    contactController.text = contacts[index].contact;
                    selectedDate = contacts[index].date;
                    selectedTime = contacts[index].time;
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  child: const Icon(
                    Icons.edit_outlined,
                    size: 30,
                  )),
              InkWell(
                  onTap: () {
                    setState(() {
                      contacts.removeAt(index);
                    });
                  },
                  child: const Icon(
                    Icons.delete_outline,
                    size: 30,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
 
class Contact {
  String name;
  String contact;
  String date;
  String time;
  Contact(
      {required this.name,
      required this.contact,
      required this.date,
      required this.time});
}
 