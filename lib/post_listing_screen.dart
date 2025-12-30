import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ethiomark8/firestore_service.dart';

class PostListingScreen extends StatefulWidget {
  const PostListingScreen({super.key});

  @override
  PostListingScreenState createState() => PostListingScreenState();
}

class PostListingScreenState extends State<PostListingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firestoreService = FirestoreService();
  bool _isLoading = false;

  String? _selectedCategory = 'Items for Sale';
  final List<String> _categories = ['Items for Sale', 'Services', 'Classifieds', 'Jobs', 'Cars', 'Properties'];
  final List<XFile> _images = [];
  final ImagePicker _picker = ImagePicker();

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickImages() async {
    final List<XFile> pickedFiles = await _picker.pickMultiImage();
    setState(() {
      _images.addAll(pickedFiles);
    });
  }

  void _removeImage(int index) {
    setState(() {
      _images.removeAt(index);
    });
  }

  Future<void> _saveListing() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await _firestoreService.addListing({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'price': double.parse(_priceController.text),
          'category': _selectedCategory,
          'timestamp': FieldValue.serverTimestamp(),
        });

        if (!mounted) return;

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Listing Submitted!')),
        );
        _formKey.currentState!.reset();
        _titleController.clear();
        _descriptionController.clear();
        _priceController.clear();
        setState(() {
          _images.clear();
          _selectedCategory = 'Items for Sale';
        });
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit listing: $e')),
        );
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildImagePicker(context),
                    const SizedBox(height: 24),
                    _buildCategoryDropdown(),
                    const SizedBox(height: 16),
                    _buildTextFormField('Title', 'Enter the title of your listing', _titleController),
                    const SizedBox(height: 16),
                    _buildTextFormField('Description', 'Describe your item in detail', _descriptionController, maxLines: 5),
                    const SizedBox(height: 16),
                    _buildTextFormField('Price', 'Enter the price', _priceController, keyboardType: TextInputType.number),
                    const SizedBox(height: 30),
                    _buildSubmitButton(context),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildImagePicker(BuildContext context) {
    return _images.isEmpty
        ? Center(
            child: GestureDetector(
              onTap: _pickImages,
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.grey.shade600, width: 2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt, color: Colors.grey[400], size: 50),
                    const SizedBox(height: 8),
                    Text(
                      'Upload Photos',
                      style: GoogleFonts.roboto(color: Colors.grey[400], fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Column(
            children: [
              SizedBox(
                height: 150,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        Image.file(
                          File(_images[index].path),
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () => _removeImage(index),
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, color: Colors.white, size: 16),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: _pickImages,
                icon: const Icon(Icons.add_a_photo),
                label: const Text('Add More Photos'),
              ),
            ],
          );
  }

  Widget _buildCategoryDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: _selectedCategory,
      decoration: InputDecoration(
        labelText: 'Category',
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      items: _categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() {
          _selectedCategory = newValue;
        });
      },
    );
  }

  Widget _buildTextFormField(String label, String hint, TextEditingController controller, {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        alignLabelWithHint: true,
      ),
      maxLines: maxLines,
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a $label';
        }
        if (label == 'Price') {
          if (double.tryParse(value) == null) {
            return 'Please enter a valid number';
          }
        }
        return null;
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _saveListing,
        icon: const Icon(Icons.cloud_upload),
        label: const Text('Submit Listing'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          textStyle: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
