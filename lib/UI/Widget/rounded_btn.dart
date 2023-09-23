import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  final String btnName;
  final VoidCallback ontap;
  const RoundedBtn({super.key, required this.btnName, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.purple
        ),
        height: 50,
        width: double.infinity,
        child: Center(child: Text(btnName, style: TextStyle(fontSize: 18, color: Colors.white),)),
      ),
    );
  }
}
