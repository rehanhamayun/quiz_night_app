import 'package:flutter/material.dart';

class DataClass with ChangeNotifier {
  List<String> _likedOnes = [];
  List<String> get likedOnes => _likedOnes;

  void addQuestiontoLiked(String liked) async {
    _likedOnes.add(liked);
    notifyListeners();
  }
}
