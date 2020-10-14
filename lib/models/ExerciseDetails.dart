import 'package:workout_exercises/models/Category.dart';
import 'package:workout_exercises/models/Equipment.dart';
import 'package:workout_exercises/models/Muscles.dart';

class ExerciseDetails {
  final String name;
  final String description;
  final Category category;
  final List<Muscles> mainMuscles;
  final List<Muscles> secondaryMuscles;
  final List<Equipment> equipments;

  ExerciseDetails(
      {this.name,
      this.description,
      this.category,
      this.mainMuscles,
      this.secondaryMuscles,
      this.equipments});

  factory ExerciseDetails.fromJson(Map<String, dynamic> json) {
    return ExerciseDetails(
        name: json['name'],
        description: json['description'],
        category: Category.fromJson(json['category']),
        mainMuscles: (json['muscles'] as List)
            .map((data) => Muscles.fromJson(data))
            .toList(),
        secondaryMuscles: (json['muscles_secondary'] as List)
            .map((data) => Muscles.fromJson(data))
            .toList(),
        equipments: (json['equipment'] as List)
            .map((data) => Equipment.fromJson(data))
            .toList());
  }
}
