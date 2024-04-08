import 'package:flutter/material.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:shopping_app/widgets/product_card.dart';
import 'package:shopping_app/pages/product_details_page.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<String> filterList = const ["All", "Nike", "Adidas", "Puma"];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filterList[0];
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    const borderForSmallScreen = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(
        left: Radius.circular(100),
      ),
    );

    const borderForLargeScreen = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(100),
      ),
    );

    return SafeArea(
      child: Column(
        children: [
          Row(
            children: size.width < 700
                ? [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Shoes\nCollection",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: borderForSmallScreen,
                          enabledBorder: borderForSmallScreen,
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF888E96),
                            ),
                            borderRadius: BorderRadius.horizontal(
                              left: Radius.circular(100),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ]
                : [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        "Shoes Collection",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 30.0,
                        top: 20.0,
                      ),
                      child: SizedBox(
                        width: size.width > 850 ? 500 : 350,
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search),
                            border: borderForLargeScreen,
                            enabledBorder: borderForLargeScreen,
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xFF888E96),
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
          ),
          SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: filterList.length,
              itemBuilder: (context, index) {
                String filter = filterList[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                    child: Chip(
                      label: Text(filter),
                      labelStyle: TextStyle(
                          fontSize: 16,
                          color: filter == selectedFilter
                              ? Colors.white
                              : Colors.black),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      backgroundColor: filter == selectedFilter
                          ? Theme.of(context).colorScheme.primary
                          : const Color(0xFFF1F3F5),
                      side: const BorderSide(
                        color: Color(0xFFE9ECEF),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: size.width < 700
                ? ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product)));
                        },
                        child: ProductCard(
                          title: product["title"] as String,
                          category: product["category"] as String,
                          price: product["price"] as int,
                          image: product["imageUrl"] as String,
                          backgroundColor: index.isEven
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                        ),
                      );
                    },
                  )
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 600,
                      mainAxisExtent: 300,
                      // childAspectRatio: 1.6,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailsPage(product: product)));
                        },
                        child: ProductCard(
                          title: product["title"] as String,
                          category: product["category"] as String,
                          price: product["price"] as int,
                          image: product["imageUrl"] as String,
                          backgroundColor: index.isEven
                              ? Theme.of(context).colorScheme.tertiaryContainer
                              : Theme.of(context)
                                  .colorScheme
                                  .secondaryContainer,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
