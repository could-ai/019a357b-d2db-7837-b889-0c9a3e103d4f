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
  // State for the shopping cart
  final List<Product> _cart = [];

  // List of available products
  final List<Product> _products = [
    Product(id: 1, name: "Roti Coklat", price: 12000, icon: Icons.bakery_dining),
    Product(id: 2, name: "Roti Keju", price: 15000, icon: Icons.cake),
    Product(id: 3, name: "Roti Tawar", price: 10000, icon: Icons.breakfast_dining),
    Product(id: 4, name: "Croissant", price: 20000, icon: Icons.brunch_dining),
  ];

  // Function to add a product to the cart
  void _addToCart(Product product) {
    setState(() {
      _cart.add(product);
    });
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
          return Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 6.0,
            child: InkWell(
              onTap: () => _addToCart(product),
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
                    ElevatedButton(
                      onPressed: () => _addToCart(product),
                      child: const Text("Tambah"),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Keranjang: ${_cart.length} item",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
