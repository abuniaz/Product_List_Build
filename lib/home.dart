import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:list_build/Models/products_model.dart';

class ListBuild extends StatefulWidget {
  const ListBuild({Key? key}) : super(key: key);

  @override
  State<ListBuild> createState() => _ListBuildState();
}

class _ListBuildState extends State<ListBuild> {
  Future<ProductsModel> getProductsApi() async {
    final response = await http
        .get(Uri.parse('webhook.site/bc464751-ff95-4ad8-ac89-2fec83fc882a'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return ProductsModel.fromJson(data);
    } else {
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Calling'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(builder: ((context, snapshot) {
            return ListView.builder(itemBuilder: ((context, index) {
              return Column();
            }));
          })))
        ],
      ),
    );
  }
}
