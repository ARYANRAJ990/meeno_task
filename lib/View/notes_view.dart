import 'package:flutter/material.dart';
import 'package:memoneet_task2/Res/Component/colors.dart';

import '../Res/Component/colors.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notes',
          style: TextStyle(
            color: AppColors.blueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: AppColors.blueColor,
        backgroundColor: AppColors.whiteColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.count(
            crossAxisCount: 2, // 2 items per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              _buildGridButton('Physics', 'images/physics.jpg', '/physics'),
              _buildGridButton('Chemistry', 'images/chemistry.jpg', '/chemistry'),
              _buildGridButton('Biology', 'images/biology.jpg', '/biology'),
            ],
          ),
        ),
      ),
      // Floating action button at the bottom right
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your desired action here
          Navigator.pushNamed(context, '/chatbot');
        },
        backgroundColor: AppColors.blueColor,
        child: const Icon(Icons.chat, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildGridButton(String title, String imagePath, String route) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, route); // Navigate to specified route
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.blueColor,
        padding: const EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        shadowColor: Colors.grey.withOpacity(0.3),
        elevation: 5,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
