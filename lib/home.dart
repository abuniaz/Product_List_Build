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
          Expanded(
              child: FutureBuilder<ProductsModel>(
                  future: getProductsApi(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.data.length,
                          itemBuilder: ((context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  title: Text(
                                    snapshot.data!.data[index].shop.name
                                        .toString(),
                                  ),
                                  subtitle: Text(
                                    snapshot.data!.data[index].shop.shopemail
                                        .toString(),
                                  ),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      snapshot.data!.data[index].shop.image
                                          .toString(),
                                    ),
                                  ),
                                ),
                                Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshot
                                          .data!.data[index].image.length,
                                      itemBuilder: ((context, position) {
                                        return Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  .25,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  .5,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .data[index]
                                                        .image[position]
                                                        .toString()),
                                                  ))),
                                        );
                                      })),
                                )
                              ],
                            );
                          }));
                    } else {
                      return const Text('Loading');
                    }
                  })))
        ],
      ),
    );
  }
}
