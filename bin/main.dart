/* Class: MAD9135
 * Assignment: Hybrid-04
 * Student Name: Brodie Lewis
 * Number: 040 734 911
 * Date: Feb 1 2025
 * Repo: https://github.com/lewi0239/MAD9135-hybrid-04
 */

import 'package:http/http.dart' as http;
import 'dart:convert';

// Define a User class to represent user data
class User {
  final int id;
  final String firstName;
  final String lastName;

  // Constructor to initialize User attributes
  User({required this.id, required this.firstName, required this.lastName});

  // Factory method to create a User from JSON data
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }

  // Method to print user details in a formatted way
  void printUser() {
    print('ID: $id, Name: $firstName $lastName');
  }

  // Overriding toString() for better output when printing User objects
  @override
  String toString() {
    return 'User(ID: $id, Name: $firstName $lastName)';
  }
}

void main() async {
  // Define the API endpoint URL to fetch user data
  var url = Uri.parse('https://random-data-api.com/api/v2/users?size=12');
  try {
    // Send HTTP GET request to fetch user data
    final response = await http.get(url);

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Decode JSON response into a list of dynamic objects
      List<dynamic> data = jsonDecode(response.body);

      // Convert JSON data into a list of User objects
      List<User> users =
          data.map((userJson) => User.fromJson(userJson)).toList();

      // Loop through the list of users and print their details
      for (var user in users) {
        user.printUser();
      }
    } else {
      print('Failed to load users. Status code: ${response.statusCode}');
    }
  } catch (err) {
    // Handle any potential errors during the HTTP request
    print('Failed to make HTTP request: $err');
  }

  // Instantiate a single User object for testing
  var randomUser = User(id: 40734911, firstName: "Brodie", lastName: "Lewis");

  // Print the instantiated User object using the overridden toString() method
  print(randomUser);
}
