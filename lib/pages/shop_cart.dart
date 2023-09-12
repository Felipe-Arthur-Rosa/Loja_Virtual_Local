import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_tecnico/components/cart_info_card.dart';
import 'package:teste_tecnico/components/product_card.dart';
import 'package:teste_tecnico/providers/product_provider.dart';

class ShopCart extends StatelessWidget {
  const ShopCart({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.black,
        title: const Text(
          "Seu carrinho de compras", 
          style: TextStyle(color: Colors.white)
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: provider.cart.isEmpty
        ? const Center(child: Text("Carrinho limpo."))
        : Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: provider.cart.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    product: provider.cart[index], 
                    onButtonTapped: () {
                      provider.deleteCart(provider.cart[index].id);
                    },
                    iconData: Icons.delete_rounded, 
                    buttonColor: Colors.red.withOpacity(0.2)
                  );
                }
              ),
            ),
            CartInfoCard(
              totalPrice: provider.cartTotalPrice,
              onButtonTapped: () {
                showDialog(context: context, builder: (context) {
                  return AlertDialog(
                    title: const Text("Compra realizada com sucesso"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          provider.clearCart();
                          ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Compra realizada com sucesso'),
                            backgroundColor: Colors.green,
                          ),
                          );
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }, 
                        child: const Text("OK")
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        }, 
                        child: const Text("Cancelar")
                      )
                    ],
                  );
                });
                
              }
            ),
          ],
        ),
      ),
    );
  }
}