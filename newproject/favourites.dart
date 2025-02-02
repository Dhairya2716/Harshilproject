import 'package:flutter/material.dart';
import 'adduser.dart';

class FavouritesPage extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteUsers;

  FavouritesPage({required this.favoriteUsers});

  @override
  _FavouritesPageState createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  void _editUser(int index) async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(
          onUserAdded: (updatedUser) {
            setState(() {
              widget.favoriteUsers[index] = updatedUser;
            });
          },
          existingUser: widget.favoriteUsers[index],
        ),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        widget.favoriteUsers[index] = updatedUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Favourites')),
      body: widget.favoriteUsers.isEmpty
          ? Center(child: Text("No favourite users yet"))
          : ListView.builder(
        itemCount: widget.favoriteUsers.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 4,
            child: ListTile(
              title: Text(widget.favoriteUsers[index]['name'] ?? "", style: TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(widget.favoriteUsers[index]['email'] ?? ""),
              trailing: IconButton(
                icon: Icon(Icons.edit, color: Colors.blue),
                onPressed: () => _editUser(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
