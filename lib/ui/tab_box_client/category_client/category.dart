import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/data/models/category/category_model.dart';
import 'package:untitled10/provider/category_provider.dart';
import 'package:untitled10/ui/tab_box_admin/category/category_details/categorie_detail.dart';
import '../../../utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widget/shimmer_photo.dart';

class CategoryScreenClient extends StatelessWidget {
  const CategoryScreenClient({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text("category screen admin",),
        centerTitle: true,
      ),
      body: StreamBuilder<List<CategoryModel>>(
        stream: context.read<CategoryProvider>().getCategories(),
        builder: (BuildContext context,
            AsyncSnapshot<List<CategoryModel>> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!.isNotEmpty
                ? ListView(
              children: List.generate(snapshot.data!.length, (index) {
                CategoryModel categoryModel = snapshot.data![index];
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.c_C4C5C4,
                    border:
                    Border.all(width: 1.0, color: AppColors.c_3669C9),),
                  child: ListTile(
                    leading: CachedNetworkImage(
                        imageUrl: categoryModel.imageUrl,
                        placeholder: (context, url) =>
                        const ShimmerPhoto(),
                        errorWidget: (context, url, error) =>
                         const   Icon(Icons.error,
                                color: Colors.red),
                        width: 80.w,
                        height: 100.h,
                        fit: BoxFit.cover),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryDetail(productId:categoryModel.categoryId ),));
                    },
                    title: Text(
                      categoryModel.categoryName,
                      style: const TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(
                      categoryModel.description,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }),
            )
                : const Center(
              child: Text("empty category"),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.yellow,
              ),
            );
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
