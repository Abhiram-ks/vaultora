import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/Color/colors.dart';
import 'package:vaultora_inventory_app/db/helpers/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sales/onsale.dart';
import '../../../db/helpers/addfunction.dart';
import '../../../db/models/product/add.dart';
import '../../common/appbar.dart';
import '../../common/snackbar.dart';
import '../../records/sales/subfiles_sales/actions_sale.dart';
import '../../records/sales/subfiles_sales/decoration_list_view.dart';
import '../../records/sales/subfiles_sales/mutiplefilessub.dart';
import '../../records/sales/subfiles_sales/serch_sale.dart';
import '../../records/sales/subfiles_sales/snackbar.dart';

class MultipleSales extends StatefulWidget {
  final void Function(AddModel, double)? onAdd;
  final Map<AddModel, double> temporaryStock;

  const MultipleSales({
    super.key,required this.onAdd, required this.temporaryStock,
  });

  @override
  State<MultipleSales> createState() => _MultipleSalesState();
}

class _MultipleSalesState extends State<MultipleSales> {
  TextEditingController searchController = TextEditingController();
  List<AddModel> filteredList = [];
  int? selectedProductIndex;
  ValueNotifier<int> stockLevel = ValueNotifier<int>(0);
  ValueNotifier<String> checkoutText = ValueNotifier<String>('₹ 0.00');
  ValueNotifier<double> quantityNotifier = ValueNotifier<double>(0);
  int count = 0;
  AddModel? selectedProduct;

  @override
  void initState() {
    super.initState();
    filteredList = addListNotifier.value;
   
  }
  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList = addListNotifier.value;
        selectedProductIndex = null;
        stockLevel.value = 0;
      });
    } else {
      setState(() {
        filteredList = addListNotifier.value
            .where((item) =>
                item.itemName.toLowerCase().contains(query.toLowerCase()))
            .toList();
        selectedProductIndex = null;
        stockLevel.value = 0;
      });
    }}
void handleProductClick(int index) {
  setState(() {
    selectedProductIndex = index;
    selectedProduct = filteredList[index];
      if (selectedProduct != null && widget.temporaryStock.containsKey(selectedProduct)) {
      stockLevel.value = widget.temporaryStock[selectedProduct]!.toInt();
    } else {
      stockLevel.value = 0;
    }
    count = stockLevel.value > 0 ? 1 : 0;
    double mrp = double.tryParse(filteredList[index].mrp) ?? 0;
    checkoutText.value = '₹ ${(count * mrp).toStringAsFixed(2)}';

    bool isDuplicate = tempSaleNotifier.value.any((saleProduct) =>
        saleProduct.product.itemName.trim().toLowerCase() ==
        selectedProduct!.itemName.trim().toLowerCase());
    if (isDuplicate) {
      CustomSnackBarCustomisation.show(context: context,message:
       "This product is already in the sales list.", messageColor:blue,
       icon: Icons.assignment_turned_in,
       iconColor: blue);
    }
  });}
  void incrementCount() {
    setState(() {
      if (count < stockLevel.value) {
        count++;
        double mrp = selectedProductIndex != null
            ? double.tryParse(filteredList[selectedProductIndex!].mrp) ?? 0
            : 0;
        checkoutText.value = '₹ ${(count * mrp).toStringAsFixed(2)}';
      }
    });}
  void decrementCount() {
    setState(() {
      if (count > 1) {
        count--;
        double mrp = selectedProductIndex != null
            ? double.tryParse(filteredList[selectedProductIndex!].mrp) ?? 0
            : 0;
        checkoutText.value = '₹ ${(count * mrp).toStringAsFixed(2)}';
      }
    }); }
