import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final int price;
  final String image;
  final Color backgroundColor;

  const ProductCard({
    super.key,
    required this.title,
    required this.category,
    required this.price,
    required this.image,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 12,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 18,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                "₹$price",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
          Text(
            category,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Center(
            child: Image.asset(
              image,
              height: 175,
            ),
          ),
        ],
      ),
    );
  }
}
