import 'package:flutter/material.dart';

class Offer extends StatelessWidget {
  const Offer({super.key, required this.offerImage});
  final String offerImage;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(32)),
      child: GestureDetector(
        onTap: () => (),
        child: Image.asset(
          offerImage,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
