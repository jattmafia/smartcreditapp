import 'package:flutter/material.dart';
import 'package:smartcredit/config.dart';
import 'package:smartcredit/models/User.dart';
import 'package:smartcredit/navigator.dart';
import 'package:smartcredit/services/HttpService.dart';
import 'package:smartcredit/views/adddriver.dart';
import 'package:smartcredit/views/drivers.dart';
import 'package:smartcredit/views/login.dart';
import 'package:smartcredit/views/search.dart';
import 'package:smartcredit/views/subpages/Stock.dart';
import 'package:smartcredit/views/subpages/doctors.dart';
import 'package:smartcredit/views/subpages/main.dart';
import 'package:smartcredit/views/subpages/medicine.dart';
import 'package:smartcredit/views/subpages/representative.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  final _pageViewController = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: APP_NAME.text.make(),
          actions: [
            IconButton(
              onPressed: () {
                navigateTo(context, SearchScreen());
              },
              icon: Icon(Icons.search),
            ),
            PopupMenuButton(
              offset: Offset(0, 60),
              onSelected: (value) {
                // your logic
              },
              itemBuilder: (BuildContext bc) {
                return const [
                  PopupMenuItem(
                    child: Text("Hello"),
                    value: '/hello',
                  ),
                  PopupMenuItem(
                    child: Text("About"),
                    value: '/about',
                  ),
                  PopupMenuItem(
                    child: Text("Contact"),
                    value: '/contact',
                  )
                ];
              },
            )
          ],
        ),
        drawer: NavigationDrawer(children: [
          UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(storage.read("user")['name'][0]),
              ),
              accountName: Text(storage.read("user")['name']),
              accountEmail: Text(storage.read("user")['phone'])),
          SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                    selected: index == 0,
                    leading: Icon(Icons.home),
                    title: "Home".text.make(),
                    selectedColor: Colors.white,
                    selectedTileColor: Theme.of(context).primaryColor,
                    enableFeedback: true,
                    onTap: () {
                      setState(() {
                        index = 0;
                        _pageViewController.jumpToPage(index);
                      });
                      back(context);
                    }).pOnly(left: 10, right: 10, bottom: 10),
                ListTile(
                  leading: Icon(Icons.medical_services),
                  selected: index == 1,
                  title: "Doctors".text.make(),
                  selectedColor: Colors.white,
                  selectedTileColor: Theme.of(context).primaryColor,
                  onTap: () {
                    setState(() {
                      index = 1;
                      _pageViewController.jumpToPage(index);
                    });
                    back(context);
                  },
                ).pOnly(left: 10, right: 10, bottom: 10),
                ListTile(
                    selected: index == 2,
                    leading: Icon(Icons.medication_liquid_outlined),
                    selectedColor: Colors.white,
                    selectedTileColor: Theme.of(context).primaryColor,
                    title: "Medicines".text.make(),
                    onTap: () {
                      setState(() {
                        index = 2;
                        _pageViewController.jumpToPage(index);
                      });
                      back(context);
                    }).pOnly(left: 10, right: 10, bottom: 10),
                ListTile(
                    selected: index == 3,
                    leading: Icon(Icons.data_thresholding),
                    selectedColor: Colors.white,
                    selectedTileColor: Theme.of(context).primaryColor,
                    title: "Stocks".text.make(),
                    onTap: () {
                      setState(() {
                        index = 3;
                        _pageViewController.jumpToPage(index);
                      });
                      back(context);
                    }).pOnly(left: 10, right: 10, bottom: 10),
                ListTile(
                    selected: index == 4,
                    leading: Icon(Icons.people),
                    title: "Representatives".text.make(),
                    selectedColor: Colors.white,
                    selectedTileColor: Theme.of(context).primaryColor,
                    onTap: () {
                      setState(() {
                        index = 4;
                        _pageViewController.jumpToPage(index);
                      });
                      back(context);
                    }).pOnly(left: 10, right: 10, bottom: 10),

                     ListTile(
                    selected: index == 5,
                    leading: Icon(Icons.bike_scooter),
                    title: "Add Driver".text.make(),
                    selectedColor: Colors.white,
                    selectedTileColor: Theme.of(context).primaryColor,
                    onTap: () {
                      setState(() {
                        index = 5;
                        _pageViewController.jumpToPage(index);
                      });
                      back(context);
                    }).pOnly(left: 10, right: 10, bottom: 10),
              ],
            ),
          ),
          Spacer(),
          FilledButton(
                  style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)))),
                  onPressed: () {
                    storage.write("user", "");
                    storage.write("isLoggedIn", false);
                    storage.write("id", "");
                    replaceTo(context, LoginScreen());
                  },
                  child: "Logout".text.make())
              .p(20)
        ]),
        body: PageView(
          controller: _pageViewController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            MainScreen(),
            DoctorScreen(),
            MedicineScreen(),
            StockScreen(),
            RepresentativeScreen(),
           AddDriver(),
          ],
        ));
  }
}
