import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/catalog.dart';
import 'package:flutter_application_1/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeDetailPage extends StatelessWidget {
  final Item catalog;

  const HomeDetailPage({Key? key, required this.catalog})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      backgroundColor: Theme.of(context).canvasColor,

      bottomNavigationBar: Container(
        color: Theme.of(context).cardColor,
        child: ButtonBar(
          alignment: MainAxisAlignment.spaceBetween,
          buttonPadding: EdgeInsets.zero,
          children: [
            "\$${catalog.price}".text.bold.xl4.red800.make(),

           ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: MyTheme.darkBluishColor,
    foregroundColor: Colors.white, // ✅ FIX (text color)
    shape: const StadiumBorder(),
  ),
  child: "Add to cart".text.white.make(), // ✅ extra safety
).wh(150, 50),
          ],
        ).p32(),
      ),

      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Hero(
              tag: catalog.id.toString(), // ✅ FIXED
              child: Image.network(catalog.image),
            ).h32(context),

            Expanded(
              child: VxArc(
                height: 30.0,

                // ✅ FIXED (new enum names)
                arcType: VxArcType.convex,
                edge: VxEdge.top,

                child: Container(
                  color: Theme.of(context).cardColor,
                  width: context.screenWidth,
                  child: Column(
                    children: [
                      catalog.name.text.xl4
                          .color(MyTheme.darkBluishColor) // ✅ FIXED
                          .bold
                          .make(),

                      catalog.desc.text
                          .textStyle(
                            Theme.of(context).textTheme.bodySmall, // ✅ FIXED
                          )
                          .xl
                          .make(),

                      10.heightBox,

                      "Dolor sea takimata ipsum sea eirmod aliquyam est..."
                          .text
                          .textStyle(
                            Theme.of(context).textTheme.bodySmall, // ✅ FIXED
                          )
                          .make()
                          .p16(),
                    ],
                  ).py64(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}