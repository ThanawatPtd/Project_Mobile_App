import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [Icon(Icons.notifications)],
      backgroundColor: Color.fromARGB(255, 77, 145, 90),
      foregroundColor: Colors.white,
      title: Text("Summary"),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
        double.maxFinite,
        50,
      );
}
