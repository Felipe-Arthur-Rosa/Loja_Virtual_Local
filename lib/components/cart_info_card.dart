import 'package:flutter/material.dart';

class CartInfoCard extends StatelessWidget {

  final double totalPrice;
  final void Function() onButtonTapped;

  const CartInfoCard({
    super.key, 
    required this.totalPrice, 
    required this.onButtonTapped
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      height: 100,
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text("TOTAL: R\$${totalPrice.toStringAsFixed(2)}"),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black
              ),
              onPressed: () {
                onButtonTapped();
              }, 
              child: const Text("COMPRAR", style: TextStyle(color: Colors.white))
            ),
          )
        ],
      ),
    );
  }
}