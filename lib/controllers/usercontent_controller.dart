import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmfolio/models/content_create_track.dart';

class UserContentController {
  final List<UserContent> _userContentList = [];
  final CollectionReference _userContentCollection =
      FirebaseFirestore.instance.collection("user_content");

  Future<void> addUserContent(String userId, String contentId) async {
    final userContent = UserContent(
      userId: userId,
      contentId: contentId,
    );
    _userContentList.add(userContent);
    await _userContentCollection.add(userContent.toJson());
    print('UserContent added: $userContent');
  }

  Future<List<UserContent>> getContentByUser(String userId) async {
    final querySnapshot =
        await _userContentCollection.where('userId', isEqualTo: userId).get();

    return querySnapshot.docs
        .map((doc) => UserContent.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserContent>> getUsersByContent(String contentId) async {
    final querySnapshot = await _userContentCollection
        .where('contentId', isEqualTo: contentId)
        .get();

    return querySnapshot.docs
        .map((doc) => UserContent.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<List<UserContent>> getAllUserContent() async {
    final querySnapshot = await _userContentCollection.get();
    return querySnapshot.docs
        .map((doc) => UserContent.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }

  Future<bool> didUserCreateContent(String userId, String contentId) async {
    final querySnapshot = await _userContentCollection
        .where('userId', isEqualTo: userId)
        .where('contentId', isEqualTo: contentId)
        .get();

    return querySnapshot.docs.isNotEmpty;
  }

  Future<void> deleteByContentId(String contentId) async {
    final querySnapshot = await _userContentCollection
        .where('contentId', isEqualTo: contentId)
        .get();

    for (var doc in querySnapshot.docs) {
      await _userContentCollection.doc(doc.id).delete();
    }
  }
}
