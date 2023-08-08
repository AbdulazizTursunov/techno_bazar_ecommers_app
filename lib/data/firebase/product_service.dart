import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled10/data/models/category/category_model.dart';
import 'package:untitled10/data/models/product/product_model.dart';
import 'package:untitled10/data/models/universal_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductService {
  Future<UniversalData> addProduct(
      {required ProductModel productModel}) async {
    try {
      DocumentReference newProduct = await FirebaseFirestore.instance
          .collection("products")
          .add(productModel.toJson());
      await FirebaseFirestore.instance
          .collection("products")
          .doc(newProduct.id)
          .update({"productId": newProduct.id});
      return UniversalData(data: "Product added");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }

  Future<UniversalData> updateProduct(
      {required ProductModel productModel}) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productModel.productId)
          .update(productModel.toJson());
      return UniversalData(data: "Products updated");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
  Future<UniversalData> deleteProduct(
      {required String productId}) async {
    try {
      await FirebaseFirestore.instance
          .collection("products")
          .doc(productId)
          .delete() ;
      return UniversalData(data: "Product deleted");
    } on FirebaseAuthException catch (e) {
      return UniversalData(error: e.code);
    } catch (error) {
      return UniversalData(error: error.toString());
    }
  }
}
