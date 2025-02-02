import 'package:flutter/material.dart';

class AddUserPage extends StatefulWidget {
  final Function(Map<String, dynamic>) onUserAdded;
  final Map<String, dynamic>? existingUser;

  AddUserPage({required this.onUserAdded, this.existingUser});

  @override
  _AddUserPageState createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  String gender = "Male";
  final List<String> genderOptions = ["Male", "Female", "Other"];
  String? selectedCity;
  final List<String> cities = ["New York", "Los Angeles", "Chicago", "Houston", "Miami"];
  final Map<String, bool> hobbies = {
    "Reading": false,
    "Music": false,
    "Sports": false,
    "Traveling": false,
    "Gaming": false,
  };

  @override
  void initState() {
    super.initState();
    if (widget.existingUser != null) {
      nameController.text = widget.existingUser!['name'] ?? "";
      emailController.text = widget.existingUser!['email'] ?? "";
      phoneController.text = widget.existingUser!['phone'] ?? "";
      addressController.text = widget.existingUser!['address'] ?? "";
      dateController.text = widget.existingUser!['date'] ?? "";
      gender = widget.existingUser!['gender'] ?? "Male";
      selectedCity = widget.existingUser!['city'];
      for (var hobby in hobbies.keys) {
        hobbies[hobby] = widget.existingUser!['hobbies']?.contains(hobby) ?? false;
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingUser == null ? 'Add User' : 'Edit User'),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Make app bar transparent
        elevation: 0, // Remove app bar shadow
      ),
      body: Stack(
        children: [
          // Form Content
          Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.8), // Semi-transparent white
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildTextField(nameController, "Full Name", Icons.person),
                            _buildTextField(emailController, "Email", Icons.email),
                            _buildTextField(phoneController, "Phone", Icons.phone),
                            _buildTextField(addressController, "Address", Icons.home),
                            _buildDateField(context),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.8), // Semi-transparent white
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          children: [
                            _buildDropdown("Gender", genderOptions, gender, (value) {
                              setState(() {
                                gender = value!;
                              });
                            }),
                            SizedBox(height: 10),
                            _buildDropdown("City", cities, selectedCity, (value) {
                              setState(() {
                                selectedCity = value;
                              });
                            }),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      color: Colors.white.withOpacity(0.8), // Semi-transparent white
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Hobbies", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Column(
                              children: hobbies.keys.map((hobby) {
                                return CheckboxListTile(
                                  title: Text(hobby),
                                  value: hobbies[hobby],
                                  onChanged: (bool? value) {
                                    setState(() {
                                      hobbies[hobby] = value ?? false;
                                    });
                                  },
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onUserAdded({
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone': phoneController.text,
                            'address': addressController.text,
                            'date': dateController.text,
                            'gender': gender,
                            'city': selectedCity,
                            'hobbies': hobbies.entries.where((hobby) => hobby.value).map((hobby) => hobby.key).toList(),
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: Text(widget.existingUser == null ? 'Add User' : 'Update User'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Colors.blue.withOpacity(0.9), // Semi-transparent button
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9), // Semi-transparent white
        ),
        validator: (value) => value == null || value.isEmpty ? "$label is required" : null,
      ),
    );
  }

  Widget _buildDateField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: dateController,
        decoration: InputDecoration(
          labelText: "Date of Birth",
          prefixIcon: Icon(Icons.calendar_today),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9), // Semi-transparent white
        ),
        onTap: () => _selectDate(context),
        validator: (value) => value == null || value.isEmpty ? "Date of Birth is required" : null,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9), // Semi-transparent white
      ),
      items: items.map((item) => DropdownMenuItem(value: item, child: Text(item))).toList(),
      onChanged: onChanged,
      validator: (value) => value == null ? "Please select a $label" : null,
    );
  }
}