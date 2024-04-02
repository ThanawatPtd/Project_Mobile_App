import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TestTextThemePage extends StatelessWidget {
  const TestTextThemePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            //inter,
            Text("Headline1",style: Theme.of(context).textTheme.headlineLarge,),
            Text("Headline 2",style: Theme.of(context).textTheme.headlineMedium),
            Text("Headline 3",style: Theme.of(context).textTheme.headlineSmall),
            Text("Body",style: Theme.of(context).textTheme.bodyMedium),
            Text("Label",style: Theme.of(context).textTheme.labelMedium),
            ElevatedButton(onPressed: (){}, child: Text(
              "Button",style: Theme.of(context).textTheme.labelLarge,
            )),
          ],
        ),
      ),
    );
  }
}
