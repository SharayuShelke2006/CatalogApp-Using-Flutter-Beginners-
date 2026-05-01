import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/models/mutations.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/core/store.dart ';

class AddToCart extends StatelessWidget {
  final Item catalog;

  const AddToCart({Key? key, required this.catalog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return VxBuilder(
      mutations: {AddMutation, RemoveMutation},
      builder: (context, MyStore store, status) {
        final cart = store.cart;
        final bool isInCart = cart.items.contains(catalog);

        return ElevatedButton(
          onPressed: isInCart
              ? null
              : () {
                  AddMutation(catalog);

                  // ✅ snackbar here (safe)
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: "Added to cart".text.make(),
                    ),
                  );
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: MyTheme.darkBluishColor,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
          ),
          child: isInCart
              ? const Icon(Icons.done, color: Colors.white)
              : "Add to cart".text.white.make(),
        );
      },
    );
  }
}