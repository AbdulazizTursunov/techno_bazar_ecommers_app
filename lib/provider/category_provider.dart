import 'package:flutter/material.dart';
import 'package:untitled10/data/firebase/category_service.dart';
import 'package:untitled10/data/models/category/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/upload_service.dart';

class CategoryProvider with ChangeNotifier {
  CategoryProvider({required this.categoryService});

  final CategoryService categoryService;
  bool isLoading = false;

  TextEditingController categoryNameController = TextEditingController();
  TextEditingController categoryDescController = TextEditingController();
  String categoryUrl = "";




  Future<void> addCategory({required BuildContext context}) async {
    print("provider product add+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
    String name = categoryNameController.text;
    String categoryDesc = categoryDescController.text;
    if (name.isNotEmpty && categoryDesc.isNotEmpty&&categoryUrl.isNotEmpty) {
      CategoryModel categoryModel = CategoryModel(
        categoryId: "",
        categoryName: name,
        description: categoryDesc,
        imageUrl: categoryUrl,
        createdAt: DateTime.now().toString(),
      );
      showLoading(context: context);
      UniversalData universalData =
          await categoryService.addCategory(categoryModel: categoryModel);
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          manageMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
        } else {
          if (context.mounted) {
            manageMessage(context, universalData.error);
          }
        }
      }
    }
  }


  Future<void> updateCategory({
    required BuildContext context,
    required CategoryModel currentCategory,
  }) async {
    String name = categoryNameController.text;
    String categoryDesc = categoryDescController.text;

    if (categoryUrl.isEmpty) categoryUrl = currentCategory.imageUrl;

    if (name.isNotEmpty && categoryDesc.isNotEmpty && categoryUrl.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await categoryService.updateCategory(
          categoryModel: CategoryModel(
            categoryId: currentCategory.categoryId,
            createdAt: currentCategory.createdAt,
            categoryName: categoryNameController.text,
            description: categoryDescController.text,
            imageUrl: categoryUrl,
          ));
      if (context.mounted) {
        hideLoading(dialogContext: context);
      }
      if (universalData.error.isEmpty) {
        if (context.mounted) {
          manageMessage(context, universalData.data as String);
          clearTexts();
          Navigator.pop(context);
          notifyListeners();
        }
      } else {
        if (context.mounted) {
          manageMessage(context, universalData.error);
        }
      }
    }
  }


  Future<void> deleteCategory(
      {required BuildContext context, required String categoryId}) async {
    showLoading(context: context);
    UniversalData universalData =
        await categoryService.deleteCategory(categoryId: categoryId);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (universalData.error.isEmpty) {
      if (context.mounted) {
        manageMessage(context, universalData.data as String);
      } else {
        if (context.mounted) {
          manageMessage(context, universalData.error);
        }
      }
    }
  }


  Future<void> uploadCategoryImage(
      BuildContext context,
      XFile xFile,
      ) async {
    showLoading(context: context);
    UniversalData data = await FileUploader.imageUploader(xFile);
    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
    if (data.error.isEmpty) {
      categoryUrl = data.data as String;
      notifyListeners();
    } else {
      if (context.mounted) {
        manageMessage(context, data.error);
      }
    }
  }


  Stream<List<CategoryModel>> getCategories() => FirebaseFirestore.instance
      .collection("categories")
      .snapshots()
      .map((event) =>
          event.docs.map((e) => CategoryModel.fromJson(e.data())).toList());



  manageMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }

  setInitialValues(CategoryModel categoryModel) {
    categoryNameController =
        TextEditingController(text: categoryModel.categoryName);
    categoryDescController =
        TextEditingController(text: categoryModel.description);
    notifyListeners();
  }

  clearTexts() {
    categoryDescController.clear();
    categoryNameController.clear();
    categoryUrl = "";
  }
}
