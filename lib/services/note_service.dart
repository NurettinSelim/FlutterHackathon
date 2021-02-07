import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:note_app/models/note.dart';
import 'package:note_app/services/auth.dart';
import 'package:note_app/services/storage_service.dart';

class NoteService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  Future<List<Note>> getNotesFromLesson(lessonName) async {
    var notesCollection = usersCollection.doc(AuthService().user.uid).collection('notes');
    var query = notesCollection.where('lessonName', isEqualTo: lessonName).orderBy('createdAt', descending: true);
    var raw_data = await query.get();
    var data = raw_data.docs.map((e) => Note.fromData(e.id, e.data())).toList();
    return data;
  }

  Future<List<Note>> get lastItems async {
    var notesCollection = usersCollection.doc(AuthService().user.uid).collection('notes');
    var query = notesCollection.orderBy('createdAt', descending: true).limit(5);
    var raw_data = await query.get();
    var data = raw_data.docs.map((e) => Note.fromData(e.id, e.data())).toList();
    return data;
  }

  static void get init {
    FirebaseFirestore.instance.collection('users').doc(AuthService().user.uid).set({'dummyValue': 0});
  }

  Future<void> saveNote(Note note) async {
    final _storageService = StorageService();
    final _authService = AuthService();
    var notesCollection = usersCollection.doc(_authService.user.uid).collection('notes');
    var newImagePath = await _storageService.uploadImage(imagePath: note.localImagePath, userId: _authService.user.uid);
    note.cloudImagePath = newImagePath;
    await notesCollection.add(note.toMap);
  }

  Future<void> deleteNote(String id) async {
    var notesCollection = usersCollection.doc(AuthService().user.uid).collection('notes');
    await notesCollection.doc(id).delete();
  }
}
