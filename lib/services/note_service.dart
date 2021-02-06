import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/services/auth.dart';

class NoteService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<QuerySnapshot> getNotesFromLesson(lessonName) {
    var notesCollection = usersCollection.doc(AuthService().user.uid).collection('notes');
    var query = notesCollection.where('lessonName', isEqualTo: lessonName).orderBy('created_at', descending: true);
    return query.get();
  }
}
