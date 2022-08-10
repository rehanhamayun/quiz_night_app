import 'package:app_kwiz/ProviderController/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LikedQuestions extends StatelessWidget {
  const LikedQuestions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DataClass>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: provider.likedOnes.length,
                itemBuilder: (context, index) {
                  return Card(
                      child: Text(
                    provider.likedOnes[index].toString(),
                  ));
                }),
          )
        ],
      ),
    );
  }
}
