import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled10/data/models/category/category_model.dart';
import 'package:untitled10/data/models/universal_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryService {
  Future<UniversalData> addCategory(
      {required CategoryModel categoryModel}) async {
    try {
      DocumentReference newCategory = await FirebaseFirestore.instance
          .collection("categories")
          .add(categoryModel.toJson());

      await FirebaseFirestore.instance
          .collection("categories")
          .doc(newCategory.id)
          .update({"categoryId": newCategory.id});
      return UniversalData(data: "Category added");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateCategory(
      {required CategoryModel categoryModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(categoryModel.categoryId)
          .update(categoryModel.toJson());
      return UniversalData(data: "Category updated");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
  Future<UniversalData> deleteCategory(
      {required String categoryId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("categories")
          .doc(categoryId)
          .delete() ;
      return UniversalData(data: "Category deleted");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
