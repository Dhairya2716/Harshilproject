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
  String _searchQuery = "";

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
    List<Map<String, dynamic>> filteredUsers = widget.users
        .where((user) => user['name'].toLowerCase().contains(_searchQuery.toLowerCase()) ||
        user['email'].toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        backgroundColor: Colors.blue,
        elevation: 4,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search users...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: filteredUsers.isEmpty
                ? Center(
              child: Text(
                "No users found",
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
                : ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                return _buildUserCard(filteredUsers[index]);
              },
            ),
          ),
        ],
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

  Widget _buildUserCard(Map<String, dynamic> user) {
    return Card(
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue,
          child: Text(
            user['name'][0],
            style: TextStyle(color: Colors.white),
          ),
        ),
        title: Text(
          user['name'] ?? "",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          user['email'] ?? "",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editUser(widget.users.indexOf(user)),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteUser(widget.users.indexOf(user)),
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: user['isFavorite'] == true ? Colors.red : Colors.grey,
              ),
              onPressed: () => _toggleFavorite(widget.users.indexOf(user)),
            ),
          ],
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Phone", user['phone'] ?? ""),
                _buildDetailRow("Address", user['address'] ?? ""),
                _buildDetailRow("Gender", user['gender'] ?? ""),
                _buildDetailRow("City", user['city'] ?? ""),
                _buildDetailRow(
                  "Hobbies",
                  (user['hobbies'] as List<dynamic>).join(", "),
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
