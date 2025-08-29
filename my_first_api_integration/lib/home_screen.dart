import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_first_api_integration/post_product_screen.dart';
import 'package:my_first_api_integration/product_provider.dart';
import 'package:my_first_api_integration/product_update_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    var provider = Provider.of<ProductProvider>(context, listen: false);
    provider.getProductData();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Get data'),
          flexibleSpace: Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey, width: 0.5),
              ),
            ),
          ),
        ),
        body: Consumer<ProductProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return value.productList.isEmpty
                ? Center(child: Text('Product not founded!'))
                : ListView.builder(
                  itemCount: value.productList.length,
                  itemBuilder: (context, index) {
                    var productData = value.productList[index];
                    return ListTile(
                      title: Text('${productData.title}'),
                      subtitle: Text('${productData.price}'),
                      trailing: SizedBox(
                        width: 96,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => ProductUpdateScreen(
                                          id: productData.id ?? 0,
                                        ),
                                  ),
                                );
                              },
                              icon: Icon(Icons.edit),
                            ),
                            IconButton(
                              onPressed: () {
                                provider.deleteProductData(
                                  productData.id ?? 0,
                                  context,
                                );
                              },
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PostProductScreen()),
            );
          },
          child: Icon(CupertinoIcons.add),
        ),
      ),
    );
  }
}
