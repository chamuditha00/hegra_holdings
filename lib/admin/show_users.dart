import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hegra_holdings/admin/Edit_user.dart';

class UserDataCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Workers Detail'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16.0),
              color: Colors.white,
              child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection('Users').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  return ListView(
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data() as Map<String, dynamic>;
                      return UserCard(
                        documentId: document.id,
                        email: data['email'],
                        position: data['position'],
                        area: data['area'],
                        username: data['username'],
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
        ));
  }
}

class UserCard extends StatelessWidget {
  final String documentId;
  final String email;
  final String position;
  final String area;
  final String username;

  UserCard({
    required this.documentId,
    required this.email,
    required this.position,
    required this.area,
    required this.username,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      color: Colors.white,
      child: ListTile(
        title: Text(username,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Email: $email',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Position: $position',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            Text('Area: $area',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                )),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                // Add code to handle update operation
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            EditUserScreen(documentId: documentId)));
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Add code to handle delete operation
                FirebaseFirestore.instance
                    .collection('Users')
                    .doc(documentId)
                    .delete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
