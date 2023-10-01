import 'package:flutter/material.dart';
import 'package:restart_app/restart_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 6 Git',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Week 6 Git'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool pageFirstLoad = true;
  bool isLoadingItemsFromDatabase = false;
  bool showReset = false;

  List<Customer> customers = [
    Customer("Bobby", "Hill", 101, "Saver"),
    Customer("Peggy", "Hill", 102, "Occasional"),
    Customer("Hank", "Hill", 103, "Spender"),
    Customer("Dale", "Gribble", 104, "Occasional"),
    Customer("Nancy", "Gribble", 105, "Saver"),
    Customer("Joseph", "Gribble", 106, "Frequent"),
    Customer("John", "Redcorn", 107, "Saver"),
    Customer("Bill", "Dauterive", 108, "Spender"),
    Customer("Jeff", "Boomhauer", 109, "Saver"),
    Customer("Luanne", "Platter", 110, "Frequent"),
  ];

  void _handleButtonPress() {
    setState(() {
      pageFirstLoad = false;
      isLoadingItemsFromDatabase = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isLoadingItemsFromDatabase = false;
      });
    });
  }

  void _resetButton() {
    Restart.restartApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
          child: pageFirstLoad
              ? ElevatedButton(
                  onPressed: _handleButtonPress,
                  child: Text("Load Items"),
                )
              : isLoadingItemsFromDatabase
                  ? const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        Text("Please wait")
                      ],
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: customers.map((customer) {
                          return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${customer.FirstName} ${customer.LastName}",
                                    style: TextStyle(fontSize: 20)),
                                Text(
                                    "Customer ID:${customer.CustomerID.toString()}"),
                                Text("Customer Type ${customer.Type}"),
                                Divider(),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _resetButton,
          tooltip: 'Reset',
          child: const Icon(Icons.refresh_outlined),
        ));
  }
}

class Customer {
  String FirstName;
  String LastName;
  int CustomerID;
  String Type;

  Customer(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
