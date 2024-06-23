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
    Course('Apprendre PHP et MySQL', 'https://drive.google.com/drive/folders/1UR2Ns5E05GhHK1O-sbWjCtAJ7J_xMasr'),
    Course('Apprendre Python', 'https://drive.google.com/open?id=1D8e8HFrpokDyGQyzaXlTucvc7qEmrczE'),
    Course('Développent web ', 'https://drive.google.com/drive/u/0/folders/1Cyjert26SxAkLlLI8eU0bMG8oS0-CjPC'),
    Course('Introduction to Python Programming', 'https://www.udemy.com/course/introduction-to-python-for-beginners/learn/lecture/40044936#overview'),
    Course('Learn Fundamentals of Programming in Machine Learning', 'https://www.udemy.com/course/learn-fundamentals-of-programming-in-machine-learning/learn/lecture/43227350#overview'),
    Course('UX Design Career Guide: Essential Skills for Growth, Success', 'https://www.udemy.com/course/ui-ux-design-course-free-learn-online-by-prasad-kantamneni/learn/lecture/41340012#overview'),
    Course('Soft skills to be happy and productive in science / academia', 'https://www.udemy.com/course/soft-skills-x/'),
    Course('Mathematics for Engineering', 'https://www.udemy.com/course/mathematics-for-engineering/'),
    Course('Mathematics Problem Solving using the Math Model Method', 'https://www.udemy.com/course/mathematics-problem-solving-using-the-math-model-method/'),
    Course('Random Variable & Random Process: Problem Solving Techniques', 'https://www.udemy.com/course/random-variable-random-process-problem-solving-techniques/'),
    Course('Flutter 101-Your Ultimate Guide to Flutter Development', 'https://www.udemy.com/course/flutter-101/'),
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
