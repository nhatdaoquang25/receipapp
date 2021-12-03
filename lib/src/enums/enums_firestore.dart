enum FirestoreCollection {
  feedCollection,
  userCollection,
}

extension throwCollectionValue on FirestoreCollection {
  String get collection {
    switch (this) {
      case FirestoreCollection.feedCollection:
        return 'feeds';
      case FirestoreCollection.userCollection:
        return 'users';
    }
  }
}
