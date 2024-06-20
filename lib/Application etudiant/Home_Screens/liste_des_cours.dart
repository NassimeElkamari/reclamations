import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListedesCours extends StatefulWidget {
  const ListedesCours({super.key});

  @override
  State<ListedesCours> createState() => _ListedesCoursState();
}

class _ListedesCoursState extends State<ListedesCours> {
  // Example list of courses with associated links
  final List<Course> courses = [
    Course('Mathematics Basics', 'https://drive.google.com/drive/folders/1UR2Ns5E05GhHK1O-sbWjCtAJ7J_xMasr'),
    Course('Introduction to Programming', 'https://www.example.com/intro_programming'),
    Course('Advanced Physics', 'https://www.example.com/advanced_physics'),
    Course('Chemistry for Beginners', 'https://www.example.com/chemistry_beginners'),
    Course('History of Art', 'https://www.example.com/history_of_art'),
    Course('Creative Writing', 'https://www.example.com/creative_writing'),
    Course('Data Science 101', 'https://www.example.com/data_science_101'),
    Course('Mobile App Development', 'https://www.example.com/mobile_app_development'),
    Course('Web Development Essentials', 'https://www.example.com/web_dev_essentials'),
    Course('Artificial Intelligence', 'https://www.example.com/artificial_intelligence'),
  ];

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 84, 132, 196),
        title: Center(
          child: Text(
            "Liste des Cours",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                courses[index].title,
                style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 55, 105, 172)),
              ),
              onTap: () {
                _launchUrl(courses[index].url);
              },
            ),
          );
        },
      ),
    );
  }
}

class Course {
  final String title;
  final String url;

  Course(this.title, this.url);
}
