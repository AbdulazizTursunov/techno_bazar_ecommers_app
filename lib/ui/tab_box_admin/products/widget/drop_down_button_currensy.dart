import 'package:flutter/material.dart';

import '../sub_screen_product/add_products.dart';

class CurrencyDropDown extends StatefulWidget {
  const CurrencyDropDown({Key? key}) : super(key: key);


  @override
  State<CurrencyDropDown> createState() => _CurrencyDropDownState();
}

class _CurrencyDropDownState extends State<CurrencyDropDown> {
  String selectCurrency = 'UZS';

  var currency = [
    'UZS',
    'USD',
    'RUB',
  ];
 @override
  void initState() {
   setState(() {
     ProductAddScreen.selectedCurrency = selectCurrency;
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      // Initial Value
      value: selectCurrency,

      // Down Arrow Icon
      icon: const Icon(Icons.keyboard_arrow_down),
      items: currency.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: (String? newValue) {
        setState(() {
          selectCurrency  = newValue!;
        });
      },
    );
  }
}
// SizedBox(
// height: 150,
// child: TextButton(
// onPressed: () {
// showBottomSheetDialog();
// },
// style: TextButton.styleFrom(
// backgroundColor: Theme.of(context).indicatorColor),
// child: context
//     .watch<CategoryProvider>()
//     .categoryUrl
//     .isEmpty
// ? const Text(
// "Select Image",
// style: TextStyle(color: Colors.black),
// maxLines: 1,
// overflow: TextOverflow.ellipsis,
// )
//     : SizedBox(
// height: 100,
// child: ListView(
// scrollDirection: Axis.horizontal,
// children: [
// ...List.generate(
// context
//     .watch<ProductProvider>()
//     .uploadedImagesUrls
//     .length, (index) {
// String singleImage = context
//     .watch<ProductProvider>()
//     .uploadedImagesUrls[index];
// return Container(
// padding: const EdgeInsets.all(5),
// margin: const EdgeInsets.all(5),
// decoration: BoxDecoration(
// borderRadius: BorderRadius.circular(12),
// ),
// child: Image.network(
// singleImage,
// width: 80,
// height: 80,
// fit: BoxFit.fill,
// ),
// );
// })
// ],
// ),
// ),
// ),
// ),