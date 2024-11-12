import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memoneet_task2/View/topics/topics_details.dart';
import '../Utils/call/data_helper.dart';
import '../Res/Component/colors.dart';

class biology_notes extends StatefulWidget {
  const biology_notes({super.key});

  @override
  State<biology_notes> createState() => _biology_notesState();
}

class _biology_notesState extends State<biology_notes> {
  List<String> uniqueTopics = [];

  Future<void> loadBiologyData() async {
    try {
      final String input = await DefaultAssetBundle.of(context).loadString("jsonFiles/biology_npcm.json");
      final List<dynamic> jsonData = jsonDecode(input);

      setState(() {
        uniqueTopics = filterUniqueTopics(jsonData); // Use helper function for unique main topics
      });
    } catch (e) {
      print('Error loading JSON data: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    loadBiologyData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Biology Notes',
          style: TextStyle(
            color: AppColors.blueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        foregroundColor: AppColors.blackColor,
      ),
      body: uniqueTopics.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: uniqueTopics.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(
                uniqueTopics[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Icon(
                index < 2 ? Icons.arrow_forward : Icons.lock,
                color: index < 2 ? Colors.blue : Colors.grey,
              ),
              onTap: () {
                // If the topic is accessible (index < 2), navigate to the details page
                if (index < 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopicDetailsPage(topicName: uniqueTopics[index]),
                    ),
                  );
                } else {
                  // Show a message for restricted topics
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Please buy a plan to access more topics!'),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
