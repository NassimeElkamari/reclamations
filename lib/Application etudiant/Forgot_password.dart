

// ignore_for_file: sized_box_for_whitespace, prefer_const_constructors


import 'package:application_gestion_des_reclamations_pfe/Application%20enseignant/sign_in_enseignant.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/auth/signup.dart';
import 'package:flutter/material.dart';
class ForgotPasswordEtudiant extends StatelessWidget {
  const ForgotPasswordEtudiant({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
            }, 
            icon: Icon(Icons.arrow_back,color: Colors.white70,)),
          title: Text(
                      "   Forgot Password ",
                      style:TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ) ,
                      ),
          backgroundColor: Color.fromARGB(255, 100, 164, 216),
        ),
        body:SingleChildScrollView(
          child: Column(
            children: [
              
                Image.asset("images/forgot_password.png"),
                SizedBox(
                 height: 10,
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "entrer votre email adresse. ",
                    style:TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.normal,
                            color: Color.fromARGB(255, 26, 11, 158),
                          ) ,),
                ),
                Text(
                  "Vous allez recevoir un code . ",
                  style:TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.normal,
                          color:  Color.fromARGB(255, 26, 11, 158),
                        ) ,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(23.0),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      
                        decoration: InputDecoration(
                          
                          border: OutlineInputBorder
                          (borderRadius:BorderRadius.circular(10) ,
          
                          ),
                          suffixIcon: Icon(Icons.check,color:  Color.fromARGB(192, 6, 56, 78),),
                          label: Text(
                            "Gmail",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 19, 3, 78),
                            ),
                            ),
                            
                        ),
                        style: TextStyle( color:  Colors.white),
                        cursorColor: Colors.white,
                      ),
                  ),
                  
                  ElevatedButton(
                  
                        onPressed: () {
                           
                        },
                        child: Text(
                          "ENVOYER",
                          style: TextStyle(fontSize: 19, color: Colors.white),
                          
                        ),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Color.fromARGB(255, 212, 148, 241),),
                            padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)))),
                      ),
                      SizedBox(
                      height: 20,
                      ),
          
                       Row(
                      mainAxisAlignment: MainAxisAlignment.center,   //au centre 
                      children: [
                        Text(
                          "Doesn't have account yet ? ",
                           style: TextStyle(
                            color: Color.fromARGB(255, 12, 25, 80),
                          fontSize: 18
                        ),
                        ),
                        TextButton(
                          onPressed: (){Navigator.pushReplacement(      // quand je click sur sign up  il va me donner la âge sign in 
                              context, 
                               MaterialPageRoute(builder: (context) =>const SignUp()
                                
                               ),
                              );},
                           child:   Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Color.fromARGB(255, 53, 17, 70),
                              fontSize: 18,
                            ),
                           )
                           )
                      ],
                    )
              
            ],
          ),
        ) ,
      ),
    );
  }
}