import 'package:equatable/equatable.dart';

class RecipeModel extends Equatable {
  final String id;
  final String label;

  RecipeModel({
    required this.id,
    required this.label,
  });
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['recipe']['uri'],
      label: json['recipe']['label'],
    );
  }

  @override
  List<Object?> get props => [id, label];
}
