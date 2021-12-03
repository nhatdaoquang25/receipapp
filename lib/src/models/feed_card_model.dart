import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class FeedCardModel extends Equatable {
  final String author;
  final String imageURL;
  final String title;
  final String description;
  final String likes;
  final String comments;
  final Timestamp postTime;

  FeedCardModel({
    required this.postTime,
    required this.author,
    required this.imageURL,
    required this.title,
    required this.description,
    required this.likes,
    required this.comments,
  });

  static FeedCardModel fromSnapshot(DocumentSnapshot doc) {
    FeedCardModel recipe = FeedCardModel(
      author: doc['author'],
      title: doc['title'],
      imageURL: doc['imageURL'],
      description: doc['description'],
      likes: doc['likes'],
      comments: doc['comments'],
      postTime: doc['postTime'],
    );
    return recipe;
  }

  @override
  List<Object?> get props =>
      [author, imageURL, title, description, likes, comments, postTime];
}
