import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stripe/providers/cartchangenotifier.dart';
import 'package:stripe/services/stripepaymentservice.dart';

class CheckOutBottomNav extends ConsumerWidget {
  const CheckOutBottomNav({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    StripePaymentService _paymentService=StripePaymentService();
    final cartProvider=ref.watch(cartNotifierProvider);
    return cartProvider.isNotEmpty? GestureDetector(
      onTap: (){
        _paymentService.makePayment(context, cartProvider.fold<double>(0, (sum, item) => sum+item.new_price));
        cartProvider.clear();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(20)
          ),
          child: Padding(
                            padding:const EdgeInsets.all(8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total:\$${cartProvider.fold<double>(0, (sum, item) => sum+item.new_price)}",
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const Text(
                                  "Proceed To CheckOut",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
        ),
      ),
    ):SizedBox();
  }
}