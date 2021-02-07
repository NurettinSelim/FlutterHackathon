import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/services/storage_service.dart';

class NoteService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<List<Note>> getNotesFromLesson(lessonName) async {
    var notesCollection = usersCollection.doc(AuthService().user.uid).collection('notes');
    print(lessonName);
    var query = notesCollection.where('lessonName', isEqualTo: lessonName).orderBy('createdAt', descending: true);
    var raw_data = await query.get();
    var data = raw_data.docs.map((e) => Note.fromData(e.data())).toList();
    return data;
  }

  static void get init {
    FirebaseFirestore.instance.collection('users').doc(AuthService().user.uid).set({'dummyValue': 0});
  }

  Future<void> saveNote(Note note) async {
    final _storageService = StorageService();
    final _authService = AuthService();
    var notesCollection = usersCollection.doc(AuthService().user.uid).collection('notes');
    var newImagePath = await _storageService.uploadImage(imagePath: note.localImagePath, userId: _authService.user.uid);
    note.cloudImagePath = newImagePath;
    await notesCollection.add(note.toMap);
  }
}
