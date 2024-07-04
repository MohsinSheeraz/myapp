import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp/services/firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final FireStoreServices fireStoreService = FireStoreServices();

  final TextEditingController textcontroller = TextEditingController();

  void  openNoteBox(){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: TextField(
        controller: textcontroller,
      ),
      actions: [
        ElevatedButton(
         onPressed: () {
          fireStoreService.addNote(textcontroller.text);

          textcontroller.clear();

          Navigator.pop(context);

         },
         child: const Text("Add"),
         )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
          title: const Text(
            'Notes',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          elevation: 10.0,
          shadowColor: Colors.grey.withOpacity(0.5),
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Add your code here
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Add your code here
              },
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                // Add your code here
              },
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16),
            ),
          ),
        ),
      floatingActionButton: FloatingActionButton(
       onPressed: openNoteBox,
       child: const Icon(Icons.add)),

       body: StreamBuilder<QuerySnapshot>(
        stream: fireStoreService.getNotesStream(),
        builder: (context, snapshot){
          if (snapshot.hasData){
            List notesList = snapshot.data!.docs;

            return ListView.builder(
              itemCount: notesList.length,
              itemBuilder: (context , index){
                DocumentSnapshot document = notesList[index];
                String docID = document.id;

                Map<String, dynamic> data = 
                document.data() as Map<String, dynamic>;
                String noteText = data['note'];

                return ListTile(
                  title: Text(noteText),
                );
              } 
            );
          }

          else{
            return const Text("No notes...");
          }
        }
       ),
       
    );
  }
}