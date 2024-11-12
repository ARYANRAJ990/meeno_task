import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memoneet_task2/Res/Component/colors.dart';
import 'package:memoneet_task2/View/chapters/chem_chapters.dart';

class chemistry_notes extends StatefulWidget {
  const chemistry_notes({super.key});

  @override
  State<chemistry_notes> createState() => _chemistry_notesState();
}

class _chemistry_notesState extends State<chemistry_notes> {
  List<String> topicNames = []; // Store only topic names

  Future<void> loadChemistryData() async {
    try {
      final String input = await DefaultAssetBundle.of(context).loadString("jsonFiles/chemistry_npcm.json");
      final List<dynamic> jsonData = jsonDecode(input);

      setState(() {
        // Extract only topic names
        topicNames = jsonData
            .where((item) => item['topic_name'] != null)
            .map<String>((item) => item['topic_name'] as String)
            .toList();
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadChemistryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chemistry Notes',
          style: TextStyle(
            color: AppColors.blueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: AppColors.blackColor,
        backgroundColor: AppColors.whiteColor,
      ),
      body: topicNames.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: topicNames.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                topicNames[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: () {
                // Navigate to the DetailPage without passing any data
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const chem_view(topicName: '',),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
