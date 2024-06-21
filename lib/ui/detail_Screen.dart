import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tezda_projects/repository/item_repository/src/model/items.dart';


// }

class DetailScreen extends StatelessWidget {
  final Items item;

  DetailScreen({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title!),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              item.images!.first,
              fit: BoxFit.cover,
              height: 300,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                item!.description!,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
