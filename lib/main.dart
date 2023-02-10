import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/Bloc-event-state.dart';
import 'Screens/CartScreen.dart';
import 'Screens/ProductList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => Productbloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demoddd ',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          'Cartpage':(context) => CartScreen(),
          'homepage':(context) => Productlist()
        },
        home: const Productlist(),
      ),
    );
  }
}
