import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobiosolutiontask/Database/db.dart';

import '../Bloc/Bloc-event-state.dart';
import '../Model/Itemmodel.dart';

class Productlist extends StatefulWidget {
  const Productlist({Key? key}) : super(key: key);

  @override
  State<Productlist> createState() => _ProductlistState();
}

class _ProductlistState extends State<Productlist> {

  int id = 1;
  String dropdownValue = 'Select Brand';
  late String color;

  TextEditingController quantity = TextEditingController();

  int quantityItem = 1;
  bool botVisible = false;

  late String name,price,quaty;

  String brand = "no data";

  late Databasehandler databasehandler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databasehandler = Databasehandler();
    BlocProvider.of<Productbloc>(context).add(Getitemclass());
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Product List"),
            actions: [
              Container(
                margin: EdgeInsets.only(right: 5,top: 2),
                child: IconButton(
                    onPressed: (){
                      Navigator.pushNamed(context, 'Cartpage');
                    },
                    icon:Icon(Icons.shopping_cart,size: 30,) ),
              )
            ],
          ),
          bottomSheet: Visibility(
            visible: botVisible,
            child: Container(
              height: 50,
              color: Colors.blue,
              child: Container(
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text("Quantity: ",style:TextStyle(color: Colors.white,fontSize: 15)),
                        GestureDetector(
                          onTap: (){
                            if(quantityItem > 1){
                              setState(() {
                                quantityItem--;
                              });
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black
                                ),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: Icon(Icons.remove),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 35,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(40)
                          ),
                          child: Center(child: Text("${quantityItem}")),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              quantityItem++;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: Colors.black
                                ),
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: Icon(Icons.add),
                          ),
                        )
                      ],
                    ),
                    Container(
                        height: 30,
                        width: 60,
                        decoration: BoxDecoration(
                          color: Colors.amber,
                          border: Border.all(
                              color: Colors.black
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: (){

                            //Add item into db

                            //int totalamnt = quantityitem * int.parse(price);

                            productdb additem = productdb(name: name, price: price,quantity: quantityItem.toString(), brand: brand.toString(),totalprice: "1");
                            List<productdb> listOfUsers = [additem];
                            databasehandler.insertUser(listOfUsers);
                            setState(() {
                              botVisible = false; //hide bottomSheet
                              quantityItem = 1;
                            });

                          },
                          child: Text("Add",style: TextStyle(fontSize: 10,),
                          ),
                        )
                    )
                  ],
                ),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  child: BlocBuilder<Productbloc,itemstate>(
                      builder: (context, state) {
                        if (state is iteminitialstate || state is itemloading) {
                          return _buildLoading();
                        }  else if (state is itemsuccess) {

                          return ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount:state.productModel.length,
                              itemBuilder: (context,index){
                                return Card(
                                  elevation: 8,
                                  shadowColor: Colors.grey,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context).size.width * 0.25,
                                            height: 100.0,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(50),
                                                child: Image.asset('assets/cotton.png',fit: BoxFit.fill,)
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  child: Text("${state.productModel[index].productName}",style: TextStyle(fontSize: 18),),
                                                ),
                                                Container(
                                                  child: Text("Price : ${state.productModel[index].price}",style: TextStyle(fontSize: 15),),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: state.productModel[index].colors!.map((e){
                                                    return  Row(
                                                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Radio(
                                                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                                              fillColor: MaterialStateColor.resolveWith((states) => Colors.black),
                                                              value: 1,
                                                              activeColor: Colors.red,
                                                              groupValue: id,
                                                              onChanged: (val) {
                                                                setState(() {
                                                                  color = e;
                                                                });
                                                              },
                                                            ),
                                                            Text("${e}",
                                                              style: new TextStyle(fontSize: 12,color: Colors.black),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 50,
                                            width: MediaQuery.of(context).size.width *0.70,
                                            margin: EdgeInsets.only(left: 10,bottom: 10),
                                            padding: EdgeInsets.only(top: 5, left: 0, right: 0),
                                            child: DropdownButtonFormField<dynamic>(
                                              dropdownColor: Colors.white,
                                              iconEnabledColor: Colors.black,
                                              decoration: InputDecoration(
                                                focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black)),
                                                enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black)),
                                                errorBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black)),
                                                border: OutlineInputBorder(borderSide: BorderSide(width: 1,color: Colors.black)),
                                                isDense: true,
                                                isCollapsed: true,
                                                hintText: dropdownValue,
                                                contentPadding: EdgeInsets.fromLTRB(8, 12, 8, 12),
                                                labelText: dropdownValue,
                                                hintStyle: TextStyle(color: Colors.black),
                                                labelStyle: TextStyle(color: Colors.black),
                                              ),
                                              items:state.productModel[index].brands?.map((item) {
                                                return new DropdownMenuItem(
                                                  child: Text('${item.name}',style: TextStyle(color: Colors.black),),
                                                  value: item.name,
                                                );
                                              }).toList(),
                                              onChanged: (value){


                                                setState(() {
                                                  brand = value;
                                                });
                                              },
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: (){
                                            if(brand == "no data"){

                                             final snackBar2 = SnackBar(
                                               backgroundColor: Colors.red[900],
                                               content: Text("Please Select Color & Brand !!!",style: TextStyle(color: Colors.yellowAccent),textAlign: TextAlign.center),
                                             );

                                             ScaffoldMessenger.of(context).showSnackBar(snackBar2);

                                           }else{
                                             setState(() {
                                               botVisible = true; //Show bottomSheet
                                               name =  state.productModel[index].productName.toString();
                                               price = state.productModel[index].price.toString();
                                             });
                                           }
                                            

                                            },
                                            child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black
                                                  ),
                                                  borderRadius: BorderRadius.circular(40)
                                                ),
                                                padding: EdgeInsets.all(10),
                                                child: Icon(Icons.add_shopping_cart_rounded)),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });

                        } else if (state is itemerrorpage) {
                          return Container(
                            child: Text(state.erromsz),
                          );
                        } else {
                          return Container();
                        }

                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}

