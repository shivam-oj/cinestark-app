import 'package:cinestark_app/services/auth.dart';
import 'package:cinestark_app/services/database.dart';
import 'package:cinestark_app/shared/input_decoration.dart';
import 'package:flutter/material.dart';


class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  String firstName = '';
  String? lastName = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const Text(
                "New user? Please register..",
                style: TextStyle(color: Colors.deepPurple, fontSize: 20,fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'First Name'),
                validator: (val) => val!.isEmpty ? 'Please enter your first name' : null,
                onChanged: (val) {
                  setState(() => firstName = val);
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Last Name'),
                onChanged: (val) {
                  setState(() => lastName = val);
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Please enter your email address' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Password'),
                obscureText: true,
                validator: (val) => val!.length < 6 ? 'The password should be at least six characters long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              const SizedBox(height: 10.0),
              ElevatedButton(
                  child: const Text(
                    'Register',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState!.validate()){
                      dynamic result = await _auth.registerWithEmailAndPassword(email, password);
                      if(result == null) {
                        setState(() {
                          error = 'Please supply a valid email';
                        });
                      } else {
                        await DatabaseService(uid: result.uid).updateUserData(firstName, lastName, email);
                      }
                    }
                  }
              ),
              Text(
                error,
                style: const TextStyle(color: Colors.red, fontSize: 14.0),
              )
            ],
          ),
        ),
      );
      // bottomNavigationBar: const CineStarkBottomNavigationBar(),
    // );
  }
}
