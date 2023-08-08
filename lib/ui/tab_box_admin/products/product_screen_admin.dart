import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/data/models/product/product_model.dart';
import 'package:untitled10/provider/product_provider.dart';
import 'package:untitled10/ui/tab_box_admin/products/sub_screen_product/add_products.dart';
import 'package:untitled10/ui/tab_box_admin/products/widget/selected_category_name.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../widget/global_like_button.dart';
import '../../../widget/shimmer_photo.dart';

class ProductScreenAdmin extends StatefulWidget {
  const ProductScreenAdmin({Key? key}) : super(key: key);

  @override
  State<ProductScreenAdmin> createState() => _ProductScreenAdminState();
}

class _ProductScreenAdminState extends State<ProductScreenAdmin> {
  @override
  Widget build(BuildContext context) {
    print(
        "==================================================product admin screen=========================================================");
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductAddScreen(),
                    ));
              },
              icon: Icon(Icons.add))
        ],
        title: Text("product screen admin"),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: context.read<ProductProvider>().getProduct(""),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? Column(
                  children: [
                    SelectedCategoryNameInProduct(),
                    Expanded(
                      child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio:0.58,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, int index) {
                            ProductModel productModel = snapshot.data![index];
                            return ZoomTapAnimation(
                              onTap: (){
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetail(productId:categoryModel.categoryId),));
                              },
                              child: Container(
                                // padding: EdgeInsets.all(5.h),
                                margin: EdgeInsets.all(5.h),
                                decoration: BoxDecoration(
                                  color: AppColors.c_FDA429, //Colors.yellow,
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ...List.generate(
                                          productModel.productImages.length,
                                          (index) => Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(20),
                                              child: SizedBox(
                                                width: MediaQuery.of(context).size.width/1,
                                                height: 230.h,
                                                child: CachedNetworkImage(
                                                    imageUrl: productModel
                                                        .productImages[index],
                                                    placeholder: (context, url) =>
                                                        const ShimmerPhoto(),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            const Icon(Icons.error,
                                                                color: Colors.red),
                                                    fit: BoxFit.fill),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const Positioned(
                                            right: 0,
                                            top: 0,
                                            child: GlobalLikeButton()),
                                      ],
                                    ),
                                    Text(
                                      productModel.productName,
                                      style: Theme.of(context).textTheme.titleLarge,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5,right: 3),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${(productModel.price).toString()} ||  ",
                                            style:
                                                Theme.of(context).textTheme.labelMedium,
                                          ),
                                          Container(
                                              height: 20.h,
                                              width: 50.w,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: AppColors.c_838589),
                                              child: Center(
                                                  child: Text(
                                                productModel.currency.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )))
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5,right: 3),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${(productModel.createdAt.toString()).substring(0, 16)} ||  ",
                                            style:
                                                Theme.of(context).textTheme.labelMedium,
                                          ),
                                          Container(
                                              height: 20.h,
                                              width: 40.w,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  color: AppColors.c_838589),
                                              child: Center(
                                                  child: Text(
                                                productModel.count.toString(),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              )))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                )
                : const Center(
                    child: Text(" products empty"),
                  );
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          );
        },
      ),
    );
  }
}
