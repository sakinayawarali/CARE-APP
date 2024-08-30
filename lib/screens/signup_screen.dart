import 'package:care_app/colours/colors.dart';
import 'package:care_app/screens/signin_screen.dart';
import 'package:care_app/widgets/form_widgets.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  String? confirmPassword;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 249, 250, 1), // Background color
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/IMG_4555.PNG', 
                  height: 100, 
                  width: 100, 
                ),
                const SizedBox(height: 20),
                Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.black, // Heading text color
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    }
                    return null;
                  },
                  onSaved: (value) => password = value,
                ),
                const SizedBox(height: 20),
                CustomFormField(
                  label: 'Confirm Password',
                  obscureText: !_isConfirmPasswordVisible,
                  isPasswordVisible: _isConfirmPasswordVisible,
                  onSuffixIconPressed: () {
                    setState(() {
                      _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                    });
                  },
                  prefixIcon: Icons.lock,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty";
                    } else if (value != password) {
                      return "Passwords do not match";
                    }
                    return null;
                  },
                  onSaved: (value) => confirmPassword = value,
                ),
                const SizedBox(height: 20),
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
                      // Normally you would handle sign up here
                      // For now, we'll just show a dialog or something
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("Sign Up Successful"),
                          content: const Text("User Signed Up Successfully!"),
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
                          'Error Signing Up. Please check your form.');
                    }
                  },
                  child: const Text('Sign Up',
                      style: TextStyle(color: Colors.white)), // Button text color
                ),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: 'Have an account? ',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Log in',
                          style: TextStyle(
                            color: Color.fromRGBO(241, 120, 182, 1), // Link color
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
