import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// A simple model for a chat message
class Message {
  final String text;
  final bool isSentByMe;
  final String timestamp;

  Message({required this.text, required this.isSentByMe, required this.timestamp});
}

class ChatDetailScreen extends StatefulWidget {
  final String contactName;

  const ChatDetailScreen({super.key, required this.contactName});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final List<Message> _messages = [
    Message(text: 'Hello! Is this item still available?', isSentByMe: false, timestamp: '10:30 AM'),
    Message(text: 'Hi, yes it is!', isSentByMe: true, timestamp: '10:31 AM'),
    Message(text: 'Great! Can I get a discount?', isSentByMe: false, timestamp: '10:32 AM'),
    Message(text: 'The price is firm.', isSentByMe: true, timestamp: '10:33 AM'),
  ];

  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add(Message(text: _controller.text, isSentByMe: true, timestamp: '10:35 AM'));
        _controller.clear();
      });
      // In a real app, you would also send the message to a backend/service
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.contactName, style: GoogleFonts.oswald()),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildMessageComposer(),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final isSentByMe = message.isSentByMe;
    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: isSentByMe ? Theme.of(context).colorScheme.primary : Colors.grey[700],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: GoogleFonts.roboto(color: Colors.white, fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              message.timestamp,
              style: GoogleFonts.roboto(color: Colors.white70, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageComposer() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        boxShadow: const [
          BoxShadow(offset: Offset(0, -1), blurRadius: 4, color: Colors.black12),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[800],
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: Icon(Icons.send, color: Theme.of(context).colorScheme.primary),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
