import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobile_app/src/models/feed_card_model.dart';
import 'package:mobile_app/src/models/user_model.dart';
import 'package:mobile_app/src/services/feed_card_service.dart';
import 'package:mocktail/mocktail.dart';

class MockFeedCardService extends Mock implements FeedCardService {
  final bool isNotEmpty;

  MockFeedCardService(this.isNotEmpty);
  @override
  Future getFeeds() async {
    final feedCardMockModel = FeedCardModel(
      author: '',
      comments: '30',
      description: 'mock description',
      imageURL:
          'https://www.howtocook.recipes/wp-content/uploads/2020/09/Sugar-cookie-recipe-with-icing.jpg',
      likes: '707',
      postTime: Timestamp.fromDate(DateTime(2021, 9, 1, 5, 30)),
      title: 'mock title',
    );
    List<List> result = [];
    List<FeedCardModel> recipes = [];
    List<UserModel> authors = [];
    if (isNotEmpty) {
      recipes.add(feedCardMockModel);
      authors.add(UserModel(
          name: 'test name',
          avatarURL:
              'https://genk.mediacdn.vn/2019/1/7/photo-2-1546830068212951494190.jpg'));
    }
    result.add(recipes);
    result.add(authors);
    return result;
  }
}
