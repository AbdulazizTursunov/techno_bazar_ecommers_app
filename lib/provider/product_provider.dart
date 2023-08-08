import 'package:flutter/material.dart';
import 'package:untitled10/data/firebase/product_service.dart';
import 'package:untitled10/data/models/category/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled10/data/models/product/product_model.dart';
import '../data/models/universal_data.dart';
import '../utils/ui_utils/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/upload_service.dart';

class ProductProvider with ChangeNotifier {
  ProductProvider({required this.productService});

  final ProductService productService;
  bool isLoading = false;
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDescController = TextEditingController();
  TextEditingController productCountController = TextEditingController();

  List<String> uploadedImagesUrls = [];

  Future<void> addProduct({
    required BuildContext context,
    required String categoryId,
    required String productCurrency,
  }) async {
    String name = productNameController.text;
    String productDesc = productDescController.text;
    String priceText = productPriceController.text;
    String countText = productCountController.text;
    debugPrint("product name ${productNameController.text}");
    debugPrint("product desc ${productDescController.text}");
    debugPrint("product price ${productPriceController.text}");
    debugPrint("product count ${productCountController.text}");
    if (name.isNotEmpty &&
        productDesc.isNotEmpty &&
        priceText.isNotEmpty &&
        countText.isNotEmpty) {
      ProductModel productModel = ProductModel(
          count: int.parse(countText),
          price: int.parse(priceText),
          productImages: uploadedImagesUrls,
          categoryId: categoryId,
          productId: "",
          productName: name,
          description: productDesc,
          createdAt: DateTime.now().toString(),
          currency: productCurrency);

      showLoading(context: context);
      UniversalData universalData =
          await productService.addProduct(productModel: productModel);
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
    } else {
      manageMessage(context, "Maydonlar to'liq emas!!!");
    }
  }

  Future<void> updateProduct({
    required BuildContext context,
    required ProductModel productModel,
    required String productCurrency,
  }) async {
    String name = productNameController.text;
    String productPrice = productPriceController.text;
    String productCount = productCountController.text;
    String productDesc = productDescController.text;

    // if (categoryUrl.isEmpty) categoryUrl = currentCategory.imageUrl;

    if (name.isNotEmpty && productPrice.isNotEmpty) {
      showLoading(context: context);
      UniversalData universalData = await productService.updateProduct(
          productModel: ProductModel(
              count: int.parse(productCount),
              price: int.parse(productPriceController.text),
              productImages: uploadedImagesUrls,
              categoryId: productModel.categoryId,
              productId: productModel.productId,
              productName: name,
              description: productDesc,
              createdAt: DateTime.now().toString(),
              currency: productCurrency));

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

  Future<void> deleteProduct({
    required BuildContext context,
    required String productId,
  }) async {
    showLoading(context: context);
    UniversalData universalData =
        await productService.deleteProduct(productId: productId);
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

  Future<void> uploadProductImageProduct({
    required BuildContext context,
    required List<XFile> productImages,
  }) async {
    showLoading(context: context);

    for (var element in productImages) {
      UniversalData data = await FileUploader.imageUploader(element);
      if (data.error.isEmpty) {
        uploadedImagesUrls.add(data.data as String);
      }
    }
    notifyListeners();

    if (context.mounted) {
      hideLoading(dialogContext: context);
    }
  }

  Stream<List<ProductModel>> getProduct(String categoryId) async* {
    debugPrint("get product");
    if (categoryId.isEmpty) {
      yield* FirebaseFirestore.instance.collection("products").snapshots().map(
          (event) =>
              event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
    } else {
      yield* FirebaseFirestore.instance
          .collection("products")
          .where("categoryId", isEqualTo: categoryId)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => ProductModel.fromJson(e.data())).toList());
    }
  }

  manageMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error)));
    isLoading = false;
    notifyListeners();
  }

  setInitialValues(ProductModel productModel) {
    productNameController =
        TextEditingController(text: productModel.productName);
    productPriceController =
        TextEditingController(text: productModel.price.toString());
    productDescController =
        TextEditingController(text: productModel.description);
    productCountController =
        TextEditingController(text: productModel.count.toString());


    notifyListeners();
  }

  clearTexts() {
    uploadedImagesUrls = [];
    productPriceController.clear();
    productNameController.clear();
    productDescController.clear();
    productCountController.clear();
  }
}
