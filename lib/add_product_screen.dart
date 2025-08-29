import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class addProductScreen extends StatefulWidget {
  const addProductScreen({super.key});

  @override
  State<addProductScreen> createState() => _addProductScreenState();
}

class _addProductScreenState extends State<addProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _unitPriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final _globalKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add New Product")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _globalKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(
                    labelText: 'Product Name',
                    hintText: 'Enter product name',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _codeController,
                  decoration: InputDecoration(
                    labelText: 'Product Code',
                    hintText: 'Enter product Code',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                TextFormField(
                  controller: _unitPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Unit Price',
                    hintText: 'Enter unit price',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product unit price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Product Quantity',
                    hintText: 'Enter product quantity',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter product quantity';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _totalPriceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Total Price',
                    hintText: 'Enter total price',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter total price';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    labelText: 'Image URL',
                    hintText: 'Enter image URL',
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter image URL';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                Visibility(
                  visible: _isLoading == false,
                  replacement: Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_globalKey.currentState!.validate()) {
                        await _addProduct();
                        Navigator.pop(context, true);
                      }
                    },
                    child: Text('Save Product'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    _isLoading = true;
    setState(() {});

    String Url = 'https://crud.teamrabbil.com/api/v1/CreateProduct';
    Map<String, dynamic> inputData = {
      "Img": _imageUrlController.text.trim(),
      "ProductCode": _codeController.text.trim(),
      "ProductName": _nameController.text.trim(),
      "Qty": _quantityController.text.trim(),
      "TotalPrice": _totalPriceController.text.trim(),
      "UnitPrice": _unitPriceController.text.trim(),
    };
    Uri uri = Uri.parse(Url);
    Response response = await post(
      uri,
      body: jsonEncode(inputData),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      _nameController.clear();
      _unitPriceController.clear();
      _quantityController.clear();
      _totalPriceController.clear();
      _imageUrlController.clear();
      _codeController.clear();

      final snackBar = SnackBar(
        content: Text('Product added successfully!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Failed to add product. Please try again.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    _isLoading = false;
    setState(() {});
  }

  @override
  void dispose() {
    _nameController.dispose();
    _unitPriceController.dispose();
    _quantityController.dispose();
    _totalPriceController.dispose();
    _imageUrlController.dispose();
    _codeController.dispose();
    super.dispose();
  }
}

//101
