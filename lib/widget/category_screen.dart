// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:untitled10/data/models/category/category_model.dart';
// import 'package:untitled10/provider/category_provider.dart';
// import '../../../utils/app_colors.dart';
// import 'categories_sub_screen/add_categories.dart';
//
// class CategoryScreenAdmin extends StatelessWidget {
//   const CategoryScreenAdmin({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => CategoryAddScreen(),
//                   ));
//             },
//             icon: const Icon(
//               Icons.add,
//               size: 30,
//             ),
//           )
//         ],
//         title: Text(
//           "category screen admin",
//           style: Theme.of(context).textTheme.labelMedium,
//         ),
//         centerTitle: true,
//       ),
//       body: StreamBuilder<List<CategoryModel>>(
//         stream: context.read<CategoryProvider>().getCategories(),
//         builder: (BuildContext context,
//             AsyncSnapshot<List<CategoryModel>> snapshot) {
//           if (snapshot.hasData) {
//             return snapshot.data!.isNotEmpty
//                 ? Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(16),
//                         border:
//                             Border.all(width: 1.0, color: AppColors.c_838589),),
//                     child: ListView(
//                       children: List.generate(snapshot.data!.length, (index) {
//                         CategoryModel categoryModel = snapshot.data![index];
//                         return ListTile(
//                           trailing: IconButton(
//                             onPressed: () {
//                               Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                   builder: (context) => CategoryAddScreen(
//                                     categoryModel: categoryModel,
//                                   ),
//                                 ),
//                               );
//                             },
//                             icon:const Icon(Icons.edit,size: 30,),
//                           ),
//                           onLongPress: () {
//                             context.read<CategoryProvider>().deleteCategory(
//                                 context: context,
//                                 categoryId: categoryModel.categoryId);
//                           },
//                           leading: Container(
//                             width: 50,
//                             decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.black)),
//                             child: Image.network(
//                               categoryModel.imageUrl,
//                               width: 80,
//                               height: 50,
//                             ),
//                           ),
//                           title: Text(
//                             categoryModel.categoryName,
//                             style: Theme.of(context).textTheme.labelSmall,
//                           ),
//                           subtitle: Text(
//                             categoryModel.description,
//                             style: Theme.of(context).textTheme.labelSmall,
//                           ),
//                         );
//                       }),
//                     ),
//                   )
//                 : const Center(
//                     child: Text("empty category"),
//                   );
//           }
//
//           if (snapshot.hasError) {
//             return const Center(
//               child: CircularProgressIndicator(
//                 color: Colors.yellow,
//               ),
//             );
//           }
//           return const Center(
//             child: CircularProgressIndicator(
//               color: Colors.red,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
