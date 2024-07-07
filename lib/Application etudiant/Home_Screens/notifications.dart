import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ButtomnavigatorBar.dart';
import 'details_reclamations_etd.dart';

class listedesNotifications extends StatefulWidget {
  const listedesNotifications({super.key});

  @override
  State<listedesNotifications> createState() => _listedesNotificationsState();
}

class _listedesNotificationsState extends State<listedesNotifications> {
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
        print('Apoge loaded: $apoge'); // Debug print
      });
    } else {
      print('No apoge found in SharedPreferences');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        title: Row(
          children: [
            SizedBox(width: 100),
            Text(
              "Notifications",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
      body: apoge == null
          ? Center(child: CircularProgressIndicator()) // Show loading if apoge is not loaded yet
          : StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('reclamations')
                  .where('apogeEtudiant', isEqualTo: apoge)
                  .where('status', isEqualTo: true)
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
                  return Center(child: Text('Aucune réclamation trouvée.'));
                }

               // print('Data received: ${snapshot.data!.docs.length} documents'); // Debug print

                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                    print('Document data: $data'); // Debug print
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
                                SizedBox(
                                  width: 10,
                                ),
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
                                SizedBox(
                                  width: 5,
                                ),
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
                             Text(
                                  '${data['reponse']}',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 28, 51, 128),
                                  ),
                                ),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailsPage(reclamationData: data),
                            ),
                          );
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
