import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel extends Equatable {
  String id;
  String name;
  String avatarURL;
  String nickName;
  int follow;
  int like;

  UserModel(
      {required this.id,
      required this.name,
      required this.avatarURL,
      required this.nickName,
      required this.follow,
      required this.like,
      });

  @override
  List<Object?> get props =>
      [this.id, this.name, this.avatarURL, this.nickName];
}

String id = "abc123@gmail.com";
String name = "Adam Zapel";
String avatarURL =
    "https://anhdep123.com/wp-content/uploads/2020/11/anh-hot-girl.jpg";
String nickName = "Cabbage Master";
int follow=584 ;
  int like=23;
final user =
    UserModel(id: id, avatarURL: avatarURL, name: name, nickName: nickName, follow: follow, like: like);
