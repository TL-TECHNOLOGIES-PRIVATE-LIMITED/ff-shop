// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// Future<void> _selectDate(BuildContext context, String date) async {
//     DateFormat format = DateFormat("dd-MM-yyyy");
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: format.parse(date),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (pickedDate != null) {
//       setState(() {
//         this.date = DateFormat('dd-MM-yyyy').format(pickedDate);
//       });
//       log(DateFormat('dd-MM-yyyy').format(pickedDate).toString());
//     }
//   }