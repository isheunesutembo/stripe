import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stripe/providers/cartchangenotifier.dart';
import 'package:stripe/services/stripepaymentservice.dart';
import 'package:stripe/widgets/check_out_bottom_nav.dart';

class CartPage extends ConsumerWidget {
  
  const CartPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    final cartProvider=ref.watch(cartNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(elevation: 0,
      backgroundColor: Colors.white,),
      bottomNavigationBar:const CheckOutBottomNav(),
      body: SafeArea(child: 
      SingleChildScrollView(child: 
      Expanded(child: Column(children: [
        ListView.builder(shrinkWrap: true,
        physics:const BouncingScrollPhysics(),
        itemCount: cartProvider.length,itemBuilder: (context,index){
          final cartItems=cartProvider[index];
   return Padding(padding: const  EdgeInsets.all(8),
   child: Container(
    height: 120,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      
    ),
    child: Row(children: [
      Image.asset(cartItems.image,height: 120,),
      Expanded(child: 
      Column(children: [
        const SizedBox(height: 16,),
        Text(cartItems.name,
        style:const TextStyle(fontWeight: FontWeight.w500),),
        const SizedBox(height: 16,),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
          Text("\$${cartItems.new_price}"),
          Text("\$${cartItems.old_price}",style:const TextStyle(
            decoration: TextDecoration.lineThrough,
            color: Colors.black
          ),)

        ],),
        const SizedBox(height: 16,),
        GestureDetector(
          onTap: (){
ref.read(cartNotifierProvider.notifier).deleteCartItem(cartItems.productId);
          },
          child:const Icon(Icons.delete),
        )
      ],))
    ]),
   ),);
        }),
      
      ],)),)),
    );
  }
}