import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get a stream of all listings
  Stream<QuerySnapshot> getListings({String? category}) {
    if (category != null && category.isNotEmpty) {
      return _db.collection('listings').where('category', isEqualTo: category).snapshots();
    } else {
      return _db.collection('listings').snapshots();
    }
  }

  // Add a new listing
  Future<void> addListing(Map<String, dynamic> listing) {
    return _db.collection('listings').add(listing);
  }

  // Update a listing
  Future<void> updateListing(String id, Map<String, dynamic> listing) {
    return _db.collection('listings').doc(id).update(listing);
  }

  // Delete a listing
  Future<void> deleteListing(String id) {
    return _db.collection('listings').doc(id).delete();
  }
}
