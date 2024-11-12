import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:memoneet_task2/Res/Component/colors.dart';

class chem_view extends StatefulWidget {
  final String topicName;

  const chem_view({super.key, required this.topicName});

  @override
  _chem_viewState createState() => _chem_viewState();
}

class _chem_viewState extends State<chem_view> {
  late Future<Map<String, dynamic>> questionData;

  // Method to load data from JSON file
  Future<Map<String, dynamic>> loadQuestionData() async {
    try {
      final String input = await DefaultAssetBundle.of(context)
          .loadString("jsonFiles/chemistry_npcm.json");

      final List<dynamic> jsonData = jsonDecode(input);

      final Map<String, dynamic> question = jsonData.firstWhere(
              (item) => item['topic_name'] == widget.topicName,
          orElse: () => {});

      return question;
    } catch (e) {
      print('Error loading JSON data: $e');
      return {};
    }
  }

  @override
  void initState() {
    super.initState();
    questionData = loadQuestionData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topic Details'),
        backgroundColor: AppColors.blueColor,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: questionData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error loading question data: ${snapshot.error}'),
            );
          }

          final question = snapshot.data;
          if (question == null || question.isEmpty) {
            return const Center(child: Text('No question data available.'));
          }

          final questionText = question['question'] ?? 'No question available';
          final options = [
            question['option_a'] ?? 'No option',
            question['option_b'] ?? 'No option',
            question['option_c'] ?? 'No option',
            question['option_d'] ?? 'No option',
          ];
          final correctAnswer = question['answer'] ?? 'No correct answer';
          final explanation = question['explanation'] ?? 'No explanation available';

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Topic Name
                Text(
                  widget.topicName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Question Text
                Text(
                  questionText,
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),

                // Answer options (Radio buttons)
                ...options.map((option) => RadioOption(
                  option: option,
                  onPressed: () {
                    // Handle answer choice if necessary
                  },
                )).toList(),
                const SizedBox(height: 20),

                // Correct Answer
                Text(
                  'Correct Answer: $correctAnswer',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),

                // Explanation
                Text(
                  'Explanation: $explanation',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class RadioOption extends StatelessWidget {
  final String option;
  final VoidCallback onPressed;

  const RadioOption({
    required this.option,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(option),
      leading: Radio<String>(
        value: option,
        groupValue: '',
        onChanged: (value) {
          onPressed();
        },
      ),
    );
  }
}
