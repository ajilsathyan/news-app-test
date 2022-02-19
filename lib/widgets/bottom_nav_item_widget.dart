import 'package:flutter/material.dart';

class BottomNavItemWidget extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  const BottomNavItemWidget(
      {Key? key, required this.color, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          title,
          style: TextStyle(color: color, fontSize: 12),
        )
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }
}
