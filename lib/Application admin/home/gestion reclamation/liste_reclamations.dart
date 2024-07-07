// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:application_gestion_des_reclamations_pfe/Application%20admin/home/gestion%20reclamation/reclamation_details.dart';

enum SortingOrder { ascending, descending }

class ListeDesReclamations extends StatefulWidget {
  const ListeDesReclamations({Key? key}) : super(key: key);

  @override
  State<ListeDesReclamations> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListeDesReclamations> {
  final TextEditingController _searchController = TextEditingController();
  SortingOrder sortingOrder = SortingOrder.descending;
  bool showResolved = false; // Nouvelle variable pour suivre l'état de l'affichage des réclamations traitées

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            sortingOrder == SortingOrder.ascending ? Icons.arrow_upward : Icons.arrow_downward,
          ),
          color: Colors.white,
          onPressed: () {
            setState(() {
              sortingOrder = sortingOrder == SortingOrder.ascending ? SortingOrder.descending : SortingOrder.ascending;
            });
          },
        ),
        title: Center(
          child: Text(
            "Réclamations",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor:Color.fromARGB(255, 55, 105, 172),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                showResolved = !showResolved; // Inverser l'état de l'affichage des réclamations traitées
              });
            },
            icon: Icon(
              Icons.verified,
              color: showResolved ? Colors.green : Colors.red, // Couleur de l'icône en fonction de l'état
            ),
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
                suffixIcon: Icon(Icons.search, color: Color.fromARGB(255, 55, 105, 172),),
                labelText: 'Rechercher une réclamation',
                labelStyle: TextStyle(color:Color.fromARGB(255, 55, 105, 172),),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 55, 105, 172),),
                  borderRadius: BorderRadius.circular(30),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color.fromARGB(255, 55, 105, 172),),
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
              stream: FirebaseFirestore.instance.collection("reclamations").snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Une erreur est survenue');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

                // Filtrer les données en fonction de l'état de showResolved
                documents = documents.where((doc) => doc['status'] == showResolved).toList();

                // Filtrer les données
                documents = _searchController.text.isEmpty
                    ? documents
                    : documents.where((doc) {
                  final String searchTerm = _searchController.text.toLowerCase();
                  return doc['sujet'].toString().toLowerCase().contains(searchTerm) ||
                      doc['description'].toString().toLowerCase().contains(searchTerm);
                }).toList();

                // Trier par date si activé
                documents.sort((a, b) {
                  Timestamp timestampA = a['date'];
                  Timestamp timestampB = b['date'];
                  if (sortingOrder == SortingOrder.ascending) {
                    return timestampA.compareTo(timestampB);
                  } else {
                    return timestampB.compareTo(timestampA);
                  }
                });

                return ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final DocumentSnapshot document = documents[index];
                    final bool status = document['status']; // Accéder à l'attribut status
                    final Timestamp timestamp = document['date']; // Accéder à l'attribut date
                    final DateTime date = timestamp.toDate(); // Convertir en DateTime

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsReclamation(document: document),
                          ),
                        );
                      },
                      child: Container(
                        height: 110,
                        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color.fromARGB(255, 55, 105, 172),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Center(
                                  child: Text(
                                    'Sujet: ${document['sujet']}',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Icon(
                                  status ? Icons.check_circle : Icons.access_time, // Utilisation de l'icône en fonction de l'état status
                                  color: status ? Colors.green : Colors.orange,
                                ),
                              ],
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Nom de l\'enseignant: ${document['nomEnseignant']}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                SizedBox(width: 185,),
                                Text(
                                  'Date: ${DateFormat('dd/MM/yyyy').format(date)}', // Formater la date
                                  style: TextStyle(
                                    fontSize: 14,
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
