import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Database/db.dart';
import '../Model/Itemmodel.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  int itemcount = 0; // this int use for total item in cart.

  late List<productdb> item;

  double amounttotal = 0; // this int use for total amount of product.

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasehandler = Databasehandler();
    totalitem();
  }

  late Databasehandler databasehandler;

  void totalitem()async{
    item = await databasehandler.retrieveUsers();
    setState((){
      itemcount = item.length;
      amounttotal = item.fold(0, (sum, item) => sum + int.parse(item.price));
    });
  }


  // For Delete Item Slide item left side.

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Center(child: Text("My Cart")),
          ),
          body: Container(
            //Using FutureBuilder for show data form DataBase.
            child:  FutureBuilder(
              future: this.databasehandler.retrieveUsers(),
              builder: (BuildContext context, AsyncSnapshot<List<productdb>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Icon(Icons.delete_forever),
                        ),
                        key: ValueKey<int>(snapshot.data![index].id!),
                        onDismissed: (DismissDirection direction) async {
                          // This function use for delete the item when slide left side.
                          await this.databasehandler.deleteUser(snapshot.data![index].id!);
                          setState(() {
                            snapshot.data!.remove(snapshot.data![index]);
                          });
                        },
                        child: Container(
                            margin: EdgeInsets.all(5),
                            child: Card(
                              elevation: 5,
                              shadowColor: Colors.grey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                      width: 150,
                                      height: 100,
                                      child: Image.asset('assets/cotton.png',fit: BoxFit.fill,)),
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text("${snapshot.data![index].name}",style: Theme.of(context).textTheme.titleLarge,),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Price:-",style: Theme.of(context).textTheme.bodyLarge,),
                                              Text("\u{20B9} ${snapshot.data![index].price}",style: Theme.of(context).textTheme.bodyLarge,)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Quantity:-",style: Theme.of(context).textTheme.bodyLarge,),
                                              Text("${snapshot.data![index].quantity}",style: Theme.of(context).textTheme.bodyLarge,)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Brand:-",style: Theme.of(context).textTheme.bodyLarge,),
                                              Text("${snapshot.data![index].brand}",style: Theme.of(context).textTheme.bodyLarge,)
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        )
                      );
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
