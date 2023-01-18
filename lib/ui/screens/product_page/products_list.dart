import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/fonts_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

// ignore: must_be_immutable
class ProductList extends StatefulWidget {
  final String tittle;
  String wId;
  ProductList({super.key, required this.wId, required this.tittle});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ref = db.FirebaseDatabase.instance.ref('product');
  final cartDatabase = FirebaseFirestore.instance.collection('cart');

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48),
                  child: FirebaseAnimatedList(
                      query: ref,
                      shrinkWrap: true,
                      defaultChild: const Text('Loading'),
                      itemBuilder: (context, snapshot, animation, index) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(left: 14.0, right: 14.0),
                          child: ProductCard(
                            wId: widget.wId,
                            snapshot: snapshot,
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
          Positioned(
            //top: 100,
            bottom: 5,
            left: MediaQuery.of(context).size.width * 0.05,

            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorManager.primary,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 28),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.assignment,
                      color: ColorManager.white,
                    ),
                    Text(
                      "Buy the list",
                      style:
                          getBoldStyle(color: ColorManager.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            //top: 100,
            bottom: 6,

            left: MediaQuery.of(context).size.width * 0.354,

            child: Container(
              width: MediaQuery.of(context).size.width * 0.3,
              height: 38,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorManager.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: ClipRect(
                      child: Image.asset(
                        IconAssets.ic_Cart,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Totals:',
                          style: getMediumStyle(
                              color: ColorManager.darkGrey, fontSize: 10),
                        ),
                        StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("wishlist")
                              .doc(widget.wId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              var data = snapshot.data?.get("total");
                              return Text(data.toString());
                            } else {
                              return const Text("0");
                            }
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      foregroundColor: ColorManager.secondary,
      backgroundColor: ColorManager.white,
      title: Text(
        widget.tittle,
        style:
            getBoldStyle(fontSize: FontSize.s20, color: ColorManager.secondary),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
                onTap: () {
                  showSearch(
                      context: context,
                      delegate: DataSearch(widget.wId, widget.tittle));
                },
                child: Icon(Icons.search, color: ColorManager.secondary)),
            const SizedBox(width: 18),
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Icon(Icons.qr_code_scanner_sharp,
                  color: ColorManager.secondary),
            ),
          ],
        ),
      ],
    );
  }
}

class DataSearch extends SearchDelegate<String> {
  String wId;
  String tittle;
  DataSearch(this.wId, this.tittle);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: (() {
            query = "";
          }),
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: (() {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ProductList(
              wId: wId,
              tittle: tittle,
            ),
          ));
        }));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FirebaseAnimatedList(
        query: getStrem(query),
        shrinkWrap: true,
        defaultChild: const Text('Loading'),
        itemBuilder: (context, snapshot, animation, index) {
          return ProductCard(wId: wId, snapshot: snapshot);
        });
  }

  @override
  Widget buildSuggestions(BuildContext contexts) {
    return FirebaseAnimatedList(
        query: getStrem(query),
        shrinkWrap: true,
        defaultChild: const Text('Loading'),
        itemBuilder: (contexts, snapshot, animation, index) {
          return ProductCard(wId: wId, snapshot: snapshot);
        });
  }

  db.Query getStrem(String query) {
    var z = db.FirebaseDatabase.instance
        .ref("product")
        .orderByChild("pname")
        .equalTo(query);

    return z;
  }
}
