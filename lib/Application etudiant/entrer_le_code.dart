import 'package:flutter/material.dart';

class EntrerCode extends StatefulWidget {
  const EntrerCode({super.key});

  @override
  State<EntrerCode> createState() => _EntrerCodeState();
}

class _EntrerCodeState extends State<EntrerCode> {
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _secondController = TextEditingController();
  final TextEditingController _thirdController = TextEditingController();
  final TextEditingController _fourthController = TextEditingController();

  void _submitCode() {
    String enteredCode = _firstController.text +
        _secondController.text +
        _thirdController.text +
        _fourthController.text;

    // Ici, vous pouvez ajouter la logique pour vérifier le code.
    if (enteredCode == "1234") { // Exemple de code correct
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code correct, accès admis.')),
      );
      // Rediriger vers une autre page si nécessaire.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Code incorrect, veuillez réessayer.')),
      );
    }
  }

  Widget _buildCodeField(TextEditingController controller) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          SizedBox(
            height: 100,
          ),
          Text('Entrer le Code',
          style: TextStyle(
             fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 40, 22, 104),
          ),
          
          ),
          SizedBox(
            height: 40,
          ),
          Text('que vous avez reçu dans votre email',
          style: TextStyle(
             fontSize: 15,
                  
                  color: Color.fromARGB(255, 40, 22, 104),
          ),),
          SizedBox(
            height: 120,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCodeField(_firstController),
                    _buildCodeField(_secondController),
                    _buildCodeField(_thirdController),
                    _buildCodeField(_fourthController),
                  ],
                ),
                SizedBox(height: 60),
               ElevatedButton(
                onPressed: (){},
                
                child: Text(
                  "Vérifier",
                  style: TextStyle(fontSize:21 , color: Colors.white),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 147, 236, 120),
                    ),
                    padding: MaterialStateProperty.all(EdgeInsets.all(12)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
              ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}