import 'package:flutter/material.dart';

class CreateRecord extends StatefulWidget {
  const CreateRecord({super.key});

  @override
  State<CreateRecord> createState() => _CreateRecordState();
}

class _CreateRecordState extends State<CreateRecord> {
  TextEditingController moneyController = TextEditingController();
  String t = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {}, child: Text("Date Picker")),
              TextField(
                keyboardType: TextInputType.number,
                controller: moneyController,
                onEditingComplete: () {
                  setState(() {
                    int n = int.parse(moneyController.text);
                    print(n);
                    t = n.toString();
                  });
                },
              ),
              Text(t),
            ],
          ),
        ),
      ),
    );
  }
}
