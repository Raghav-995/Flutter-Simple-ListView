import 'dart:convert';
import 'card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class ProductListScreen extends StatefulWidget {
@override
_ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> with TickerProviderStateMixin{
List<Product> products = [];
 late final TabController _tabController;

@override
void initState() {
	super.initState();
	fetchProducts();
	_tabController = TabController(length: 2, vsync: this);
}
 @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
 

Future<void> fetchProducts() async {
	// you can replace your api link with this link
	final response = await http.get(Uri.parse('https://fakestoreapi.com/products'));
	if (response.statusCode == 200) {
	List<dynamic> jsonData = json.decode(response.body);
	setState(() {
		products = jsonData.map((data) => Product.fromJson(data)).toList();
	});
	} else {
	// Handle error if needed
	}
}

@override
Widget build(BuildContext context) {
	return Scaffold(
	appBar: AppBar(
		title: Text("Flutter Simple Apis",style:TextStyle(fontFamily: 'Pacifico',package:'Pacifico-Regular.ttf')),
		actions: [
    const Tooltip(
              message: "add to favorite",
              child: Icon(
                Icons.favorite,
              ),),
    Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      const Tooltip(
              message: "Search a Item",
              child: Icon(
                Icons.search,
              ),),
    ),
   PopupMenuButton(
          // add icon, by default "3 dot" icon
          icon: Icon(Icons.settings),
          itemBuilder: (context){
            return [
                  PopupMenuItem<int>(
                      value: 0,
                      child: Text("My Account",style:TextStyle(fontFamily: 'Poppins',package:'Poppins-Medium.ttf')),
                  ),

                  PopupMenuItem<int>(
                      value: 1,
                      child: Text("Settings",style:TextStyle(fontFamily: 'Poppins',package:'Poppins-Medium.ttf')),
                  ),

                  PopupMenuItem<int>(
                      value: 2,
                      child: Text("Logout",style:TextStyle(fontFamily: 'Poppins',package:'Poppins-Medium.ttf')),
                  ),
              ];
          },),
  ],
  backgroundColor: Colors.redAccent,
 
),

drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.pink),
                accountName: Text(
                  "Raghav",
                  style: TextStyle(fontSize: 18,),
                ),
                accountEmail: Text("raghav@gmail.com"),
                currentAccountPictureSize: Size.square(45),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 165, 255, 137),
                  child: Text(
                    "A",
                    style: TextStyle(fontSize: 30.0, color: Colors.blue),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Library '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Go Premium '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Saved Videos '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ), //Drawer

	
	  body:Column(
		
 children: <Widget>[
        TabBar.secondary(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(text: 'ListView'),
            Tab(text: 'GridView'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
             ListView.builder(
        // this give th length of item
        itemCount: products.length, 
        itemBuilder: (context, index) {
          // here we card the card widget 
          // which is in utils folder
          return ProductCard(product: products[index]); 
        },
      ),
             GridView.builder(
        // this give th length of item
        itemCount: products.length, 
	gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(  
                  crossAxisCount: 2,  
                  crossAxisSpacing: 60,  
                  mainAxisSpacing: 60, 
              ),  
        itemBuilder: (context, index) {
          // here we card the card widget 
          // which is in utils folder
          return ProductCard(product: products[index]); 
        },
      ),
            ],
          ),
        ),
      ],
),
    );
  }
}
