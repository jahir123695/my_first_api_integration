import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_first_api_integration/product_model.dart';

class ProductApiHelper {
  static Future<List<ProductModel>?> getAllApiProductData() async {
    var response = await http.get(
      Uri.parse('https://fakestoreapi.com/products'),
    );
    if (response.statusCode == 200) {
      var respBody = response.body;
      List<dynamic> jsonBody = jsonDecode(respBody);
      var convertToModel =
          jsonBody.map((e) => ProductModel.jsonToModel(e)).toList();
      return convertToModel;
    }
    return null;
  }

  static Future<ProductModel?> postProductApiData(
    Map<String, dynamic> data,
  ) async {
    var response = await http.post(
      Uri.parse('https://fakestoreapi.com/products'),
      body: data,
    );
    if (response.statusCode == 201) {
      var body = response.body;
      dynamic jsonBody = jsonDecode(body);
      var convert = ProductModel.jsonToModel(jsonBody);
      return convert;
    }
    return null;
  }

  static Future<ProductModel?> updateProductApiData(
    Map<String, dynamic> data,
  ) async {
    var response = await http.put(
      Uri.parse('https://fakestoreapi.com/products/${data['id']}'),
    );
    if (response.statusCode == 200) {
      var responseBody = response.body;
      dynamic jsonBody = jsonDecode(responseBody);
      var convert = ProductModel.jsonToModel(jsonBody);
      return convert;
    }
    return null;
  }

  static Future<String?> deleteProductApiData(int id) async {
    var response = await http.delete(
      Uri.parse('https://fakestoreapi.com/products/$id'),
    );
    if (response.statusCode == 200) {
      return 'success';
    }
    return null;
  }
}
