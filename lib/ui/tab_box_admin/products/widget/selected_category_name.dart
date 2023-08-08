import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

import '../../../../data/models/category/category_model.dart';
import '../../../../provider/category_provider.dart';
import '../sub_screen_product/add_products.dart';

class SelectedCategoryNameInProduct extends StatefulWidget {
 const  SelectedCategoryNameInProduct({Key? key}) : super(key: key);



  @override
  State<SelectedCategoryNameInProduct> createState() =>
      _SelectedCategoryNameInProductState();
}

class _SelectedCategoryNameInProductState
    extends State<SelectedCategoryNameInProduct> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasError) {
            return  Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? SizedBox(
                    height: 60,
                    child: ListView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(snapshot.data!.length, (index) {
                          CategoryModel categoryModel = snapshot.data![index];
                          return ZoomTapAnimation(
                            onTap: () {
                              setState(() {

                                ProductAddScreen.selectedCategoryId = categoryModel.categoryId;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: ProductAddScreen.selectedCategoryId ==
                                          categoryModel.categoryId
                                      ? Colors.green
                                      : Colors.white24,
                                  border: Border.all(
                                      color: Color(0xff111015), width: 1.0),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Center(
                                child: Text(
                                  categoryModel.categoryName,
                                  style: TextStyle( color: ProductAddScreen.selectedCategoryId==
                                      categoryModel.categoryId
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  )
                :  const Center(child: Text("Empty!"));
          }
          return CircularProgressIndicator();
        });
  }
}
