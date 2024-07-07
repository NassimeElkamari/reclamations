import 'package:application_gestion_des_reclamations_pfe/Application%20etudiant/Home_Screens/mesReclamations.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DetailsPage extends StatefulWidget {
  final Map<String, dynamic> reclamationData;

  DetailsPage({required this.reclamationData});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  late TextEditingController _sujetController;
  late TextEditingController _nomEtudiantController;
  late TextEditingController _nomEnseignantController;
  late TextEditingController _descriptionController;

  List<DropdownMenuItem<String>> _professorItems = [];
  Map<String, String> professorEmails = {}; // Map to store professor emails

  String? _selectedChoice;
  String? _selectedProfessor;

  @override
  void initState() {
      
    super.initState();
    _sujetController =TextEditingController(text: widget.reclamationData['sujet']);
   
    _nomEtudiantController =TextEditingController(text: widget.reclamationData['nomEtudiant']);
    _nomEnseignantController =TextEditingController(text: widget.reclamationData['nomEnseignant']);
    _descriptionController =TextEditingController(text: widget.reclamationData['description']);
    _selectedChoice = widget.reclamationData['sujet'];
    _selectedProfessor = widget.reclamationData['nomEnseignant'];
    _loadProfessors();
  }

  Future<void> _loadProfessors() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('enseignants').get();
      List<DropdownMenuItem<String>> items = querySnapshot.docs.map((doc) {
        String nom = doc['nom'];
        String prenom = doc['prenom'];
        String email = doc['email'];

        String fullName = '$nom $prenom'; // Concaténer le nom et le prénom
        professorEmails[fullName] = email; // Store the email in the map

        return DropdownMenuItem<String>(
          value: fullName, // Utilisez le nom complet comme valeur
          child: Text(fullName),
        );
      }).toList();
      setState(() {
        _professorItems = items;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du chargement des professeurs')),
      );
    }
  }

  @override
  void dispose() {
    _sujetController.dispose();
    _nomEtudiantController.dispose();
    _nomEnseignantController.dispose();
   
    super.dispose();
  }
