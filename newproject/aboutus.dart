import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Title and Logo
              Column(
                children: [
                  Image.asset(
                    'assets/Images/keyboard.jpg',
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Typing Tutor',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.purple,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),

              // Meet Our Team Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Meet Our Team',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Divider(color: Colors.purple),
                      buildKeyValueRow('Developed by', 'Dhairya Dudkiya (23010101075)'),
                      buildKeyValueRow('Mentored by',
                          'Prof. Mehul Bhundiya (Computer Engineering Department), School of Computer Science'),
                      buildKeyValueRow(
                          'Explored by', 'ASWDC, School Of Computer Science, School of Computer Science'),
                      buildKeyValueRow(
                          'Eulogized by', 'Darshan University, Rajkot, Gujarat - INDIA'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // About ASWDC Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About ASWDC',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Divider(color: Colors.purple),
                      Row(
                        children: [
                          Expanded(
                            child: Image.asset(
                              'assets/Images/darshanlogo.jpg', // Update image path
                            ),
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/Images/aswdc.jpg', // Update image path
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands. Students learn cutting-edge technologies, develop real-world applications & experience a professional environment @ ASWDC under the guidance of industry experts & faculty members.',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Contact Us Section
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Contact Us',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                      Divider(color: Colors.purple),
                      buildContactRow(Icons.email, 'aswdc@darshan.ac.in'),
                      buildContactRow(Icons.phone, '+91-9727747317'),
                      buildContactRow(Icons.language, 'www.darshan.ac.in'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Other Links
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      buildLinkRow(Icons.share, 'Share App'),
                      buildLinkRow(Icons.apps, 'More Apps'),
                      buildLinkRow(Icons.star, 'Rate Us'),
                      buildLinkRow(Icons.thumb_up, 'Like us on Facebook'),
                      buildLinkRow(Icons.update, 'Check For Update'),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Footer
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: '© 2025 Darshan University\nAll Rights Reserved - Privacy Policy\nMade with ',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                    children: [
                      WidgetSpan(
                        child: Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 14, // Adjust size to fit with text
                        ),
                      ),
                      const TextSpan(
                        text: ' in India',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildKeyValueRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 2, child: Text('$key: ', style: TextStyle(fontWeight: FontWeight.bold))),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }

  Widget buildContactRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          SizedBox(width: 8),
          Text(info),
        ],
      ),
    );
  }

  Widget buildLinkRow(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.purple),
          SizedBox(width: 8),
          Text(title),
        ],
      ),
    );
  }
}
