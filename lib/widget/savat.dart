
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/models/order/order_model.dart';
import '../data/models/product/product_model.dart';
import '../provider/auth_provider.dart';
import '../provider/order_provider.dart';

class SavatButton extends StatefulWidget {
  SavatButton({super.key, required this.productModel});
  ProductModel productModel;

  @override
  State<SavatButton> createState() => _SavatButtonState();
}

class _SavatButtonState extends State<SavatButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
          onPressed: () {
             // You can change this to the desired quantity
          int TotalPrice = context.read<OrderProvider>().newCount * widget.productModel.price;
            context.read<OrderProvider>().addOrders(
                context: context,
                orderModel: OrderModel(
                    count: context.read<OrderProvider>().newCount,
                    price: widget.productModel.price,
                    totalPrice: TotalPrice,
                    orderId: '',
                    productId: widget.productModel.productId,
                    userId: context.read<AuthProvider>().user!.uid,
                    orderStatus: "waiting",
                    createdAt: DateTime.now().toString(),
                    productName: widget.productModel.productName));
          },
          child: const Text("Add to Cart")),
    );
  }
}
