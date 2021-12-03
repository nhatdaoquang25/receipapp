import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String name;
  final String? nickName;
  final String avatarURL;

  UserModel({
    required this.name,
    this.nickName,
    required this.avatarURL,
  });

  static UserModel fromSnapshot(DocumentSnapshot doc) {
    UserModel user = UserModel(
      name: doc['name'],
      nickName: doc['nickName'],
      avatarURL: doc['avatarURL'],
    );
    return user;
  }

  @override
  List<Object?> get props => [name, nickName, avatarURL];
}
