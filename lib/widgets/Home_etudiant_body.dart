import 'package:application_gestion_des_reclamations_pfe/Models/cas_utilisation.dart';
import 'package:application_gestion_des_reclamations_pfe/widgets/fonction_card.dart';
import 'package:flutter/material.dart';



class HomeEtudiantBody extends StatelessWidget {
  const HomeEtudiantBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
         
        /*  Container(
  margin: EdgeInsets.only(right: 18, left: 18),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 233, 106, 106),
    borderRadius: BorderRadius.circular(20),
  ),
  height: 250,
 // child:Image.asset("images/anonce.png",fit: BoxFit.cover,)
),*/


        Container(

           height: 100,
           width: 100,
          child: Image.asset("images/education (2).png")
          ),

          SizedBox(height: 20),


          //*******  bare de recherche ******* */
          Container(
            margin: EdgeInsets.only(left: 18,right: 18),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 243, 204, 243),
              borderRadius: BorderRadius.circular(20),
            ),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher...',
                hintStyle: TextStyle(color: Color.fromARGB(255, 99, 161, 255)),
                icon: Icon(Icons.search, color: Color.fromARGB(255, 99, 161, 255)),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                // Ajoutez ici la logique de recherche en fonction de la valeur saisie
              },
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: liste_fonctions.length,
              itemBuilder: (context, index) => fonction_card(
                itemIndex: index,
                cas_utili: liste_fonctions[index], press: (){},
              ),
            ),
          ),

          ///**************button qui doit  naviger a la page d ajouter une reclamation  */
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: EdgeInsets.only(bottom: 10, right: 10),
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape
                    .circle, // Définir la forme du conteneur comme un cercle
              ),
              child: ElevatedButton(
                onPressed: () {
                  // Ajoutez ici la logique que vous souhaitez exécuter lorsque le bouton est pressé
                },
                child: Icon(Icons.add),
                style: ElevatedButton.styleFrom(
                  shape:
                      CircleBorder(), // Pour rendre le bouton circulaire à l'intérieur du conteneur circulaire
                  padding: EdgeInsets.all(
                      0), // Aucun espace de remplissage à l'intérieur du bouton
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
