import 'package:flutter/material.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  _StudentsPageState createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<Student> students = [
    Student(
        prenom: 'Modibo', nom: 'Samaké', age: 20, classe: 'Classe 1', note: 19),
    Student(
        prenom: 'Moussa',
        nom: 'Sangaré',
        age: 22,
        classe: 'Classe 2',
        note: 15),
    Student(
        prenom: 'Chaka', nom: 'Bissouma', age: 19, classe: 'Classe 2', note: 7),
    Student(
        prenom: 'Maimouna',
        nom: 'Traoré',
        age: 22,
        classe: 'Classe 2',
        note: 15),
  ];

  TextEditingController _prenomController = TextEditingController();
  TextEditingController _nomController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _classController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('La liste des étudiants'),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Row(
              children: [
                Text(
                  'Déconnecter',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.logout,
                  size: 14,
                ),
              ],
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title:
                      Text('${students[index].prenom} ${students[index].nom}'),
                  subtitle: Text(
                      'Age: ${students[index].age}, Classe: ${students[index].classe}, Note: ${students[index].note}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () =>
                            _showUpdateStudentDialog(context, index),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          // Delete student when the delete button is pressed
                          setState(() {
                            students.removeAt(index);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _showAddStudentDialog(context),
              child: Text('Ajouter un étudiant'),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddStudentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ajout d\'un étudiant'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _prenomController,
                  decoration: InputDecoration(labelText: 'Prénom'),
                ),
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _classController,
                  decoration: InputDecoration(labelText: 'Classe'),
                ),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(labelText: 'Note'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Add student when the "Add" button is pressed
                setState(() {
                  students.add(
                    Student(
                      prenom: _prenomController.text,
                      nom: _nomController.text,
                      age: int.tryParse(_ageController.text) ?? 0,
                      classe: _classController.text,
                      note: double.tryParse(_noteController.text) ?? 0.0,
                    ),
                  );
                });
                _clearTextControllers();
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  void _clearTextControllers() {
    _prenomController.clear();
    _nomController.clear();
    _ageController.clear();
    _classController.clear();
    _noteController.clear();
  }

  _showUpdateStudentDialog(BuildContext context, int index) {
    // Set initial values for the dialog
    _prenomController.text = students[index].prenom;
    _nomController.text = students[index].nom;
    _ageController.text = students[index].age.toString();
    _classController.text = students[index].classe;
    _noteController.text = students[index].note.toString();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Modifier l\'étudiant'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: _prenomController,
                  decoration: InputDecoration(labelText: 'Prénom'),
                ),
                TextField(
                  controller: _nomController,
                  decoration: InputDecoration(labelText: 'Nom'),
                ),
                TextField(
                  controller: _ageController,
                  decoration: InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _classController,
                  decoration: InputDecoration(labelText: 'Classe'),
                ),
                TextField(
                  controller: _noteController,
                  decoration: InputDecoration(labelText: 'Note'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Update student when the "Update" button is pressed
                setState(() {
                  students[index] = Student(
                    prenom: _prenomController.text,
                    nom: _nomController.text,
                    age: int.tryParse(_ageController.text) ?? 0,
                    classe: _classController.text,
                    note: double.tryParse(_noteController.text) ?? 0.0,
                  );
                });
                _clearTextControllers();
                Navigator.pop(context); // Close the dialog
              },
              child: Text('Mettre a jour'),
            ),
          ],
        );
      },
    );
  }
}

class Student {
  final String prenom;
  final String nom;
  final int age;
  final String classe;
  final double note;

  Student(
      {required this.prenom,
      required this.nom,
      required this.age,
      required this.classe,
      required this.note});
}
