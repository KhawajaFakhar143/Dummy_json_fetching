
import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/product_service.dart';

class ProductProvider with ChangeNotifier {
  final ProductService _service = ProductService();
  List<Product> _products = [];
  Product? _productDetail;

  bool _isLoading = false;

  List<Product> get products => _products;
  Product? get productDetail => _productDetail;
  bool get isLoading => _isLoading;

  Future<void> loadProducts() async {
    _isLoading = true;
    notifyListeners();
    _products = await _service.fetchProducts();
    _isLoading = false;
    notifyListeners();
  }

    Future<void> loadProductDetails(int id) async {
    _isLoading = true;
    notifyListeners();
    _productDetail = await _service.fetchProductDetail(id);
    _isLoading = false;
    notifyListeners();
  }
}
