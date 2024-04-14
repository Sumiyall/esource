import 'package:flutter/material.dart';
 
class DatePickerTextField extends StatefulWidget {
  final Function(String) onDateSelected;
  final String initialDate;
  DatePickerTextField({
    required this.onDateSelected,
    this.initialDate = '',
  });
 
  @override
  _DatePickerTextFieldState createState() => _DatePickerTextFieldState();
}
 
class _DatePickerTextFieldState extends State<DatePickerTextField> {
  late DateTime _selectedDate;
 
  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate.isNotEmpty
        ? DateTime.parse(widget.initialDate)
        : DateTime.now();
  }
 
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
 
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onDateSelected(
          '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}');
    }
  }
 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        height: 42.0,
        child: GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              keyboardType: TextInputType.datetime,
              controller: TextEditingController(
                text: _selectedDate == null
                    ? ''
                    : '${_selectedDate.year}-${_selectedDate.month}-${_selectedDate.day}',
              ),
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
                suffixIcon: Icon(Icons.calendar_month_outlined),
              ),
            ),
          ),
        ),
      ),
    );
  }
}