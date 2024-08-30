import 'package:care_app/colours/colors.dart';
import 'package:care_app/screens/signup_screen.dart';
import 'package:care_app/widgets/form_widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 250, 1), // Background color
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'lib/assets/IMG_4555.PNG', 
                height: 100,
              ),
              const SizedBox(height: 20),
              Text(
                'Log In',
                style: TextStyle(
                  color: Colors.black, // Login text color
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Please login to continue using our app',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomFormField(
                      label: 'Email',
                      prefixIcon: Icons.email,
                      validator: (value) => value?.isNotEmpty ?? false
                          ? null
                          : "Email cannot be empty",
                      onSaved: (value) => email = value,
                    ),
                    const SizedBox(height: 20),
                    CustomFormField(
                      label: 'Password',
                      obscureText: !_isPasswordVisible,
                      isPasswordVisible: _isPasswordVisible,
                      onSuffixIconPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                      prefixIcon: Icons.lock,
                      validator: (value) => value?.isNotEmpty ?? false
                          ? null
                          : "Password cannot be empty",
                      onSaved: (value) => password = value,
                    ),
                    const SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Add your forgot password logic here
                        },
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Color.fromRGBO(196, 89, 145, 1)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(241, 120, 182, 1), // Button background color
                        fixedSize: Size(
                          (MediaQuery.of(context).size.width * 0.8),
                          (MediaQuery.of(context).size.height * 0.07),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          _formKey.currentState?.save();
                          // Normally you would handle login here
                          // For now, we'll just show a dialog or something
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text("Login Successful"),
                              content: const Text("User Logged In Successfully!"),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text("OK"),
                                ),
                              ],
                            ),
                          );
                        } else {
                          showErrorDialog(context,
                              'Error Logging In. Please check your credentials.');
                        }
                      },
                      child: const Text('Log In',
                          style: TextStyle(color: Colors.white)), // Button text color
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromRGBO(241, 120, 182, 1), backgroundColor: Colors.white, // Button text color
                        fixedSize: Size(
                          (MediaQuery.of(context).size.width * 0.8),
                          (MediaQuery.of(context).size.height * 0.07),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        "Don't have an account? Sign Up",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Or connect with',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Image.asset(
                            'lib/assets/google_logo.png',
                            height: 30, // Adjust the size of the Google logo here
                            width: 30,
                          ),
                          onPressed: () {
                            // Add your Google login logic here
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
