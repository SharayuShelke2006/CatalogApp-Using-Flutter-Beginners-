import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/utils/routes.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalog_header.dart';
import 'package:flutter_application_1/widgets/home_widgets/catalog_list.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/models/mutations.dart';

import 'package:flutter_application_1/core/store.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int days = 30;
  final String name = "Codepur";

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    await Future.delayed(const Duration(seconds: 2));

    final catalogJson =
        await rootBundle.loadString("assets/files/catalog.json");

    final decodedData = jsonDecode(catalogJson);
    var productsData = decodedData["products"];

    CatalogModel.items = List.from(productsData)
        .map<Item>((item) => Item.fromMap(item))
        .toList();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,

      floatingActionButton: VxBuilder(
  mutations: {AddMutation, RemoveMutation}, // 👈 listen to cart changes
  builder: (context, MyStore store, status) {
    final cart = store.cart;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, MyRoutes.cartRoute);
          },
          backgroundColor: MyTheme.darkBluishColor,
          child: const Icon(
            CupertinoIcons.cart,
            color: Colors.white,
          ),
        ),

        // 🔴 Badge
        if (cart.items.isNotEmpty)
          Positioned(
            right: -5,
            top: -5,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.red,
              child: "${cart.items.length}"
                  .text
                  .xs
                  .white
                  .make(),
            ),
          ),
      ],
    );
  },
),

      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(32),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CatalogHeader(),

              if (CatalogModel.items.isNotEmpty)
                const CatalogList().expand()
              else
                const Center(
                  child: CircularProgressIndicator(),
                ).expand(),
            ],
          ),
        ),
      ),
    );
  }
}