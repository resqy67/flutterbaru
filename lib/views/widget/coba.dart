import 'package:flutter/material.dart';

class TopBarFb2 extends StatelessWidget {
  final String title;
  final Widget icon;
  const TopBarFb2({required this.title, required this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 20),
        Text(title,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.normal,
            )),
        Spacer(),
        IconButton(onPressed: () {}, icon: icon),
        SizedBox(width: 10)
      ],
    );
  }
}
