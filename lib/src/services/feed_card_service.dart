import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/enums_firestore.dart';
import '../models/user_model.dart';
import '../models/feed_card_model.dart';
import '../constants/constants_number.dart';

class FeedCardService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future getFeeds() async {
    CollectionReference _recipes =
        _firestore.collection(FirestoreCollection.feedCollection.collection);
    CollectionReference _users =
        _firestore.collection(FirestoreCollection.userCollection.collection);

    QuerySnapshot _recipeSnapshot =
        await _recipes.limit(FeedNumber.feedsQuantity).get();
    DocumentSnapshot<Object?> _userSnapshot;

    List _result = [];
    List<UserModel> _authors = [];
    List<FeedCardModel> _recipeList = _recipeSnapshot.docs
        .map((doc) => FeedCardModel.fromSnapshot(doc))
        .toList();

    for (FeedCardModel _recipe in _recipeList) {
      _userSnapshot = await _users.doc(_recipe.author).get();
      _authors.add(UserModel.fromSnapshot(_userSnapshot));
    }

    _result.add(_recipeList);
    _result.add(_authors);

    return _result;
  }
}
