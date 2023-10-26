import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stripe/data/fakedata.dart';
import 'package:stripe/pages/cartpage.dart';
import 'package:stripe/providers/cartchangenotifier.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final cartNotifier=ref.watch(cartNotifierProvider);
    return Scaffold(appBar: AppBar(elevation: 0,
    backgroundColor: Colors.white,
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
        },child: Row(
          children: [
           const Icon(Icons.shopping_basket),
            Text(cartNotifier.length.toString())
          ],
        )),
      )
    ],),
    body: SafeArea(child: 
    SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: GridView.builder(gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
      childAspectRatio: 2/3,mainAxisSpacing: 2),shrinkWrap: true,itemCount: FakeData.products.length, itemBuilder: (context,index){
        final products=FakeData.products[index];
        return Padding(padding: const EdgeInsets.all(8),
        child: Card(
          elevation: 2,
          child: Stack(children: [
          Container(
            height: 280,
            width: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                Image.asset(products.image,height: 120,
                width: double.infinity,),
                Text(products.name,style:const TextStyle(fontSize: 15,color: Colors.black),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                Text("\$${products.new_price}",style: const TextStyle(fontSize: 15,color: Colors.black),),
                Text("\$${products.old_price}",style: const TextStyle(fontSize: 15,color: Colors.black,decoration: TextDecoration.lineThrough),)
                    ],
                  ),
                )
              ],
            ),
          ),
           GestureDetector(
            onTap: (){
              ref.read(cartNotifierProvider.notifier).addToCart(products);
            },
             child: Positioned(right: 0,child: Row(children: [
             const Icon(Icons.shopping_bag_outlined,color: Colors.orange,),
              Text(cartNotifier.length.toString(),
              style:const TextStyle(color: Colors.black),)
                     ],)),
           )
          ]),
        ),);
      }),
    )),);
  }
}