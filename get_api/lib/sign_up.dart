import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Use single import alias for clarity

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Always remember to dispose controllers to prevent memory leaks
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login(String email, String password) async {
    try {
      // Use the aliased http.post syntax explicitly
      http.Response response = await http.post(
        Uri.parse('https://reqres.in/api/register'),
        body: {
          'email': email,
          'password': password,
        },
      );

      // Handle both standard successful response codes
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registration Successful: ${response.body}");
      } else {
        print("Failed with status code: ${response.statusCode}");
        print("Error response: ${response.body}");
      }
    } catch (e) {
      print("Network or parsing error: $e");
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adds breathing room around edges
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress, // Optimizes key layout
              decoration: InputDecoration(
                hintText: 'Enter your email', // Fixed: Expects String, not Widget
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 25),
            TextFormField(
              controller: passwordController,
              obscureText: true, // Keeps typing passwords hidden
              decoration: InputDecoration(
                hintText: 'Enter password', // Fixed: Expects String, not Widget
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                // Simplified text pull
                login(emailController.text, passwordController.text);
              },
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Center(
                  child: Text(
                    "Sign UP",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
