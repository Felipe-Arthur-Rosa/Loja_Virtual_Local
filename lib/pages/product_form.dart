// ignore_for_file: curly_braces_in_flow_control_structures, use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teste_tecnico/model/produto.dart';
import 'package:teste_tecnico/providers/product_provider.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key, this.product});

  final Product? product;

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, dynamic>{};

   @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget.product != null) {
        _formData['id']       = widget.product!.id;
        _formData['name']     = widget.product!.nome;
        _formData['value']    = widget.product!.preco.toString();
        _formData['material'] = widget.product!.material;
        _formData['url']      = widget.product!.url;
      }
  }

  @override
  Widget build(BuildContext context) {
  final provider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          widget.product == null 
          ? "Cadastrar" 
          : "Editar", 
          style: const TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              padding: const EdgeInsets.all(10),
              onPressed: () async {
                log('message');
                final isValid = _formKey.currentState!.validate();
                if(isValid){
                  log('passou');
                  _formKey.currentState!.save();
                  String mensage = await provider.saveProduct(_formData, widget.product != null);
                  if (mensage == 'ok') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Produto salvo com sucesso'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                  if (mensage == 'ok edit') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Produto editado com sucesso'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    Navigator.of(context).pop();
                  }
                   else () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Erro ao salvar produto'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  };
                }
              },
              icon: const Icon(Icons.save_rounded),
              color: Colors.white,
              iconSize: 40,
            )
          ],
      ),
      body: Column(
          children: <Widget>[ 
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: _formData["name"] ?? "",
                      onSaved: (name) => _formData["name"] = name ?? "",
                      validator: (name) {
                        if(name == null || name == ''){
                          return 'Insira um nome válido';
                        }
                        if(name.length < 2){
                          return 'O nome precisa ter mais de 2 letras';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Nome do Produto',
                        hintText: 'Ex: Camisa de Algodão'
                      ),
                    ),
                    TextFormField(
                      initialValue: _formData["value"] ?? "",
                      onSaved: (value) => _formData["value"] = value ?? "",
                      validator: (value) {
                        if(value == null || value == ''){
                          return 'Insira um valor válido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Valor',
                        hintText: 'Ex: 123,00'
                      ),
                    ),
                    TextFormField(
                      initialValue: _formData["material"] ?? "",
                      onSaved: (material) => _formData["material"] = material ?? "",
                      validator: (material) {
                        if(material == null || material == ''){
                          return 'Insira um Material válido';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Material',
                        hintText: 'Ex: Algodão'
                      ),
                    ),
                    TextFormField(
                      initialValue: _formData["url"] ?? "",
                      onSaved: (url) => _formData["url"] = url ?? "",
                      validator: (url) {
                        if(url == null || url == ''){
                          return 'uma url válida';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Url da imagem',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
    );
  }
}