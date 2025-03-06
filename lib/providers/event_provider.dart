import 'package:evently_app/models/category.dart';
import 'package:evently_app/models/eventmodel.dart';
import 'package:evently_app/services/firebaseServices.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EventsProvider with ChangeNotifier {
  List<Event> events = [];
  List<Event> allevents = [];
  Categoryy? selectedCategory;

  Future<void> getEventsToCategory() async {
    events =
        await FireBaseServices.getAllEventsFromFirestore(selectedCategory?.id);
    notifyListeners();
  }

  Future<List<Event>> getAllEvents() async {
    allevents =
        await FireBaseServices.getAllEventsFromFirestore(selectedCategory?.id);
    notifyListeners();
    return events;
  }

  void changeSelectedCategory(Categoryy? category) {
    selectedCategory = category;
    getEventsToCategory();
  }
}
