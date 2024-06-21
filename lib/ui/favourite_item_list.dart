import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezda_projects/provider/item_provider.dart';

import 'item_list.dart';

class FavouriteItemList extends StatefulWidget {
  const FavouriteItemList({super.key});

  @override
  State<FavouriteItemList> createState() => _FavouriteItemListState();
}

class _FavouriteItemListState extends State<FavouriteItemList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<FavouriteItemProvider>(builder: (context,provider, child){
        return provider.items == null? const Center(child: const CircularProgressIndicator()):ListView.builder(
            itemCount: provider.items!.length,
            itemBuilder: (context, view){
              return ProfileCard(imageUrl: provider.items![view].images!,
                  name: provider.items![view].title!,favourite: false,onPressed: (){});
            });
      },),
    );
  }
}