void onCheckoutPressed() {
  if (selectedProductIndex != null) {
    final selectedProduct = filteredList[selectedProductIndex!];
    final availableStock = widget.temporaryStock[selectedProduct] ?? 0;

    bool isDuplicate = tempSaleNotifier.value.any((saleProduct) =>
        saleProduct.product.itemName.trim().toLowerCase() ==
        selectedProduct.itemName.trim().toLowerCase());
    if (isDuplicate) {
      CustomSnackBarCustomisation.show(
          context: context,
          message: "This product is already in the sales list.",
          messageColor: redColor,
          icon: Icons.assignment_turned_in,
          iconColor: redColor);
      return;
    }
    if (availableStock == 0) {
         CustomSnackBarCustomisation.show(
          context: context,
          message: "No stock avalable for ${selectedProduct.itemName}.",
          messageColor: redColor,
          icon: Icons.shopify_rounded,
          iconColor: redColor);
      return;
    }
    if (widget.temporaryStock.containsKey(selectedProduct)) {
      double availableStock = widget.temporaryStock[selectedProduct]!;
      if (availableStock >= count) {
        widget.temporaryStock[selectedProduct] = availableStock - count;
        tempSaleNotifier.value = List.from(tempSaleNotifier.value)
          ..add(SaleProduct(
              product: selectedProduct,
              count: count.toString(),
              price: checkoutText.value,
            ),
          );
        // ignore: invalid_use_of_protected_member
        tempSaleNotifier.notifyListeners();
        setState(() {
          selectedProductIndex = null;
          searchController.clear();
          count = 0;
          stockLevel.value = 0;
          checkoutText.value = '₹ 0.00';
        }); CustomSnackBar.showSuccessSnackBar(context, selectedProduct.itemName);
      } else {
          CustomSnackBar.show(
           context: context,message:'Insufficient stock for ${selectedProduct.itemName}.',
          );
      }}
  } else { CustomSnackBar.showErrorSnackBar(context);}}
  void updateTemporaryStock(AddModel product, double quantity) {
    setState(() {
      if (widget.temporaryStock.containsKey(product)) {
        widget.temporaryStock[product] = (widget.temporaryStock[product]! - quantity).clamp(0.0, double.infinity);
      }
    });
    }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  MyAppBarTwo(titleText: 'Add Sale',bgColor: inside,),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.01),
              child: SearchField(
                searchController: searchController,
                filterSearchResults: filterSearchResults,
                screenWidth: screenWidth,
              ),
            ),
            SizedBox(
              height: screenHeight * 0.6,
              child: ValueListenableBuilder<List<AddModel>>(
                valueListenable: addListNotifier,
                builder: (context, addList, child) {
                  if (filteredList.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.asset(
                            'assets/gif/purchase_empty.json',
                            width: screenWidth * 0.5,
                            height: screenHeight * 0.3,
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'No Products found!',
                            style: GoogleFonts.kodchasan(
                              fontSize: 16,
                              color: grey,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: selectedProductIndex == null
                          ? filteredList.length
                          : 1,
                      itemBuilder: (context, index) {
                        final actualIndex = selectedProductIndex ?? index;
                        final item = filteredList[actualIndex];
                        return Column(
                          children: [
                            SizedBox(height: screenHeight * 0.01),
                            MultipleSateFiled(
                              imagePath: item.imagePath,
                              titleText: item.itemName,
                              descriptionText: item.description,
                              buttonText: item.dropDown,
                              price: item.mrp,
                              onTap: () => handleProductClick(actualIndex),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            multipleSalesSubfile(incrementCount, screenHeight,stockLevel,decrementCount,count),
            SizedBox(height: screenHeight * 0.01),
            ValueListenableBuilder<String>(
                valueListenable: checkoutText,
                builder: (context, checkoutValue, child) {
                  return ActionButtons(
                    onAddSalePressed: () { Navigator.of(context).pop();},
                    onCheckoutPressed: onCheckoutPressed,
                    addSaleText: 'Return',
                    checkoutText: checkoutValue,
                  );
               }),
          ],
        ),
      ),
    );
  }
}

