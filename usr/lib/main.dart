import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Data model for the product
class Product {
  final int id;
  final String name;
  final int price;
  final IconData icon;

  Product({required this.id, required this.name, required this.price, required this.icon});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Roti SDQ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const BakeryShopPage(),
    );
  }
}

class BakeryShopPage extends StatefulWidget {
  const BakeryShopPage({super.key});

  @override
  State<BakeryShopPage> createState() => _BakeryShopPageState();
}

class _BakeryShopPageState extends State<BakeryShopPage> {
  // State for the shopping cart (productId, quantity)
  final Map<int, int> _cart = {};

  // List of available products
  final List<Product> _products = [
    Product(id: 1, name: "Roti Coklat", price: 12000, icon: Icons.bakery_dining),
    Product(id: 2, name: "Roti Keju", price: 15000, icon: Icons.cake),
    Product(id: 3, name: "Roti Tawar", price: 10000, icon: Icons.breakfast_dining),
    Product(id: 4, name: "Croissant", price: 20000, icon: Icons.brunch_dining),
  ];

  // Function to increment a product in the cart
  void _incrementCart(Product product) {
    setState(() {
      _cart.update(product.id, (value) => value + 1, ifAbsent: () => 1);
    });
  }

  // Function to decrement a product from the cart
  void _decrementCart(Product product) {
    setState(() {
      if (_cart.containsKey(product.id)) {
        if (_cart[product.id]! > 1) {
          _cart.update(product.id, (value) => value - 1);
        } else {
          _cart.remove(product.id);
        }
      }
    });
  }

  // Calculate total items in the cart
  int get _totalCartItems {
    if (_cart.isEmpty) {
      return 0;
    }
    return _cart.values.reduce((sum, item) => sum + item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Roti SDQ"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: _products.length,
        itemBuilder: (context, index) {
          final product = _products[index];
          final quantity = _cart[product.id] ?? 0;
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 6.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(product.icon, size: 50, color: Colors.brown),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Rp${product.price}"),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: quantity > 0 ? () => _decrementCart(product) : null,
                      ),
                      Text('$quantity', style: const TextStyle(fontSize: 18)),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => _incrementCart(product),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Keranjang: $_totalCartItems item",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
