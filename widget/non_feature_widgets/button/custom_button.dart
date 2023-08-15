import 'package:flutter/material.dart';
import 'package:toprun_application/widget/non_feature_widgets/TextFunc.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onPress,
    required this.name,
    required this.w,
    required this.h,
    this.color,
    // h,
    // required this.description,
  }) : super(key: key);

  String name;
  Color? color;
  double h;
  double w;

  final VoidCallback onPress;
  // final String name, description;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: Size(w, h),
            backgroundColor: color ?? const Color.fromARGB(255, 114, 187, 132)),
        onPressed: onPress,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFunc.printAutoSizeText(name),
        ),
      ),
    );
  }
}
