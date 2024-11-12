import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memoneet_task2/View/topics/topics_details.dart';
import '../Utils/call/data_helper.dart';
import '../Res/Component/colors.dart';

class physics_notes extends StatefulWidget {
  const physics_notes({super.key});

  @override
  State<physics_notes> createState() => _physics_notesState();
}

class _physics_notesState extends State<physics_notes> {
  List<String> uniqueTopics = [];
  Future<void> loadPhysicsData() async {
    try {
      final String input = await DefaultAssetBundle.of(context).loadString("jsonFiles/physics_npcm.json");
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
    loadPhysicsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Physics Notes',
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
