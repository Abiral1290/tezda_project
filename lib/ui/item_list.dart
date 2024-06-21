import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tezda_projects/controller/preference_controller.dart';
import 'package:tezda_projects/provider/item_provider.dart';
import 'package:tezda_projects/ui/login_page.dart';
import 'package:tezda_projects/utilities/generate_route.dart';

import 'detail_Screen.dart';




class ItemList extends StatefulWidget {
  const ItemList({super.key});

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {

  late PreferenceController preferenceController = PreferenceController();

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() =>
        context.read<ItemProvider>().fetchItems()
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: ()async{
        await context.read<FavouriteItemProvider>().fetchFavouriteItems();
        Navigator.pushNamed(context, GeneratedRoutes.itemFavouriteList);
      },
        child: 
          const  Icon(
              Icons.favorite ,
              color: Colors.red ,
            ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              icon: const Icon(
              Icons.logout,
              ),
              onPressed: ()async{
                Navigator.pushNamed(context, GeneratedRoutes.home);
                await PreferenceController.sharedPreferences.clear();


              },
          ),
        ],
      ),
      body: Consumer<ItemProvider>(builder: (context,provider, child){
        return provider.item == null? Center(child: const CircularProgressIndicator()):ListView.builder(
          itemCount: provider.item!.length,
            itemBuilder: (context, view){
          return GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(item: provider.item![view]),
                ),
              );
            },
            child: ProfileCard(imageUrl: provider.item![view].images!,
                name: provider.item![view].title!,favourite:  provider.myBool[view],onPressed: ()async{

                  provider.myBool[view] = true;
               //   int num =PreferenceController.sharedPreferences.getStringList("favourites")!.length;
            await preferenceController.saveItems(provider.item![view]);
              provider.myBoolean(true,view);


                }),
          );
        });
      },)
    );
  }

}

class ProfileCard extends StatelessWidget {
  final List imageUrl;
  final String name;
   final bool favourite;
  final VoidCallback onPressed;
  ProfileCard({required this.imageUrl, required this.name,required this.favourite,
    required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
            child: Image.network(
              imageUrl.first,
              width: 300,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      favourite ? Icons.favorite : Icons.favorite_border,
                      color: favourite ? Colors.red : null,
                    ),
                    onPressed: onPressed
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}