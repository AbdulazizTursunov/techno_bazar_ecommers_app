
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/models/order/order_model.dart';
import '../../../provider/auth_provider.dart';
import '../../../provider/order_provider.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<List<OrderModel>>(
                  stream: context
                      .read<OrderProvider>()
                      .getOrdersByID(context.read<AuthProvider>().user!.uid),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    } else if (snapshot.hasData) {
                      List<OrderModel> a = snapshot.data;

                      return ListView.builder(
                        itemCount: a.length,
                        itemBuilder: (BuildContext context, int index) {
                          OrderModel x = a[index];

                          return Container(
                            color: Colors.amber,
                            margin: const EdgeInsets.all(12),
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      x.productName,
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      x.totalPrice.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        if (x.count >= 1) {
                                          int totalPrice =
                                              x.totalPrice - x.price;

                                          context
                                              .read<OrderProvider>()
                                              .updateOrders(
                                                  context: context,
                                                  orderModel: OrderModel(
                                                      count: x.count - 1,
                                                      price: x.price,
                                                      totalPrice: totalPrice,
                                                      orderId: x.orderId,
                                                      productId: x.productId,
                                                      userId: context
                                                          .read<AuthProvider>()
                                                          .user!
                                                          .uid,
                                                      orderStatus:
                                                          x.orderStatus,
                                                      createdAt: DateTime.now()
                                                          .toString(),
                                                      productName:
                                                          x.productName));
                                        }
                                      },
                                      child: const Text(
                                        '-',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Text(
                                      x.count.toString(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        int TotalPrice = x.totalPrice + x.price;
                                        context
                                            .read<OrderProvider>()
                                            .updateOrders(
                                                context: context,
                                                orderModel: OrderModel(
                                                    count: x.count + 1,
                                                    price: x.price,
                                                    totalPrice: TotalPrice,
                                                    orderId: x.orderId,
                                                    productId: x.productId,
                                                    userId: context
                                                        .read<AuthProvider>()
                                                        .user!
                                                        .uid,
                                                    orderStatus: x.orderStatus,
                                                    createdAt: DateTime.now()
                                                        .toString(),
                                                    productName:
                                                        x.productName));
                                      },
                                      child: const Text(
                                        '+',
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context
                                              .read<OrderProvider>()
                                              .deleteProducts(
                                                  context: context,
                                                  orderId: x.orderId);
                                        },
                                        icon: Icon(Icons.delete))
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }
                    return const Center();
                  },
                ),
              ),

            ],
          ),
        ));
  }
}


//  Expanded(child: StreamBuilder(
//  stream: context.read<OrderProvider>().getOrders(),
//
//  builder: (BuildContext context, AsyncSnapshot snapshot) {
//     if (snapshot.hasError) {
//           return Text(snapshot.error.toString());
//         } else if (snapshot.hasData) {
//           List<OrderModel> a = snapshot.data;
//
//           return ListView.builder(
//             itemCount: a.length,
//             itemBuilder: (BuildContext context, int index) {
//               OrderModel orderModel = a[index];
//
//               return Container(
//                 color: Colors.amber,
//                 margin: const EdgeInsets.all(12),
//                 padding: const EdgeInsets.all(12),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       children: [
//                         Text(
//                           orderModel.productName,
//                           style: const TextStyle(fontSize: 20),
//                         ),
//                         Text(
//                           orderModel.totalPrice.toString(),
//                           style: const TextStyle(fontSize: 20),
//                         ),
//                       ],
//                     ),
//                     // Row(
//                     //   children: [
//                     //     IconButton(
//                     //         onPressed: () {
//                     //           context
//                     //               .read<OrderProvider>()
//                     //               .deleteProducts(
//                     //                   context: context,
//                     //                   orderId: orderModel.orderId);
//                     //         },
//                     //         icon: Icon(Icons.delete))
//                     //   ],
//                     // )
//                   ],
//                 ),
//               );
//             },
//           );
//         }
//         return const Center();
//  },
// ),)