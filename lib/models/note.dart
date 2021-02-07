import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  String id;
  String lessonName;
  String title;
  String detail;
  String imageText;
  Timestamp createdAt;
  String localImagePath;
  String cloudImagePath;

  Note({
    this.id,
    this.lessonName,
    this.title,
    this.detail,
    this.localImagePath,
    this.cloudImagePath,
    this.imageText,
    this.createdAt,
  });

  Note.fromData(this.id, Map<String, dynamic> data) {
    lessonName = data['lessonName'];
    title = data['title'];
    detail = data['detail'];
    cloudImagePath = data['imageName'];
    imageText = data['imageText'];
    createdAt = data['createdAt'];
  }
  Map<String, dynamic> get toMap {
    return {
      'lessonName': lessonName,
      'title': title,
      'detail': detail,
      'imageName': cloudImagePath,
      'createdAt': createdAt,
      'imageText': imageText,
    };
  }

  String get imagePath {
    if (cloudImagePath == null) {
      return localImagePath;
    }
    return cloudImagePath;
  }
}
