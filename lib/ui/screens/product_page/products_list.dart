import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/fonts_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'product_card.dart';

class ProductList extends StatefulWidget {
  final String tittle;

  const ProductList({super.key, required this.tittle});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final ref = FirebaseDatabase.instance.ref('product');
  final cartDatabase = FirebaseFirestore.instance.collection('cart');

  //cart_firestore
  // List<int> qtyList = [];
  List<QueryDocumentSnapshot<Map<String, dynamic>>> card = [];
  int qty = 0;
  int total = 0;
  String id = '';
  //get docID
  Future getDocId() async {
    await FirebaseFirestore.instance.collection('cart').get().then((value) {
      card = value.docs;
    });
  }

  List<String> docCartID = [];
// Future getCartDocId() async {
//     await FirebaseFirestore.instance.collection('cart').get().then((value) => value.docs.forEach((document) {
//               print({document.reference});
//             id =  document.reference.id;
//             }));
//   }

  //String? documentId = null;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    getDocId();
    //getCartDocId();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: FirebaseAnimatedList(
                    query: ref,
                    defaultChild: const Text('Loading'),
                    itemBuilder: (context, snapshot, animation, index) {
                      // print("list : $qtyList");
                      return Padding(
                        padding: const EdgeInsets.only(left: 14.0, right: 14.0),
                        child: ProductCard(
                            snapshot: snapshot,
                            qtyListData: card[index]['qty'],
                            // docCartID:"5" ,
                            addProductQty: () {
                              cartDatabase.doc("card[index]");
                              // ref1.docs[] .update({'qty':widget.qtyListData});
                            },
                            addRemoveProduct:
                                (qty, pid, total, isAddRemove) async {}),
                      );
                    }),
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
                          getBoldStyle(color: ColorManager.white, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            //top: 100,
            bottom: 6,
            left: MediaQuery.of(context).size.width * 0.3,

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
                        Text(
                          '₹330',
                          style: getBoldStyle(
                              color: ColorManager.primary, fontSize: 14),
                        ),
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
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                widget.tittle,
                style: getBoldStyle(
                    fontSize: FontSize.s20, color: ColorManager.secondary),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.search, color: ColorManager.secondary),
              SizedBox(width: 18),
              Icon(Icons.qr_code_scanner_sharp, color: ColorManager.secondary),
            ],
          ),
        ],
      ),
    );
  }
}
