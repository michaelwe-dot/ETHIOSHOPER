class Listing {
  final String id;
  final String title;
  final String price;
  final String category;
  final String location;
  final String imageUrl;
  final bool isPromoted;

  Listing({
    required this.id,
    required this.title,
    required this.price,
    required this.category,
    required this.location,
    required this.imageUrl,
    this.isPromoted = false,
  });
}

// Dummy data for testing before the database is connected
List<Listing> getDummyListings() {
  return [
    Listing(
      id: '1', 
      title: 'Toyota Vitz 2018', 
      price: 'ETB 1,200,000', 
      category: 'Cars', 
      location: 'Addis Ababa', 
      imageUrl: 'https://via.placeholder.com/300', 
      isPromoted: true
    ),
    Listing(
      id: '2', 
      title: 'iPhone 13 Pro', 
      price: 'ETB 65,000', 
      category: 'Electronics', 
      location: 'Bole', 
      imageUrl: 'https://via.placeholder.com/300', 
      isPromoted: false
    ),
    Listing(
      id: '3', 
      title: 'Luxury Apartment', 
      price: 'ETB 40,000/mo', 
      category: 'Property', 
      location: 'Kazanchis', 
      imageUrl: 'https://via.placeholder.com/300', 
      isPromoted: true
    ),
  ];
}