import 'dart:io';

import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
  DataSnapshot snapshot;
  int qtyListData;
  String? docCartID;
  Function addProductQty;
  Function(int, String, int, bool) addRemoveProduct;

  ProductCard(
      {Key? key,
      required this.snapshot,
      required this.addRemoveProduct,
       this.docCartID,
      required this.qtyListData,
      required this.addProductQty})
      : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // final ref1 = FirebaseFirestore.instance.collection('cart');
  
  @override
  Widget build(BuildContext context) {
    return Card(
      //title: Text(snapshot.child('pname').value.toString(),style: TextStyle(color: Colors.black),),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: 130,
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(12)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        topLeft: Radius.circular(12)),
                    child: Image.network(
                      widget.snapshot.child('image').value.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 100,
                  decoration: BoxDecoration(
                      color: ColorManager.lightgreen2,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(30))),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text('10% Discount',
                            style: getLightStyle(
                                color: ColorManager.white, fontSize: 12)),
                      )),
                ),
                Positioned(
                  bottom: 4,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white70),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star,
                              size: 16, color: ColorManager.primary),
                          const SizedBox(width: 2),
                          Text('4.5',
                              style: TextStyle(
                                  color: ColorManager.secondary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                SizedBox(
                  width: 70,
                  height: 20,
                  child: Image.asset(ImageAssets.tesco, fit: BoxFit.fill),
                ),
                const SizedBox(height: 8),
                Text(widget.snapshot.child('pname').value.toString(),
                    style: getSemiBoldStyle(
                        color: ColorManager.secondary, fontSize: 16)),
                const SizedBox(height: 4),
                Text('(500 g - ₹20)',
                    style: getMediumStyle(
                        color: ColorManager.lightGrey, fontSize: 14)),
                const SizedBox(height: 6),
                Text(
                  widget.snapshot.child('desc').value.toString(),
                  style: TextStyle(color: ColorManager.darkred, fontSize: 15),
                ),
                // Text(
                //   snapshot.child('qty').value.toString(),
                //   style: TextStyle(
                //       color: ColorManager.darkred,
                //       fontSize: 15),
                // ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 10, top: 48.0),
                  child: Column(
                    children: [
                      Text('1x kg',
                          style: getMediumStyle(
                              color: ColorManager.darkGrey, fontSize: 14)),
                      Text(
                        "₹${widget.snapshot.child('prize').value.toString()}",
                        style: getBoldStyle(
                            color: ColorManager.primary, fontSize: 22),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10),
                  child: Container(
                    width: 100,
                    height: 30,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: ColorManager.lightgreen),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            if (widget.qtyListData > 0) {
                              widget.qtyListData--;
                            }

                            setState(() {
                              widget.qtyListData;
                            });
                          },
                          child: Icon(
                            Icons.remove_circle_outline,
                            color: ColorManager.primary,
                          ),
                        ),
                        Text(widget.qtyListData.toString()),
                        InkWell(
                          onTap: () {
                            widget.qtyListData++;
                            widget.addProductQty();
                            print("IDDDDD${widget.docCartID}");
                            //ref1.doc((widget.docCartID[]).toString()).update({'qty':widget.qtyListData});
                            setState(() {
                              widget.qtyListData;
                            });
                            // widget.addRemoveProduct(
                            //     1,
                            //     widget.snapshot.child('id').toString(),
                            //     200,
                            //     true);

                            // setState(() {
                            //   // ref.child('qty').update({"qty": 1});
                            //   //numOfItem = numOfItem + 1;
                            // });
                          },
                          child: Icon(
                            Icons.add_circle_outline,
                            color: ColorManager.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
