import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:teste_tecnico/model/produto.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> products = [];
  List<Product> cart = [];

  double get cartTotalPrice {
    double total = 0;
    for (var element in cart) {
      total += element.preco;
    }
    return total;
  }

  int setId(data) {
  if (data == null){
    log('int');
   int id = products.length + 1;
   return id;
   } 
   else {
    log('String');
    int id = data;
    return id;
  }
  }

  Future<String>saveProduct(Map <String, dynamic> data, bool edit) {
    log('entrou');
    try {
      log(data['id'].toString());
      log(data['name'].toString());
      log(data['value'].toString());
      log(data['material'].toString());
      log(data['url'].toString());

      int id = setId(data['id']);
      final product = Product(
      id: id,
      nome: data['name'],
      preco: double.parse(data['value']),
      material: data['material'],
      url: data['url'],
    );
    if(edit){
      editProduct(product);
      return Future.value('ok edit');
    } else {
      addProduct(product);
      return Future.value('ok');
    }
    } catch (e) {
      log(e.toString());
      return Future.value('error');
    }
    
  }

  Future<String> addProduct(Product product){
    products.add(product);
    notifyListeners();
    log('foi${product.nome}');
    return Future.value('ok');
  }

  clearCart() {
    cart.clear();
    notifyListeners();
  }

  deleteCart(index) {
    cart.removeWhere((element) => element.index == index);
    notifyListeners();
  }

  deleteProduct(id) {
    products.removeWhere((element) => element.id == id);
    if(cart.indexWhere((element) => element.id == id) != -1) {
    cart.removeWhere((element) => element.id == id);
    }
    notifyListeners();
  }

   Future<String> editProduct(Product product){
    products[products.indexWhere((element) => element.id == product.id)] = product;
    notifyListeners();
    return Future.value('ok');
  }

  void addToCart(product) {
    cart.add(product);
  }

}