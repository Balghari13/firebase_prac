import 'package:flutter/material.dart';

class RoundedBtn extends StatelessWidget {
  final String btnName;
  final VoidCallback ontap;
  final bool isLoading;
 const RoundedBtn({super.key, required this.btnName,
    this.isLoading=false, required this.ontap});

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
        child: Center(child: isLoading?const CircularProgressIndicator(color: Colors.white,strokeWidth: 3,): Text(btnName, style: const TextStyle(fontSize: 18, color: Colors.white),)),
      ),
    );
  }
}
