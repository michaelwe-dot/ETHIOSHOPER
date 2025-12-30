import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ethiomark8/listings_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'name': 'Items for Sale', 'icon': Icons.shopping_bag},
      {'name': 'Services', 'icon': Icons.miscellaneous_services},
      {'name': 'Classifieds', 'icon': Icons.article},
      {'name': 'Jobs', 'icon': Icons.work},
      {'name': 'Cars', 'icon': Icons.directions_car},
      {'name': 'Properties', 'icon': Icons.house},
    ];

    return AnimationLimiter(
      child: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          childAspectRatio: 1.2,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListingsScreen(category: category['name']!),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(category['icon'] as IconData, size: 40, color: Theme.of(context).colorScheme.primary),
                        const SizedBox(height: 10),
                        Text(
                          category['name'] as String,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
