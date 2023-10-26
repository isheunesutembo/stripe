
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/product.dart';
final cartNotifierProvider=StateNotifierProvider.autoDispose<CartNotifier,List<Product>>((ref)=>CartNotifier());
class CartNotifier extends StateNotifier<List<Product>>{
  CartNotifier():super([]);
  final List<Product>cart=[];
  void addToCart(Product product){ state=[...state,product];}
  void deleteCartItem(int productId){
    state=[for (final product in state)if(productId !=product.productId)product];
  }
  }
