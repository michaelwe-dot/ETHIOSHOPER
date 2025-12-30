import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethiomark8/firestore_service.dart';

class ListingsScreen extends StatelessWidget {
  final String category;

  const ListingsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: Text(category, style: GoogleFonts.oswald()),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: firestoreService.getListings(category: category),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No listings found in this category.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var doc = snapshot.data!.docs[index];
              var data = doc.data() as Map<String, dynamic>;

              String title = data['title'] ?? 'No Title';
              String description = data['description'] ?? 'No Description';
              String price = data.containsKey('price') ? data['price'].toString() : 'N/A';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    title,
                    style: GoogleFonts.oswald(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.roboto(),
                      ),
                    ],
                  ),
                  trailing: Text(
                    '\$$price',
                    style: GoogleFonts.roboto(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
