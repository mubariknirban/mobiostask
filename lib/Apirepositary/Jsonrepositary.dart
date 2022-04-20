
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:mobiosolutiontask/Model/ProductModels.dart';

class jsonfile{


  Future<List<Productlist>> Getdatafromfile()async{

    final jsondata = await rootBundle.loadString('jsonfile/Products.json');
    final listitem = json.decode(jsondata) as List;

    return listitem.map((e) => Productlist.fromJson(e)).toList();

  }


}