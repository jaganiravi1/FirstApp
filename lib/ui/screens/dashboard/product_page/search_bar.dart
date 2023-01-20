
import 'package:application/ui/screens/dashboard/product_page/product_card.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
   static String id = 'SearchBar';
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
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: (() {
          Navigator.of(context).pop();
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
    return Text(" ");
  }
  //   return FirebaseAnimatedList(
  //       query: getStrem(query),
  //       shrinkWrap: true,
  //       defaultChild: const Text('Loading'),
  //       itemBuilder: (contexts, snapshot, animation, index) {
  //         return ProductCard(wId: wId, snapshot: snapshot);
  //       });
  // }

  db.Query getStrem(String query) {
    var z = db.FirebaseDatabase.instance
        .ref("product")
        .orderByChild("pname")
        .equalTo(query);

    return z;
  }
}
