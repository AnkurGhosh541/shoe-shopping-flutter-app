import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    final totalPrice = Provider.of<CartProvider>(context).getTotalPrice();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Cart",
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: cart.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.length,
                    itemBuilder: (context, index) {
                      var cartItem = cart[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(cartItem["imageUrl"]),
                          ),
                          title: Text(
                            cartItem["title"],
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          subtitle: Text(
                            "Size: ${cartItem["size"]}",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text("Remove Item"),
                                  titleTextStyle:
                                      Theme.of(context).textTheme.titleMedium,
                                  content: const Text(
                                      "Are you sure you want to remove this item ?"),
                                  contentTextStyle:
                                      Theme.of(context).textTheme.bodySmall,
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "No",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        context
                                            .read<CartProvider>()
                                            .removeFromCart(cartItem);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text(
                                        "Yes",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Color.fromRGBO(211, 47, 47, 1),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 40.0),
                  child: Text(
                    "Total:  ₹$totalPrice",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
    );
  }
}
