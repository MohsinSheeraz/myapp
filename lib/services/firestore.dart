import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreServices {

  //get collection
  final CollectionReference notes = FirebaseFirestore.instance.collection('notes');

  // CREATE
  Future<void> addNote(String note){
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }



  // READ
  Stream<QuerySnapshot> getNotesStream(){
    final notesStream = 
    notes.orderBy('timestamp', descending: true).snapshots();

    return notesStream;
  }


}