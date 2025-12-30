import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethiomark8/chat_detail_screen.dart';

// A simple model for a chat conversation
class ChatConversation {
  final String contactName;
  final String lastMessage;
  final String timestamp;
  final String avatarUrl;

  ChatConversation({
    required this.contactName,
    required this.lastMessage,
    required this.timestamp,
    required this.avatarUrl,
  });
}

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ChatConversation> conversations = [
      ChatConversation(
        contactName: 'John Doe',
        lastMessage: 'Great! Can I get a discount?',
        timestamp: '10:32 AM',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      ChatConversation(
        contactName: 'Jane Smith',
        lastMessage: 'See you tomorrow!',
        timestamp: 'Yesterday',
        avatarUrl: 'https://randomuser.me/api/portraits/women/44.jpg',
      ),
      ChatConversation(
        contactName: 'Michael',
        lastMessage: 'Okay, sounds good.',
        timestamp: '3/22/24',
        avatarUrl: 'https://randomuser.me/api/portraits/men/11.jpg',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages', style: GoogleFonts.oswald()),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final conversation = conversations[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(conversation.avatarUrl),
              radius: 28,
            ),
            title: Text(conversation.contactName, style: GoogleFonts.roboto(fontWeight: FontWeight.bold)),
            subtitle: Text(conversation.lastMessage, overflow: TextOverflow.ellipsis),
            trailing: Text(conversation.timestamp, style: GoogleFonts.roboto(fontSize: 12, color: Colors.grey.shade500)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(contactName: conversation.contactName),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
