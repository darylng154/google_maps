import 'package:flutter/material.dart';

class CustomDropDown extends StatefulWidget {
  final String name;
  final Function onChangedCallback;
  final String? value;
  final Iterable<String> values;
  // final String? Function(String?)? validator;

  const CustomDropDown({super.key, 
    required this.name,
    required this.value,
    required this.values,
    required this.onChangedCallback,
  });

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          Text(widget.name, style: const TextStyle(color: Colors.green)),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              height: 40,
              padding: const EdgeInsets.only(left: 15.0, right: 10.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(12.0)),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      value: widget.values.contains(widget.value) ? widget.value : widget.values.first,
                      // validator: widget.validator,
                      items: widget.values
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        widget.onChangedCallback(newValue);
                      }),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
