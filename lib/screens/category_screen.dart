import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_online2/datas/product_data.dart';
import 'package:loja_online2/tiles/product_tile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text(snapshot.data["title"]),
            centerTitle: true,
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.grid_on)),
                Tab(icon: Icon(Icons.list)),
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("products")
                  .document(snapshot.documentID)
                  .collection("items")
                  .getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      GridView.builder(
                        padding: EdgeInsets.all(4.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          crossAxisCount: 2,
                          childAspectRatio: 0.65,
                        ),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return ProductTile(
                              "grid",
                              ProductData.fromDocument(
                                  snapshot.data.documents[index]));
                        },
                      ),
                      ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        padding: EdgeInsets.all(4.0),
                        itemBuilder: (context, index) {
                          return ProductTile(
                              "list",
                              ProductData.fromDocument(
                                  snapshot.data.documents[index]));
                        },
                      ),
                    ],
                  );
                }
              })),
    );
  }
}