void deleteReclamation(BuildContext context) async {
  String? documentId = widget.reclamationData['idReclamation'];
  if (documentId != null) {
    try {
      bool confirmDelete = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirmer la suppression"),
            content: Text("Êtes-vous sûr de vouloir supprimer cette réclamation ?"),
            actions: <Widget>[
              TextButton(
                child: Text("Annuler"),
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false to indicate cancellation
                },
              ),
              TextButton(
                child: Text("Supprimer"),
                onPressed: () {
                  Navigator.of(context).pop(true); // Return true to indicate confirmation
                },
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        await FirebaseFirestore.instance
            .collection('reclamations')
            .doc(documentId)
            .delete();
            widget.reclamationData['deleted']==true ;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Réclamation supprimée avec succès')),
        );

        // Retour à la page précédente après la suppression
        Navigator.pop(context);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de la suppression de la réclamation : $e'),
        ),
      );
      print('Erreur lors de la suppression de la réclamation : $e');
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Impossible de trouver l\'identifiant de la réclamation.'),
      ),
    );
    print('Impossible de trouver l\'identifiant de la réclamation.');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 55, 105, 172),
        title: Text(
          'Détails de la réclamation',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MesReclamations(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
          onPressed: () {
            deleteReclamation(context) ;
              // Appeler la fonction de suppression
          },
          icon: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        ],
      ),
      body:ListView(
  children: [
    SizedBox(
      height: 15,
    ),
    _buildDetailSection("Sujet :", widget.reclamationData['sujet']),
    _buildDetailSection("Nom étudiant :", widget.reclamationData['nomEtudiant']),
    _buildDetailSection("Nom de l'enseignant:", widget.reclamationData['nomEnseignant']),
    _buildDetailSection("Description:", widget.reclamationData['description'], isDescription: true),
    if (widget.reclamationData["status"]) ...[
      _buildDetailSection("Réponse de l'enseignant:", widget.reclamationData['reponse']),
    ],
    _buildDetailSection("Date :", (widget.reclamationData['date'] as Timestamp).toDate().toString()),
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 238, 116, 17),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Close the current modal
          _showEditModal(context); // Show the edit modal
        },
        child: Text(
          'Modifier',
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
)

    );
  }

  Widget _buildDetailSection(String label, String value,
      {bool isDescription = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
       
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 55, 105, 172),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14, bottom: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 5),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 8, right: 8, top: 12),
                  constraints: isDescription
                      ? BoxConstraints()
                      : BoxConstraints(maxHeight: 40),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color:  Color.fromARGB(255, 228, 240, 255),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Color.fromARGB(255, 238, 116, 17),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Color.fromARGB(255, 195, 195, 195),
                        offset: Offset(1.0, 1.0),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 17,
                        color: Color.fromARGB(255, 33, 100, 243),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showEditModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.7,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Modifier les informations',
                      style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    buildDropdownField(
                      'Choisissez le sujet de la réclamation:',
                      _selectedChoice,
                      ['Vérification de note', 'Consultation de copie'],
                      (String? newValue) {
                        setState(() {
                          _selectedChoice = newValue!;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    //pour choisir le professeur
                    buildDropdownField(
                      'Choisissez le professeur:',
                      _selectedProfessor,
                      _professorItems,
                      (String? newValue) {
                        setState(() {
                          _selectedProfessor = newValue;
                        });
                      },
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _descriptionController,
                        style: TextStyle(
                        color: Color.fromARGB(255, 55, 105, 172), // Couleur du texte dans le TextField
                      ),
                      decoration: InputDecoration(
                        labelText: 'Nom',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 238, 116, 17), // Couleur du texte du label
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 238, 116,
                                17), // Couleur de la bordure par défaut
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(255, 238, 116,
                                17), // Couleur de la bordure lorsqu'elle est sélectionnée
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 84, 132, 196),
                        ),
                      ),
                      onPressed: () {
                        _updateReclamationInfo();
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Enregistrer',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildDropdownField(
    String label,
    String? currentValue,
    List<dynamic> items,
    ValueChanged<String?> onChanged,
  ) {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 17,
              color: Color.fromARGB(255, 55, 105, 172),
            ),
          ),
          DropdownButtonFormField<String>(
            value: currentValue,
            onChanged: onChanged,
            items: items is List<DropdownMenuItem<String>>
                ? items
                : items.map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: TextStyle(
                          color: Color.fromARGB(
                              255, 9, 61, 156), // Changer la couleur ici
                        ),
                      ),
                    );
                  }).toList(),
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromARGB(255, 241, 239, 239),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            dropdownColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 55, 105, 172),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            filled: true,
            fillColor: Color.fromARGB(255, 241, 239, 239),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          style: TextStyle(
            fontSize: 17,
            color: Color.fromARGB(255, 55, 105, 172),
          ),
        ),
      ],
    );
  }
  
Future<void> _updateReclamationInfo() async {
  try {
    // Récupérer l'ID du document de la réclamation
    String? documentId = widget.reclamationData['idReclamation'];
    // Récupérer l'email du professeur sélectionné
    String? professorEmail = professorEmails[_selectedProfessor];

    // Vérifier si l'ID du document n'est pas null
    if (documentId != null) {
      // Mettre à jour le document de la réclamation avec les nouvelles valeurs des champs d'entrée
      await FirebaseFirestore.instance
          .collection('reclamations')
          .doc(documentId)
          .update({
        'sujet': _selectedChoice,
        'nomEnseignant': _selectedProfessor,
        'description': _descriptionController.text,
        'email': professorEmail,
      });

      // Afficher un message de réussite
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Réclamation mise à jour avec succès')),
      );

      // Mettre à jour l'état local avec les nouvelles valeurs
      setState(() {
        widget.reclamationData['sujet'] = _selectedChoice;
        widget.reclamationData['nomEnseignant'] = _selectedProfessor;
        widget.reclamationData['description'] = _descriptionController.text;
        widget.reclamationData['email'] = professorEmail;
      });
    } else {
      // Afficher un message d'erreur si l'ID du document est null
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('ID de document non trouvé')),
      );
    }
  } catch (e) {
    // Afficher un message d'erreur en cas d'échec de mise à jour
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur lors de la mise à jour de la réclamation')),
    );
  }
}
}