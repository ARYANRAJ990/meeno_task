import 'package:flutter/material.dart';

class TopicDetailsPage extends StatelessWidget {
  final String topicName;

  // Constructor to receive the topic name
  const TopicDetailsPage({super.key, required this.topicName});

  @override
  Widget build(BuildContext context) {
    // You can modify this to load specific content based on the topic name
    return Scaffold(
      appBar: AppBar(
        title: Text(topicName),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Study Material for $topicName',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            // Example content for the selected topic
            Text(
              'This is the study material and notes for the topic "$topicName".\n\n'
                  'You can add more detailed information about the topic here.',
              style: const TextStyle(fontSize: 16),
            ),
            // Add more content, images, or links to study materials as needed
          ],
        ),
      ),
    );
  }
}
