

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const CustomButton({super.key, required this.onTap, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40,
          color: Colors.purple,
          child:  Center(child: Text(title,style: const TextStyle(color: Colors.white),)),
        ),
      ),
    );
  }
}
