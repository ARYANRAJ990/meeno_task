import 'package:flutter/material.dart';
import '../Res/Component/colors.dart';

class chat_view extends StatefulWidget {
  const chat_view({super.key});

  @override
  State<chat_view> createState() => _chat_viewState();
}

class _chat_viewState extends State<chat_view> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = []; // List to store messages

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> sendMessage(String message) async {
    // Add user message to the chat
    setState(() {
      _messages.add({'sender': 'user', 'text': message});
    });

    // Clear the text field
    _messageController.clear();

    // Simulate a delay to mimic API call
    await Future.delayed(const Duration(seconds: 1));

    // Here you would call your chatbot API with the user's message and receive a response
    // String response = await chatBotApiCall(message); // Use actual API call here

    // For now, let's use a mock response
    String response = "I'm here to help! How can I assist you?";

    // Add bot response to the chat
    setState(() {
      _messages.add({'sender': 'bot', 'text': response});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ChatBot',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: AppColors.blueColor,
        backgroundColor: AppColors.blueColor,
      ),
      body: Column(
        children: [
          // Chat messages list
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      message['text']!,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),
          // Input field for typing messages
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.blueColor,
                  onPressed: () {
                    final message = _messageController.text.trim();
                    if (message.isNotEmpty) {
                      sendMessage(message);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
