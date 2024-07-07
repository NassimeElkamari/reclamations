import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Corbeille extends StatefulWidget {
  const Corbeille({Key? key}) : super(key: key);

  @override
  State<Corbeille> createState() => _CorbeilleState();
}

class _CorbeilleState extends State<Corbeille> {
  String? apoge;

  @override
  void initState() {
    super.initState();
    _loadApoge();
  }

  Future<void> _loadApoge() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? apoge = prefs.getString('apogeConnecte');
    if (apoge != null) {
      setState(() {
        this.apoge = apoge;
      });
    } else {
      print('No apoge found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Corbeille",
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('reclamations')
            .where('apogeEtudiant', isEqualTo: apoge)
            .where('deleted', isEqualTo: true) // Filtrer les réclamations supprimées
            .orderBy('date', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Aucune réclamation supprimée trouvée.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return Container(
                margin: EdgeInsets.symmetric(vertical: 17, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color.fromARGB(255, 238, 116, 17),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    data['sujet'],
                    style: TextStyle(
                      fontSize: 21,
                      color: Color.fromARGB(255, 55, 105, 172),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10),
                          Icon(
                            Icons.arrow_forward,
                            size: 10,
                            color: Color.fromARGB(255, 238, 116, 17),
                          ),
                          Text(
                            ' Professeur:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Color.fromARGB(255, 238, 116, 17),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            '${data['nomEnseignant']}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 28, 51, 128),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                  trailing: Icon(
                    Icons.arrow_forward,
                    color: data['status'] == true ? Colors.green : Colors.red,
                  ),
                  onTap: () {
                    // Naviguer vers la page de détails lorsque l'utilisateur appuie sur une réclamation
                    /* Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(reclamationData: data),
                      ),
                    ); */
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
