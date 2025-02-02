import 'package:flutter/material.dart';
import 'adduser.dart';
import 'favourites.dart';

class UserListPage extends StatefulWidget {
  final List<Map<String, dynamic>> users;
  final List<Map<String, dynamic>> favoriteUsers;

  UserListPage({required this.users, required this.favoriteUsers});

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  void _editUser(int index) async {
    final updatedUser = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddUserPage(
          onUserAdded: (updatedUser) {
            setState(() {
              widget.users[index] = updatedUser;
            });
          },
          existingUser: widget.users[index],
        ),
      ),
    );

    if (updatedUser != null) {
      setState(() {
        widget.users[index] = updatedUser;
      });
    }
  }

  void _toggleFavorite(int index) {
    setState(() {
      widget.users[index]['isFavorite'] = !(widget.users[index]['isFavorite'] ?? false);
      if (widget.users[index]['isFavorite']) {
        widget.favoriteUsers.add(widget.users[index]); // Add to favorites
      } else {
        widget.favoriteUsers.removeWhere((user) => user['email'] == widget.users[index]['email']);
      }
    });
  }

  void _deleteUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Delete User"),
        content: Text("Are you sure you want to delete this user?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                widget.users.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: widget.users.isEmpty
          ? Center(
        child: Text(
          "No users added yet",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: widget.users.length,
        itemBuilder: (context, index) {
          return _buildUserCard(index);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite, color: Colors.white),
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FavouritesPage(favoriteUsers: widget.favoriteUsers),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserCard(int index) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            widget.users[index]['name'][0],
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          widget.users[index]['name'] ?? "",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          widget.users[index]['email'] ?? "",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editUser(index),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteUser(index),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: widget.users[index]['isFavorite'] == true ? Colors.red : Colors.grey,
              ),
              onPressed: () => _toggleFavorite(index),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Phone", widget.users[index]['phone'] ?? ""),
                _buildDetailRow("Address", widget.users[index]['address'] ?? ""),
                _buildDetailRow("Gender", widget.users[index]['gender'] ?? ""),
                _buildDetailRow("City", widget.users[index]['city'] ?? ""),
                _buildDetailRow(
                  "Hobbies",
                  (widget.users[index]['hobbies'] as List<dynamic>).join(", "),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.grey[800]),
            ),
          ),
        ],
      ),
    );
  }
}