import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../add_book/add_book_model.dart';

class AddBookPage extends StatelessWidget {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),

        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: '本のタイトル'
                  ),
                  onChanged: (text) {
                    // TODO: ここで取得したtextを使う
                    model.title = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      hintText: '本の著者'
                  ),
                  onChanged: (text) {
                    // TODO: ここで取得したtextを使う
                    model.author = text;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                       await model.addbook();
                       final snackbar = SnackBar(
                         backgroundColor: Colors.green,
                         content: Text('本を追加しました。'),
                       );
                       ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      } catch(e) {
                        final snackbar = SnackBar(
                          backgroundColor: Colors.red,
                            content: Text(e.toString()),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }

                  },
                    child: Text('追加する'),
                ),
              ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
