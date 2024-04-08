import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final product = widget.product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Details",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
      ),
      body: size.width < 700
          ? Column(
              children: [
                Text(
                  product["title"],
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  product["brand"],
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                Image.asset(
                  product["imageUrl"],
                  height: 250,
                ),
                const Spacer(flex: 2),
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹ ${product["price"]}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "(incl. of all taxes)",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product["sizes"].length,
                            itemBuilder: (context, index) {
                              int size = product["sizes"][index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedSize == size) {
                                        selectedSize = 0;
                                      } else {
                                        selectedSize = size;
                                      }
                                    });
                                  },
                                  child: Chip(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: size == selectedSize
                                        ? Theme.of(context)
                                            .colorScheme
                                            .inversePrimary
                                        : Colors.white,
                                    label: Text(
                                      size.toString(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              foregroundColor: Colors.black87,
                              minimumSize: const Size.fromHeight(50)),
                          onPressed: () {
                            if (selectedSize != 0) {
                              context.read<CartProvider>().addToCart({
                                'id': product["id"],
                                'title': product["title"],
                                'price': product["price"],
                                'category': product["category"],
                                'imageUrl': product["imageUrl"],
                                'brand': product["brand"],
                                'size': selectedSize,
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Item added to your cart"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a size first"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          label: const Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                Center(
                  child: Image.asset(
                    product["imageUrl"],
                    height: 250,
                  ),
                ),
                const Spacer(),
                Container(
                  height: 400,
                  width: 500,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                    borderRadius: const BorderRadius.all(Radius.circular(40)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product["title"],
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          product["brand"],
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const Spacer(),
                        Text(
                          "₹ ${product["price"]}",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          "(incl. of all taxes)",
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          height: 60,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: product["sizes"].length,
                            itemBuilder: (context, index) {
                              int size = product["sizes"][index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (selectedSize == size) {
                                        selectedSize = 0;
                                      } else {
                                        selectedSize = size;
                                      }
                                    });
                                  },
                                  child: Chip(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: size == selectedSize
                                        ? Theme.of(context)
                                            .colorScheme
                                            .inversePrimary
                                        : Colors.white,
                                    label: Text(
                                      size.toString(),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              foregroundColor: Colors.black87,
                              minimumSize: const Size.fromHeight(50)),
                          onPressed: () {
                            if (selectedSize != 0) {
                              context.read<CartProvider>().addToCart({
                                'id': product["id"],
                                'title': product["title"],
                                'price': product["price"],
                                'category': product["category"],
                                'imageUrl': product["imageUrl"],
                                'brand': product["brand"],
                                'size': selectedSize,
                              });

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Item added to your cart"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Please select a size first"),
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            }
                          },
                          label: const Text(
                            "Add to cart",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          icon: const Icon(Icons.shopping_cart),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 50),
              ],
            ),
    );
  }
}
