import 'package:ethiomark8/models/product.dart';

class Order {
  final String orderId;
  final DateTime date;
  final List<Product> products;
  final double total;

  Order({
    required this.orderId,
    required this.date,
    required this.products,
    required this.total,
  });
}
