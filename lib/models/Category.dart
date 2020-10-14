import 'package:flutter/cupertino.dart';

class Category {
  static const int ARMS = 8;
  static const int LEGS = 9;
  static const int ABS = 10;
  static const int CHEST = 11;
  static const int BACK = 12;
  static const int SHOULDERS = 13;
  static const int CALVES = 14;
  final int id;
  final String name;

  Category({this.id, this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }

  AssetImage getAssetImage() {
    switch (id) {
      case Category.ARMS:
        {
          return AssetImage('assets/images/arms.jpg');
        }
      case Category.LEGS:
        {
          return AssetImage('assets/images/legs.jpg');
        }
      case Category.ABS:
        {
          return AssetImage('assets/images/abs.jpg');
        }
      case Category.CHEST:
        {
          return AssetImage('assets/images/chest.jpg');
        }
      case Category.BACK:
        {
          return AssetImage('assets/images/back.jpg');
        }
      case Category.SHOULDERS:
        {
          return AssetImage('assets/images/shoulders.jpg');
        }
      case Category.CALVES:
        {
          return AssetImage('assets/images/calves.jpg');
        }
      default:
        {
          return AssetImage('assets/images/generic.jpg');
        }
    }
  }
}
