import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/models/category.dart';

class Event {
  String id;
  String userId;
  String title;
  String describtion;
  Categoryy category;
  DateTime dateTime;

  Event({
    this.id = '',
    required this.title,
    required this.describtion,
    required this.category,
    required this.dateTime,
    required this.userId,
  });

  Event.fromJson(Map<String, dynamic> json)
      : this(
          userId: json['userId'],
          id: json['id'],
          title: json['title'],
          describtion: json['description'],
          category: Categoryy.categories
              .firstWhere((Category) => Category.id == json['category']),
          dateTime: (json['date'] as Timestamp).toDate(),
        );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'description': describtion,
        'category': category.id,
        'date': Timestamp.fromDate(dateTime),
      };
}
