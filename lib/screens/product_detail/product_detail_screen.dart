import 'package:dummy_json_fetching/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
 const ProductDetailScreen({super.key,required this.id});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Product Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ChangeNotifierProvider(
          create: (context) => ProductProvider()..loadProductDetails(widget.id),
          child: Consumer<ProductProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (provider.productDetail == null) {
                return const Center(
                    child: Text("No products details available"));
              }
              return Column(
                spacing: 10,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Name: ${provider.productDetail?.title ?? ""}"),
                  Text("Images:"),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: provider.productDetail?.images
                              ?.map((img) => Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Image.network(img),
                                  ))
                              .toList() ??
                          [],
                    ),
                  ),
                  Text("\$${provider.productDetail?.price ?? 0}"),
                  Text(provider.productDetail?.description ??
                      "(Description unavailable)"),
                  Text("Reviews: ★★★★☆ (placeholder)"),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
