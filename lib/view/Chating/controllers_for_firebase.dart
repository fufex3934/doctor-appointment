
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserManagementPage extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//for adding a user to firebase
  Future<void> addUser(String displayName, String email, String avatarUrl) async {
    await _firestore.collection('users').add({
      'displayName': displayName,
      'email': email,
      'avatarUrl': avatarUrl,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
// to view and to list the users in the firebse
  Widget buildUserList() {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final users = snapshot.data!.docs;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index].data() as Map<String, dynamic>;
            final uid = users[index].id; // Get the user's UID

            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['avatarUrl'] ?? ''),
              ),
              title: Text(user['displayName'] ?? 'Unknown User'),
              subtitle: Text(user['email'] ?? ''),
              onTap: () {
                // Handle tapping on a user if needed
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Show an edit user dialog or screen
                      // Use the editUser function to update user data
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      // Show a confirmation dialog and then call deleteUser
                      // to delete the user from the Firestore
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
// to delete the users
  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  //to edit the user

  Future<void> editUser(String uid, {String? displayName, String? email, String? avatarUrl}) async {
    final data = <String, dynamic>{};
    if (displayName != null) data['displayName'] = displayName;
    if (email != null) data['email'] = email;
    if (avatarUrl != null) data['avatarUrl'] = avatarUrl;

    await _firestore.collection('users').doc(uid).update(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Management'),
      ),
      body: buildUserList(),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: UserManagementPage(),
  ));
}