import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import 'CustomTextFieldState.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.fieldName,
    required this.myController,
    //might not need this
    // required this.context,

    this.myIcon,
    this.hint,
    this.inputFormatters,
    this.maxLine,
    this.validator,
    this.inputType,
    this.readonly,
    this.onTap,
    this.date,
    this.firstDate,
  }) : super(key: key);

  // BuildContext? context;
  final TextEditingController myController;
  final String? fieldName;
  final String? hint;
  final Widget? myIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int? maxLine;
  final TextInputType? inputType;
  final bool? readonly;

  bool? onTap;
  DateTime? date;
  DateTime? firstDate;

  @override
  State<StatefulWidget> createState() => CustomTextFieldState();

  DateTime? getDate() {
    return date;
  }

  void setDate(DateTime? date) => this.date = date;

  DateTime? getFirstDate() {
    return firstDate;
  }

  void setFirstDate(DateTime? firstDate) => this.firstDate = firstDate;
}
