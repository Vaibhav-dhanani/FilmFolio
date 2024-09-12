import 'package:filmfolio/services/auth_gate.dart';
import 'package:filmfolio/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const FilmFolio());
}

class FilmFolio extends StatelessWidget {
  const FilmFolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmFolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.black87,
        iconTheme: const IconThemeData(color: Colors.amber),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const AuthGate(),
    );
  }
}



/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:filmfolio/services/auth_gate.dart';
import 'package:filmfolio/services/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> importCelebrityData(List<Map<String, dynamic>> celebrityData) async {
  // Reference to Firestore collection
  final firestore = FirebaseFirestore.instance;
  final collectionRef = firestore.collection('awards');

  // Batch write to Firestore
  final batch = firestore.batch();

  for (var i = 0; i < celebrityData.length; i++) {
    final crewMember = celebrityData[i];
    final docRef = collectionRef.doc('award_${i + 1}');
    batch.set(docRef, crewMember);
  }

  // Commit the batch
  await batch.commit();
  print('Data imported successfully.');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final List<Map<String, dynamic>> celebrityData = [
    {
      "name": "Academy Award",
      "year": 2011,
      "category": "Best Cinematography"
    },
    {
      "name": "Academy Award",
      "year": 2011,
      "category": "Best Visual Effects"
    },
    {
      "name": "Academy Award",
      "year": 2011,
      "category": "Best Sound Mixing"
    },
    {
      "name": "Academy Award",
      "year": 2011,
      "category": "Best Sound Editing"
    },
    {
      "name": "BAFTA Award",
      "year": 2011,
      "category": "Best Production Design"
    },
    {
      "name": "BAFTA Award",
      "year": 2011,
      "category": "Best Special Visual Effects"
    },
    {
      "name": "Golden Globe Award",
      "year": 2011,
      "category": "Best Original Score"
    },
    {
      "name": "Critics' Choice Movie Award",
      "year": 2011,
      "category": "Best Action Movie"
    },
    {
      "name": "Saturn Award",
      "year": 2011,
      "category": "Best Science Fiction Film"
    },
    {
      "name": "Saturn Award",
      "year": 2011,
      "category": "Best Writing"
    },
    {
      "name": "Academy Award",
      "year": 2012,
      "category": "Best Picture"
    },
    {
      "name": "Academy Award",
      "year": 2012,
      "category": "Best Director"
    },
    {
      "name": "Golden Globe Award",
      "year": 2012,
      "category": "Best Motion Picture - Drama"
    },
    {
      "name": "BAFTA Award",
      "year": 2012,
      "category": "Best Film"
    },
    {
      "name": "Screen Actors Guild Award",
      "year": 2012,
      "category": "Outstanding Performance by a Cast in a Motion Picture"
    },
    {
      "name": "Producers Guild of America Award",
      "year": 2012,
      "category": "Best Theatrical Motion Picture"
    },
    {
      "name": "Directors Guild of America Award",
      "year": 2012,
      "category": "Outstanding Directorial Achievement in Motion Pictures"
    },
    {
      "name": "Writers Guild of America Award",
      "year": 2012,
      "category": "Best Original Screenplay"
    },
    {
      "name": "Critics' Choice Movie Award",
      "year": 2012,
      "category": "Best Picture"
    },
    {
      "name": "American Film Institute",
      "year": 2012,
      "category": "Movie of the Year"
    },
    {
      "name": "Academy Award",
      "year": 2013,
      "category": "Best Actor"
    },
    {
      "name": "Academy Award",
      "year": 2013,
      "category": "Best Actress"
    },
    {
      "name": "Golden Globe Award",
      "year": 2013,
      "category": "Best Actor - Motion Picture Drama"
    },
    {
      "name": "BAFTA Award",
      "year": 2013,
      "category": "Best Leading Actor"
    },
    {
      "name": "Screen Actors Guild Award",
      "year": 2013,
      "category": "Outstanding Performance by a Male Actor in a Leading Role"
    },
    {
      "name": "Critics' Choice Movie Award",
      "year": 2013,
      "category": "Best Actor"
    },
    {
      "name": "Independent Spirit Award",
      "year": 2013,
      "category": "Best Feature"
    },
    {
      "name": "Satellite Award",
      "year": 2013,
      "category": "Best Film"
    },
    {
      "name": "National Board of Review",
      "year": 2013,
      "category": "Top Ten Films"
    },
    {
      "name": "European Film Award",
      "year": 2013,
      "category": "Best European Film"
    }
  ];

  // Call the function to import data
  await importCelebrityData(celebrityData);
  runApp(const FilmFolio());
}
class FilmFolio extends StatelessWidget {
  const FilmFolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FilmFolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.amber,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.amber),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      home: const AuthGate(),
    );
  }
}
*/
