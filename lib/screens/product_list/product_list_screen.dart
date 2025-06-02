import 'package:dummy_json_fetching/screens/product_detail/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/product_provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: ChangeNotifierProvider(
        create: (context) => ProductProvider()..loadProducts(),
        child: Consumer<ProductProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            if (provider.products.isEmpty) {
              return const Center(
                  child: Text("No products available"));
            }
            return RefreshIndicator(
              onRefresh: ()async {
                context.read<ProductProvider>().loadProducts();
              },
              child: ListView.builder(
                itemCount: provider.products.length,
                itemBuilder: (context, index) {
                  
                  final product = provider.products[index];
                  return ListTile(
                    leading: product.thumbnail != null
                        ? Image.network(product.thumbnail!, width: 50)
                        : const SizedBox(),
                    title: Text(product.title ?? "(No Title Product)"),
                    subtitle: Text("\$${product.price} • ${product.brand ?? ""}"),
                    trailing: Text(
                        (product.stock ?? 0) > 0 ? "In Stock" : "Out of Stock"),
                 onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailScreen(id: product.id ?? 0),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
     
    );
  }
}
