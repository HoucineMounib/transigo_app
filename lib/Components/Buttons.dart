import 'package:flutter/material.dart';

//////////////
/////////////BUTTON #1
class MyButtonOne extends StatelessWidget {
  final void Function()? onPressed;
  final String? iconUrl;
  final String text;
  const MyButtonOne({
    super.key,
    this.onPressed,
    this.iconUrl,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(32),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 54,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              iconUrl!,
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Icon(
              Icons.abc,
              size: 50,
              color: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}

//////////////
/////////////BUTTON #2
class MyButtonTwo extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const MyButtonTwo({
    super.key,
    required this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        width: MediaQuery.of(context).size.width * 0.9,
        height: 54,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Theme.of(context).primaryColorLight,
              fontSize: 18,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ),
    );
  }
}
