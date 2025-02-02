import 'package:flutter/material.dart';
import 'adduser.dart';
import 'userlist.dart';
import 'favourites.dart';
import 'aboutus.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> favouriteusers = [];

  void addUser(Map<String, dynamic> user) {
    setState(() {
      users.add(user);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dashboard'), backgroundColor: Colors.blue),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _buildDashboardCard(
            context,
            'Add User',
            Icons.person_add,
            AddUserPage(onUserAdded: addUser),
          ),
          _buildDashboardCard(
            context,
            'User List',
            Icons.list,
            UserListPage(users: users, favoriteUsers: favouriteusers,),
          ),
          _buildDashboardCard(context, 'Favourites', Icons.favorite, FavouritesPage(favoriteUsers: favouriteusers,)),
          _buildDashboardCard(context, 'About Us', Icons.info, AboutUsPage()),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(BuildContext context, String title, IconData icon, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.blue),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
