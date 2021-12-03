import 'package:equatable/equatable.dart';

class Category extends Equatable {
  int id;
  String content;
  String urlPicture;
  Category({
    required this.id,
    required this.content,
    required this.urlPicture,
  });
  @override
  List<Object?> get props => [
        this.id,
        this.content,
        this.urlPicture,
      ];
}

final Fake_Category = [
  Category(id: 1, content: 'Sweet', urlPicture: 'https://images.theconversation.com/files/270320/original/file-20190423-15218-9to8i9.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop'),
  Category(id: 2, content: 'Italian', urlPicture: 'https://images.theconversation.com/files/270320/original/file-20190423-15218-9to8i9.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop'),
  Category(id: 3, content: 'Desserts', urlPicture: 'https://images.theconversation.com/files/270320/original/file-20190423-15218-9to8i9.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop'),
  Category(id: 4, content: 'Chocolates', urlPicture: 'https://images.theconversation.com/files/270320/original/file-20190423-15218-9to8i9.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop'),
  Category(id: 5, content: 'Soups', urlPicture: 'https://images.theconversation.com/files/270320/original/file-20190423-15218-9to8i9.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop'),
  Category(id: 6, content: 'Pasta', urlPicture: 'https://images.theconversation.com/files/270320/original/file-20190423-15218-9to8i9.jpg?ixlib=rb-1.1.0&q=45&auto=format&w=1200&h=1200.0&fit=crop'),
];
