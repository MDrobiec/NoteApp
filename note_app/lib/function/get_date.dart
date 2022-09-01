import 'package:flutter/material.dart';

class GetDate {
  Future<DateTime> selectDate(context, date) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != date) {
      date = picked;
    }
    return date;
  }
}
