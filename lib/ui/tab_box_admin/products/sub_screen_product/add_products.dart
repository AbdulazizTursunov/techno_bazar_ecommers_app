import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:untitled10/data/models/product/product_model.dart';
import 'package:untitled10/provider/product_provider.dart';
import 'package:untitled10/ui/tab_box_admin/products/widget/selected_category_name.dart';
import '../../../../widget/global_button.dart';
import '../widget/drop_down_button_currensy.dart';

class ProductAddScreen extends StatefulWidget {
  ProductAddScreen({super.key, this.productModel});

  ProductModel? productModel;
  static String selectedCurrency = '';
  static String selectedCategoryId = '';

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  ImagePicker picker = ImagePicker();

  String currency = "";

  @override
  void initState() {
    if (widget.productModel != null) {
      context.read<ProductProvider>().setInitialValues(widget.productModel!);
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    print("product model ================================================================${widget.productModel}");
    return WillPopScope(
      onWillPop: () async {
        Provider.of<ProductProvider>(context, listen: false).clearTexts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
              widget.productModel == null ? "Product Add" : "Product  Update"),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Provider.of<ProductProvider>(context, listen: false).clearTexts();
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  TextField(
                      decoration: InputDecoration(
                        hintText: "Product Name",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<ProductProvider>()
                          .productNameController),
                  const SizedBox(height: 24),
                  SizedBox(
                    height: 150,
                    child: TextField(
                      maxLines: 100,
                        decoration: InputDecoration(
                          hintText: "Product Description",
                        ),
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                        controller: context
                            .read<ProductProvider>()
                            .productDescController),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                      decoration: InputDecoration(
                        hintText: "Product Price",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<ProductProvider>()
                          .productPriceController),
                  const SizedBox(height: 24),
                  TextField(
                      decoration: InputDecoration(
                        hintText: "Product Count",
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                      controller: context
                          .read<ProductProvider>()
                          .productCountController),
                  const SizedBox(height: 24),
                  CurrencyDropDown(),
                  const SizedBox(height: 24),
                  SelectedCategoryNameInProduct( ),
                  const SizedBox(height: 24),
                  context.watch<ProductProvider>().uploadedImagesUrls.isEmpty
                      ? TextButton(
                    onPressed: () {
                      showBottomSheetDialog();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor:
                        Theme.of(context).indicatorColor),
                    child: const Text(
                      "Select Image",
                      style: TextStyle(color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                      : SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...List.generate(
                            context
                                .watch<ProductProvider>()
                                .uploadedImagesUrls
                                .length, (index) {
                          String singleImage = context
                              .watch<ProductProvider>()
                              .uploadedImagesUrls[index];
                          return Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Image.network(
                              singleImage,
                              width: 80,
                              height: 80,
                              fit: BoxFit.fill,
                            ),
                          );
                        })
                      ],
                    ),
                  ),


                  Visibility(
                    visible: context.watch<ProductProvider>().uploadedImagesUrls.isNotEmpty,
                    child: TextButton(
                      onPressed: () {
                        showBottomSheetDialog();
                      },
                      style: TextButton.styleFrom(
                          backgroundColor:
                          Theme.of(context).indicatorColor),
                      child: const Text(
                        "Select Image",
                        style: TextStyle(color: Colors.black),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GlobalButton(
                title: widget.productModel == null
                    ? "Add product"
                    : "Update product",
                onTap: () {
                  debugPrint(context
                      .read<ProductProvider>()
                      .productCountController.text);
                  debugPrint(context
                      .read<ProductProvider>()
                      .productDescController.text);
                  debugPrint(context
                      .read<ProductProvider>()
                      .productPriceController.text);
                  debugPrint(context
                      .read<ProductProvider>()
                      .productNameController.text);
                  debugPrint(ProductAddScreen.selectedCurrency.toString());
                  debugPrint(ProductAddScreen.selectedCategoryId.toString());


                  if (context
                      .read<ProductProvider>()
                      .uploadedImagesUrls
                      .isNotEmpty &&
                      ProductAddScreen.selectedCategoryId.isNotEmpty) {
                    context.read<ProductProvider>().addProduct(
                      context: context,
                      categoryId: ProductAddScreen.selectedCategoryId,
                      productCurrency: ProductAddScreen.selectedCurrency,
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(milliseconds: 500),
                        backgroundColor: Colors.black,
                        margin: EdgeInsets.symmetric(
                          vertical: 100,
                          horizontal: 20,
                        ),
                        behavior: SnackBarBehavior.floating,
                        content: Text(
                          "Ma'lumotlar to'liq emas!!!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    );
                  }
                }),
          ],
        ),
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration:const BoxDecoration(
            color: Color(0xff162023),
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromGallery() async {
    List<XFile> xFiles = await picker.pickMultiImage(
      maxHeight: 512,
      maxWidth: 512,
    );
    await Provider.of<ProductProvider>(context, listen: false)
        .uploadProductImageProduct(
      context: context,
     productImages:  xFiles,
    );
  }
}
