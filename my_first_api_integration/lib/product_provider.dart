import 'package:flutter/material.dart';
import 'package:my_first_api_integration/product_api_helper.dart';
import 'package:my_first_api_integration/product_model.dart';

class ProductProvider with ChangeNotifier {
  var titleController = TextEditingController();
  var priceController = TextEditingController();
  var descriptionController = TextEditingController();
  var categoryController = TextEditingController();
  var imageController = TextEditingController();

  List<ProductModel> productList = [];

  getProductData() async {
    var get = await ProductApiHelper.getAllApiProductData();
    if (get != null) {
      productList.clear();
      productList.addAll(get);
      notifyListeners();
    }
  }

  postProductData(BuildContext context) async {
    var data = {
      'title': titleController.text,
      'price': priceController.text,
      'description': descriptionController.text,
      'category': categoryController.text,
      'image': imageController.text,
    };
    var postData = await ProductApiHelper.postProductApiData(data);
    if (postData != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Successfully posted')));
      getProductData();
    }
  }

  updateProductData(BuildContext context, int id) async {
    var updatedData = {
      'id': id,
      'title': titleController.text,
      'price': priceController.text,
      'description': descriptionController.text,
      'category': categoryController.text,
      'image': imageController.text,
    };
    var updateData = await ProductApiHelper.updateProductApiData(updatedData);
    if (updateData != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Successfully updated')));
      getProductData();
    }
  }

  deleteProductData(int id, BuildContext context) async {
    var delete = await ProductApiHelper.deleteProductApiData(id);
    if (delete != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Deleted successfully')));
      getProductData();
    }
  }
}
