import 'package:flutter/material.dart';

import '../model/produto.dart';

class ProductCard extends StatelessWidget {

  final Product product;
  final IconData iconData;
  final Color buttonColor;
  final void Function() onButtonTapped;

  const ProductCard({
    super.key, 
    required this.product, 
    required this.onButtonTapped, 
    required this.iconData, 
    required this.buttonColor
  });

  @override
  Widget build(BuildContext context) {
    double margins = 20;
    double padding = 20;
    double cardWidth = MediaQuery.of(context).size.width - margins - padding;
    return Container(
      margin: EdgeInsets.all(margins/2),
      padding: EdgeInsets.all(padding/2),
      width: cardWidth,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 100,
              width: 80,
              child: Image.network(
                product.url,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text("Não encontrado", textAlign: TextAlign.center,),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 25,
                width: cardWidth - 100,
                child: Text(
                  product.nome,
                  style: const TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(
                height: 25,
                child: Text(
                  "R\$ ${product.preco.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 35,
                width: cardWidth - 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Center(child: Text(product.material))
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: ElevatedButton(
                        onPressed: onButtonTapped,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          backgroundColor: buttonColor,
                          shadowColor: Colors.transparent,
                        ),
                        child: Icon(iconData, color: Colors.black),
                      ),
                    ),
                  ],
                )
              )
            ],
          )
        ],
      ),
    );
  }
}