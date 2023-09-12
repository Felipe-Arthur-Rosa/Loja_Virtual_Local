import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_tecnico/components/product_card.dart';
import 'package:teste_tecnico/providers/product_provider.dart';
import 'package:teste_tecnico/pages/shop_cart.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("MALWEE", style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0), 
            child: IconButton(onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const ShopCart())
            ), 
              icon: const Icon(
                Icons.shopping_cart_rounded,
                color: Colors.white,
              )
            ),
          )
        ],
      ),
      body: provider.products.isEmpty
      ? const Center(
          child: Text("Nenhum produto disponível."),
        )
      : ListView.builder(
        itemCount: provider.products.length,
        itemBuilder: (context, index) => ProductCard(
          product: provider.products[index], 
          onButtonTapped: () {
            provider.addToCart(provider.products[index]);
          },
          buttonColor: Colors.green.withOpacity(0.2),
          iconData: Icons.add_shopping_cart_rounded,
        )
      ),
    );
  }
}