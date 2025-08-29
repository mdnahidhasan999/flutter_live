import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_live/add_product_screen.dart';
import 'package:flutter_live/update_product_screen.dart';
import 'package:http/http.dart';

class Productlistscreen extends StatefulWidget {
  const Productlistscreen({super.key});

  @override
  State<Productlistscreen> createState() => _ProductlistscreenState();
}

class _ProductlistscreenState extends State<Productlistscreen> {
  bool _isLoading = false;
  List<Product> _productList = [];

  @override
  void initState() {
    super.initState();
    _getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product List")),
      body: RefreshIndicator(
        onRefresh: _getProductList,
        child: Visibility(
          visible: _isLoading == false,
          replacement: Center(child: CircularProgressIndicator()),
          child: ListView.builder(
            itemCount: _productList.length,
            itemBuilder: (context, index) {
              return Card(child: _buildProductItem(_productList[index]));
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addProductScreen()),
          );
          if (result == true) {
            _getProductList(); // Reloads the product list
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _getProductList() async {
    setState(() {
      _isLoading = true;
    });
    _productList.clear();
    String _ProductListUrl = 'https://crud.teamrabbil.com/api/v1/ReadProduct';
    Uri uri = Uri.parse(_ProductListUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      final dataDecode = jsonDecode(response.body);
      final jasonProductList = dataDecode['data'];
      for (Map<String, dynamic> item in jasonProductList) {
        Product product = Product(
          item['_id'] ?? '',
          item['ProductName'] ?? '',
          item['ProductCode'] ?? '',
          item['Img'] ?? '',
          item['UnitPrice'] ?? '',
          item['Qty'] ?? '',
          item['TotalPrice'] ?? '',
        );
        _productList.add(product);
      }
      final snackBar = SnackBar(
        content: Text('Products loaded successfully!'),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      final snackBar = SnackBar(
        content: Text('Failed to load products. Please try again.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget _buildProductItem(Product product) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          'https://www.w3schools.com/howto/img_avatar.png',
        ), // Placeholder image
      ),
      title: Text(product.ProductName),
      subtitle: Wrap(
        spacing: 16,
        children: [
          Text('Unit Price: ${product.UnitPrice}'),
          Text('Qty: ${product.Qty}'),
          Text('Total: ${product.TotalPrice}'),
        ],
      ),
      trailing: Wrap(
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => updateProductScreen(product: product),
                ),
              );

              if (result == true) {
                _getProductList();
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteConfirmationDialog(product.id);
              // Delete action
            },
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmationDialog(String productId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Deletion'),
          content: Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete'),
              onPressed: () {
                _deleteProduct(productId);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct(String productId) async {
    _isLoading = true;
    setState(() {});
    String _deleteProductUrl =
        'https://crud.teamrabbil.com/api/v1/DeleteProduct/${productId}';
    Uri uri = Uri.parse(_deleteProductUrl);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      _getProductList();
    } else {
      setState(() {
        _isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text('Delete product Failed! Please try again.'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}

class Product {
  final String id;

  final String ProductName;
  final String ProductCode;
  final String Img;
  final String UnitPrice;
  final String Qty;
  final String TotalPrice;

  Product(
    this.id,
    this.ProductName,
    this.ProductCode,
    this.Img,
    this.UnitPrice,
    this.Qty,
    this.TotalPrice,
  );
}
