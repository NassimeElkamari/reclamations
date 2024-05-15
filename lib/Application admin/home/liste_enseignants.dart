import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/1.ensignants/ajouter_enseignant.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListeDesEnseignants extends StatefulWidget {
  const ListeDesEnseignants({Key? key}) : super(key: key);

  @override
  State<ListeDesEnseignants> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListeDesEnseignants> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "          Enseignants",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add),
            color: Colors.white,
            onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AjouterEnseignant()));
            
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                suffixIcon: Icon(Icons.search, color: Color.fromARGB(255, 13, 41, 133)),
                labelText: 'Rechercher un enseignant',
                labelStyle: TextStyle(color: Color.fromARGB(255, 13, 41, 133)),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 13, 41, 133)),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 13, 41, 133)),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Rafraîchir l'affichage lors de la saisie
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("enseignants").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Une erreur est survenue');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;
                final filteredData = _searchController.text.isEmpty
                    ? documents
                    : documents.where((doc) {
                        final String searchTerm = _searchController.text.toLowerCase();
                        return doc['nom'].toString().toLowerCase().startsWith(searchTerm) ||
                            doc['prenom'].toString().toLowerCase().startsWith(searchTerm);
                      }).toList();

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document = filteredData[index];
                    return InkWell(
                      onTap: () {
                        // Action à effectuer lorsque l'utilisateur appuie sur un enseignant
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Confirmation"),
                              content: Text('Voulez-vous supprimer cet enseignant?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Annuler'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance.collection('enseignants').doc(document.id).delete();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Supprimer'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        height: 70,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 28, 51, 128),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Container(
                              height: 50,
                              width: 50,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(document['profile']),
                                radius: 20,
                              ),
                            ),
                            SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '${document['nom']} ${document['prenom']}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

