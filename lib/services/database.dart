import 'package:application/user_preferences/user_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class FirebaseDB {
//   static getQuantity({required String pid, required String wid ,required Function(dynamic) onSetState  })async{
// FirebaseFirestore firestore =
//                               await  FirebaseFirestore.instance;
//                             var quary = await firestore
//                                 .collection("cart")
//                                 .where("pid",
//                                     isEqualTo:
//                                         pid)
//                                 .where("wid", isEqualTo: wid)
//                                 .get();

//                             if (quary.size == 0) {
                             
//                             } else {
//                               var cId = quary.docs.first.id;
//  var x= await firestore.collection("cart").doc(cId).get().then((value) => value.get("qty"));
//                             await onSetState(x);
                            
//                             }
// }
  
//}

class FirebaseDb {
  static getCreateCart(pid,wId,qty,total) async {
     FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
                            var quary = await firestore
                                .collection("cart")
                                .where("pid",
                                    isEqualTo:
                                        pid)
                                .where("wid", isEqualTo: wId)
                                .get();

                            if (quary.size == 0) {
                              firestore.collection("cart").add({
                                'uid': await UserPreferences.getUserId(),
                                'pid':pid,
                                'qty': qty,
                                'total': total,
                                'wid':wId
                              });
                            } else {
                              var cId = quary.docs.first.id;

                              firestore.collection("cart").doc(cId).update({
                                'qty': qty,
                                'total': total,
                              });
                            }
  }

  static getWishListTotalAdd(wId,prize) async {
    FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
       var wQty = await firestore
                                .collection("wishlist")
                                .doc(wId)
                                .get()
                                .then((value) => value.get("qty"));
                            var wTotal = await firestore
                                .collection("wishlist")
                                .doc(wId)
                                .get()
                                .then((value) => value.get("total"));
                            await firestore
                                .collection("wishlist")
                                .doc(wId)
                                .update({
                              "qty": wQty += 1,
                              "total": wTotal += prize
                            });
  }
  static getWishListTotalRemove(wId,prize) async {
    FirebaseFirestore firestore =
                                FirebaseFirestore.instance;
       var wQty = await firestore
                                .collection("wishlist")
                                .doc(wId)
                                .get()
                                .then((value) => value.get("qty"));
                            var wTotal = await firestore
                                .collection("wishlist")
                                .doc(wId)
                                .get()
                                .then((value) => value.get("total"));
                            await firestore
                                .collection("wishlist")
                                .doc(wId)
                                .update({
                              "qty": wQty -= 1,
                              "total": wTotal -= prize
                            });
  }
}
