import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:application_gestion_des_reclamations_pfe/Application admin/home/etudiant_details.dart';

class ListeDesEtudiants extends StatefulWidget {
  const ListeDesEtudiants({Key? key}) : super(key: key);

  @override
  State<ListeDesEtudiants> createState() => _ListeDesEtudiantsState();
}

class _ListeDesEtudiantsState extends State<ListeDesEtudiants> {
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
        title: Text(
          "Liste des Étudiants",
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 28, 51, 128),
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
                suffixIcon: Icon(Icons.search),
                labelText: 'Rechercher un étudiant',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (value) {
                setState(() {}); // Rafraîchir l'affichage lors de la saisie
              },
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection("etudiantsActives").snapshots(),
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
                        final String nom = doc['nom'].toString().toLowerCase();
                        final String prenom = doc['prenom'].toString().toLowerCase();
                        final String apoge = doc['apoge'].toString().toLowerCase();

                        return nom.startsWith(searchTerm) ||
                            prenom.startsWith(searchTerm) ||
                            apoge.startsWith(searchTerm);
                      }).toList();

                return ListView.builder(
                  itemCount: filteredData.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document = filteredData[index];
                    final nom = document['nom'];
                    final prenom = document['prenom'] ?? '';
                    final apoge = document['apoge'];

                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromARGB(255, 13, 41, 133),
                          width: 2
                        ),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 210, 225, 255).withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          '$nom $prenom',
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 41, 133),
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          'Apoge: $apoge',
                          style: TextStyle(
                            color: Color.fromARGB(255, 13, 41, 133),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsEtudiant(documentId: document.id),
                            ),
                          );
                        },
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
