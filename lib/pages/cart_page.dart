import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/main.dart'; // for MyStore
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_application_1/models/mutations.dart';
import 'package:flutter_application_1/core/store.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: "Cart".text.make(),
      ),
      body: Column(
        children: const [
          Expanded(child: _CartList()),
          Divider(),
          _CartTotal(),
        ],
      ),
    );
  }
}

class _CartTotal extends StatelessWidget {
  const _CartTotal({super.key});

  @override
  Widget build(BuildContext context) {
    return VxBuilder(
      mutations: {AddMutation, RemoveMutation}, // 👈 THIS IS KEY
      builder: (context, MyStore store, status) {
        final cart = store.cart;

        return SizedBox(
          height: 200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              "\$${cart.totalPrice}"
                  .text
                  .xl5
                  .color(MyTheme.darkBluishColor)
                  .make(),

              30.widthBox,

              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: "Buying not supported yet.".text.make(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: MyTheme.darkBluishColor,
                  foregroundColor: Colors.white,
                ),
                child: "Buy".text.white.make(),
              ).w32(context),
            ],
          ),
        );
      },
    );
  }
}
class _CartList extends StatelessWidget {
  const _CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return VxBuilder(
      mutations: {RemoveMutation, AddMutation}, // 👈 listen changes
      builder: (context, MyStore store, status) {
        final cart = store.cart;

        if (cart.items.isEmpty) {
          return "Nothing to show".text.xl3.makeCentered();
        }

        return ListView.builder(
          itemCount: cart.items.length,
          itemBuilder: (context, index) {
            final item = cart.items[index];

            return ListTile(
              leading: const Icon(Icons.done),

              trailing: IconButton(
                icon: const Icon(Icons.remove_circle_outline),
                onPressed: () {
                  RemoveMutation(item); // ✅ triggers rebuild
                },
              ),

              title: item.name.text.make(),
            );
          },
        );
      },
    );
  }
}