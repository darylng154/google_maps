import 'package:flutter/material.dart';

import 'CustomTextField.dart';
import 'package:toprun_application/utilities/SafeFunctionConverter.dart';

class CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: TextFormField(
        enabled: widget.readonly,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        controller: widget.myController,
        keyboardType: widget.inputType,
        maxLines: widget.maxLine,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          hintMaxLines: 2,
          prefixIcon: widget.myIcon,
          hintText: widget.hint,
          labelText: widget.fieldName,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade900),
          ),
        ),
        onTap: () => widget.onTap == null
            ? null
            : _selectDate(context, widget.myController, widget.fieldName),
      ),
    );
  }

  _selectDate(
    BuildContext context,
    TextEditingController input,
    String? fieldLabel,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: input.text == ''
          ? DateTime.now()
          : SafeFunctionConverter.toStaticDateFormat('MM-dd-yyyy',input.text),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      helpText: fieldLabel,
    );

    if (pickedDate != null) {
      String formattedDate = SafeFunctionConverter.toStaticDateFormatDateTime('MM-dd-yyyy',pickedDate);
      setState(() {
        input.text = formattedDate;
      });
    }
  }
}
