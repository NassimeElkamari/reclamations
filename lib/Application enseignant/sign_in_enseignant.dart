// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:application_gestion_des_reclamations_pfe/Application%20commune/Welcome.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/Forgot_password_old.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInEnseignant extends StatefulWidget {
  const SignInEnseignant({super.key});

  @override
  State<SignInEnseignant> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInEnseignant> {
  



  final _formSignInKey = GlobalKey<FormState>();
  bool rememberPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 87, 118, 184),
      body: Column(
        children: [
          SizedBox(
            height: 38,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()));
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white70,
                  )),
            ],
          ),
          Container(
            height: 80,
            width: double.infinity,
            child: Center(
              child: Text(
                'Welcome back',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w900,
                  color: Color.fromARGB(255, 214, 228, 255),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(
              padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Form(
                  key: _formSignInKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 1, left: 40),
                          child: Image.asset(
                            "images/login.png",
                            height: 260,
                          )),
                      const SizedBox(
                        height: 30.0,
                      ),
                      TextFormField(
                       
                        onChanged: (value) {
                          //_emailController=value;
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            'Email',
                            style: TextStyle(
                                color: Color.fromARGB(255, 9, 61, 156)),
                          ),
                          hintText: 'Enter Email',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(66, 0, 8, 53),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                  31, 2, 19, 56), // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                  31, 1, 4, 51), // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      TextFormField(
                      
                        onChanged: (value) {
                         // password=value;
                        },
                        obscureText: true,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          label: const Text(
                            'Password',
                            style: TextStyle(
                                color: Color.fromARGB(255, 9, 61, 156)),
                          ),
                          hintText: 'Enter Password',
                          hintStyle: const TextStyle(
                            color: Color.fromARGB(31, 2, 19, 56),
                          ),
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Color.fromARGB(
                                  31, 1, 4, 51), // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.black12, // Default border color
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              /* Checkbox(
                                value: rememberPassword,
                                onChanged: (bool? value) {
                                  setState(() {
                                    rememberPassword = value!;
                                  });
                                },
                                activeColor: Colors.pink,
                              ),
                              const Text(
                                'Remember me',
                                style: TextStyle(
                                  color: Colors.black45,
                                ),
                              ),*/
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ForgotPasswordOld()));
                            },
                            child: Text(
                              'Forget password?',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 115, 124, 163),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: 
                            (){},
                            /*
                            if (_formSignInKey.currentState!.validate() &&
                                rememberPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Processing Data'),
                                ),
                              );
                            } else if (!rememberPassword) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        'Please agree to the processing of personal data')
                                        ),
                                        
                              );*/
                              
                          
                          child: const Text('Sign up'),
                        ),
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
