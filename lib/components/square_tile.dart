import 'package:flutter/material.dart';


class SquareTileWidget extends StatelessWidget{
  final String imgPath;
  
  const SquareTileWidget({
    super.key,
    required this.imgPath,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Image.asset(
        imgPath,
        height: 40,
      ),
    );
  }
}