import 'package:application/resources/string_manager.dart';
import 'package:application/resources/color_manager.dart';
import 'package:application/resources/fonts_manager.dart';
import 'package:application/resources/styles_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../product_page/products_list.dart';

class MyLists extends StatefulWidget {
  static String id = 'wishList';
  const MyLists({super.key});

  @override
  State<MyLists> createState() => _MyListsState();
}

class _MyListsState extends State<MyLists> {
  bool isLoading = false;
  Map lists = {};
  List<String> docID = [];
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  static String? uid = FirebaseAuth.instance.currentUser?.uid;

  addList() {
    Map<String, dynamic> demolists = {
      "name": _listNameController.text,
      "qty": 0,
      "total": 0,
      "uid": uid,
    };

    //refer to collections
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('wishlist');
    collectionReference.add(demolists).whenComplete(
        () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(StringManager.itemAdded),
            )));
  }

  final TextEditingController _listNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.arrow_back, color: ColorManager.secondary),
                const SizedBox(width: 10),
                Text(
                  StringManager.listPagebar,
                  style: getBoldStyle(
                      fontSize: FontSize.s18, color: ColorManager.secondary),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.search, color: ColorManager.secondary),
                const SizedBox(width: 18),
                Icon(Icons.qr_code_scanner_sharp,
                    color: ColorManager.secondary),
              ],
            ),
          ],
        ),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('wishlist')
                    .where("uid",
                        isEqualTo: FirebaseAuth.instance.currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          QueryDocumentSnapshot<Object?> documentSnapshot =
                              snapshot.data!.docs.elementAt(index);

                          return Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, right: 20),
                              child: InkWell(
                                onTap: () {
                                  //Navigator.pushNamed(context, ProductList.id,arguments: ProductList(wId: documentSnapshot.id, tittle: "${snapshot.data?.docs[index]['name']}"));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProductList(
                                                wId: documentSnapshot.id,
                                                tittle:
                                                    "${snapshot.data?.docs[index]['name']}",
                                              )));
                                },
                                child: Card(
                                  elevation: 2,
                                  color: ColorManager.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                      height: 100,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                snapshot.data?.docs[index]
                                                        ['name'] ??
                                                    '',
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w500)),
                                            Container(
                                              height: 100,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.3,
                                              decoration: BoxDecoration(
                                                  color:
                                                      ColorManager.lightgreen,
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10))),
                                              child: Align(
                                                  alignment: Alignment.center,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        "Qty : ${snapshot.data?.docs[index]['qty'].toString() ?? ''}",
                                                        style: getMediumStyle(
                                                            color: ColorManager
                                                                .lightGrey),
                                                      ),
                                                      Text(
                                                        "Total : ₹${snapshot.data?.docs[index]['total'].toString() ?? ''}",
                                                        style: getBoldStyle(
                                                            color: ColorManager
                                                                .primary,
                                                            fontSize: 16),
                                                      )
                                                    ],
                                                  )),
                                            )
                                          ],
                                        ),
                                      )),
                                ),
                              ));
                        });
                  }
                  return const Text(StringManager.loading);
                },
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.lightgreen,
                        borderRadius: BorderRadius.circular(30)),
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      controller: _listNameController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(left: 10),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                    onTap: () {
                                      _listNameController.text.isEmpty
                                          ? null
                                          : addList();
                                      _listNameController.clear();
                                    },
                                    child: Icon(
                                      Icons.add,
                                      color: ColorManager.white,
                                    ))),
                          ),
                          hintText: StringManager.newList,
                          hintStyle: TextStyle(
                            color: ColorManager.primary,
                            fontWeight: FontWeight.w600,
                          ),
                          focusColor: ColorManager.primary,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: ColorManager.primary),
                              borderRadius: BorderRadius.circular(30)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 2, color: ColorManager.primary),
                              borderRadius: BorderRadius.circular(30)),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: ColorManager.primary,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          )),
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
