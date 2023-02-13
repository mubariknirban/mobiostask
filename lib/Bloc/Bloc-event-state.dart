
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobiosolutiontask/Apirepositary/Jsonrepositary.dart';
import 'package:mobiosolutiontask/Model/ProductModels.dart';


/************************************ Event Class ****************************************/

abstract class itemevent {

  const itemevent();
}

class Getitemclass extends itemevent {
  @override
  // TODO: implement props
  List<Object> get props => [];

}

/***********************************  State Class ****************************************/

abstract class itemstate {}

class iteminitialstate extends itemstate {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class itemloading extends itemstate {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class itemsuccess extends itemstate {


  List<Productlist> productModel;
  itemsuccess(this.productModel);

  @override
  // TODO: implement props
  List<Object> get props => [];



}

class itemerrorpage extends itemstate {

  final String erromsz;

  itemerrorpage({
    required this.erromsz
  });

  //itemerrorpage(this.erromsz);

  @override
  // TODO: implement props
  List<Object> get props => [];
}

/***********************************  Bloc Class *****************************************/

class Productbloc extends Bloc<itemevent,itemstate>{

  Productbloc() : super (iteminitialstate()){

    final jsonfile jsonapi = jsonfile();

    on<Getitemclass>((event, emit) async {

      try{
        emit(itemloading());
        final mList = await jsonapi.Getdatafromfile();
        emit(itemsuccess(mList));
      } catch(e) {
          emit(itemerrorpage(erromsz: e.toString()));
      }
    });


  }

}


