import 'dart:convert';

import 'package:application/model/responses/customer.dart';
import 'package:flutter/material.dart';


import '../bloc/api_constants.dart';
import '../bloc/network_cubit.dart';
import 'package:http/http.dart' as http;

class RandomUserProvider with ChangeNotifier {
  NetworkCubit? networkCubit;
  ModelCustomer? customerDetail;

  getRandomUser() async {
    http.Response? response;
    response =
        await networkCubit!.networkGetRequest(APIConstants.randomUser, Map());
    //print("Request Response : ${response!.body}End");
    return response;
  }
}