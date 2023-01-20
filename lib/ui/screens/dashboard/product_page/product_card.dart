import 'package:application/resources/assets_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/string_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:application/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatefulWidget {
   static String id = 'productCard';
  DataSnapshot snapshot;

  String wId;
  ProductCard({
    Key? key,
    required this.wId,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  int qty = 0;
  int total = 0;

  getQuantity() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    var quary = await firestore
        .collection("cart")
        .where("pid", isEqualTo: widget.snapshot.child("pid").value)
        .where("wid", isEqualTo: widget.wId)
        .get();

    if (quary.size == 0) {
    } else {
      var cId = quary.docs.first.id;
      var dbQty = await firestore
          .collection("cart")
          .doc(cId)
          .get()
          .then((value) => value.get("qty"));
      setState(() {
        qty = dbQty;
      });
    }
  }

  @override
  void initState() {
    getQuantity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      //title: Text(snapshot.child('pname').value.toString(),style: TextStyle(color: Colors.black),),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.25,
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.35,
                  height: MediaQuery.of(context).size.height * 0.25,
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
                  height: MediaQuery.of(context).size.height * 0.028,
                  width: MediaQuery.of(context).size.width * 0.26,
                  decoration: BoxDecoration(
                      color: ColorManager.lightgreen2,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          bottomRight: Radius.circular(30))),
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Text(StringManager.discount,
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
            //SizedBox(width: 5),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  //color: Colors.lightBlue,
                  width: MediaQuery.of(context).size.width,
                  //color: Colors.blueAccent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 70,
                        height: 20,
                        child: Image.asset(ImageAssets.tesco, fit: BoxFit.fill),
                      ),
                      const SizedBox(height: 4),
                      Text(widget.snapshot.child('pname').value.toString(),
                          style: getSemiBoldStyle(
                              color: ColorManager.secondary, fontSize: 16)),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(StringManager.gram,
                              textAlign: TextAlign.left,
                              style: getMediumStyle(
                                  color: ColorManager.lightGrey, fontSize: 14)),
                          Column(
                            children: [
                              Text(StringManager.kg,
                                  style: getMediumStyle(
                                      color: ColorManager.darkGrey,
                                      fontSize: 14)),
                              Text(
                                "₹${widget.snapshot.child('prize').value.toString()}",
                                style: getBoldStyle(
                                    color: ColorManager.primary, fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Expanded(
                        child: Text(
                          widget.snapshot.child('desc').value.toString(),
                          style: TextStyle(
                              color: ColorManager.darkred, fontSize: 15),
                        ),
                      ),
                      //
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0, right: 8),
                          child: Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: ColorManager.lightgreen),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (qty >= 1) {
                                        qty -= 1;
                                        var prize = widget.snapshot
                                            .child("prize")
                                            .value;
                                        total = (prize as int) * qty;
                                        FirebaseDb.getCreateCart(
                                            widget.snapshot.child("pid").value,
                                            widget.wId,
                                            qty,
                                            total);
                                        FirebaseDb.getWishListTotalRemove(
                                            widget.wId,
                                            widget.snapshot
                                                .child("prize")
                                                .value);
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_circle_outline,
                                    color: ColorManager.primary,
                                  ),
                                ),
                                //Text(widget.qtyListData.toString()),
                                Text("${qty}"),

                                InkWell(
                                  onTap: () async {
                                    setState(() {
                                      qty += 1;
                                      var prize =
                                          widget.snapshot.child("prize").value;
                                      total = (prize as int) * qty;
                                    });
                                    FirebaseDb.getCreateCart(
                                        widget.snapshot.child("pid").value,
                                        widget.wId,
                                        qty,
                                        total);
                                    FirebaseDb.getWishListTotalAdd(widget.wId,
                                        widget.snapshot.child("prize").value);
                                  },
                                  child: Icon(
                                    Icons.add_circle_outline,
                                    color: ColorManager.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
