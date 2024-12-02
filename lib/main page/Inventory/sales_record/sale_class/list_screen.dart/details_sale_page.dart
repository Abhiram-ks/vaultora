import 'package:flutter/material.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/sales_record/sale_class/subclass_sale/stack_sale_build.dart';
import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/main%20page/add/salefiles_sub/success_snackbar.dart';
import '../../../../../db/functions/salefuction.dart';
import '../../../../../db/models/sale/onsale.dart';
import '../../../../add/salefiles_sub/iteam_dropdown.dart';
import '../../../product_record/detailPurchase/actionbuttons_specification.dart';
import '../../../product_record/detailPurchase/delete_edit.dart';
import '../subclass_sale/phone_action.dart';

class DetailsSalePage extends StatefulWidget {
  final SalesModel saledDetails;
  const DetailsSalePage({super.key, required this.saledDetails});

  @override
  State<DetailsSalePage> createState() => _DetailsSalePageState();
}

class _DetailsSalePageState extends State<DetailsSalePage> {
  bool isExpanded = false;
  final ValueNotifier<int> _currentIndexNotifier = ValueNotifier<int>(0);

  final _formKey = GlobalKey<FormState>();
    late final ValueNotifier<String> _billingNameNotifier;
    late final ValueNotifier<String> _addressNameNotifier;
    late final ValueNotifier<String> _phoneNotifier;
  @override
  void initState() {
    super.initState();
  _billingNameNotifier = ValueNotifier(widget.saledDetails.accountName);
  _addressNameNotifier = ValueNotifier(widget.saledDetails.address);
   _phoneNotifier = ValueNotifier(widget.saledDetails.phoneNumber);
  }
updateExpand(){
setState(() {
  isExpanded=!isExpanded;
});

} 

 @override
  void dispose() {
    _currentIndexNotifier.dispose();
     _billingNameNotifier.dispose();
    _addressNameNotifier.dispose();
    _phoneNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    final timestamp = int.tryParse(widget.saledDetails.id) ?? 0;
    final dateTime = DateTime.fromMicrosecondsSinceEpoch(timestamp);
    final formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    final formattedTime = DateFormat('HH:mm:ss').format(dateTime);

    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SalesStackWidget
            (billingNameNotifier: _billingNameNotifier,
            screenWidth: screenWidth, screenHeight: screenHeight,
            saledDetails: widget.saledDetails, formKey: _formKey, 
            addressNameNotifier: _addressNameNotifier,phoneNotifier: _phoneNotifier, isExpanded: isExpanded,formattedDate: formattedDate, formattedTime: formattedTime,
              ctx: context,updateExpand: () {setState(() {isExpanded = !isExpanded;});
            }),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.46,
                child: widget.saledDetails.saleProduct.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopify_outlined,size: 30,color: Colors.black,
                            ),
                            Text('No Products Found!')
                          ],
                        ),
                      ): Stack(
                        children: [
                          Positioned(
                            top: 8.0,
                            right: 16.0,
                            child: ValueListenableBuilder<int>(
                              valueListenable: _currentIndexNotifier,
                              builder: (context, currentIndex, _) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    "${currentIndex + 1} / ${widget.saledDetails.saleProduct.length}",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0),
                            child: StackedCardCarousel(
                              type: StackedCardCarouselType.cardsStack,
                              items: widget.saledDetails.saleProduct
                                  .map((product) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01),
                                  child: ShowSaleAdded(
                                    titleText: product.product.itemName,
                                    descriptionText: product.product.description,
                                    buttonText: product.product.dropDown,
                                    imagePath: product.product.imagePath,
                                    price: (double.parse(product.product.mrp) *int.parse(product.count)).toStringAsFixed(2),
                                    badgeText: product.count,
                                  ),
                                );
                              }).toList(),
                              onPageChanged: (index) {
                                _currentIndexNotifier.value = index;
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.038),
              child: SizedBox(
                width: double.infinity,
                height: screenHeight * 0.14,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: screenWidth * 0.04),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Grand Total',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(widget.saledDetails.totalPrice,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Row(children: [
                      ActionbuttonsSpecification(
                        icon: Icons.delete_outline_outlined,
                        iconColor: Colors.red,
                        onPressed: () async {
                          bool? confirmDeletion =
                              await DeleteConfirmationBottomSheet.show(
                            context,
                            widget.saledDetails.accountName,
                          );

                          if (confirmDeletion == true) {
                            deleteSale(widget.saledDetails.id);
                          }
                        },
                      ),
                      ActionbuttonsSpecification(
                        icon: Icons.save_rounded,
                        iconColor: Colors.black,
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? false) {
                            final updatedAccountName =
                                _billingNameNotifier.value;
                            final updatedAddress = _addressNameNotifier.value;
                            final updatedPhoneNumber = _phoneNotifier.value;

                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );
                            await Future.delayed(const Duration(seconds: 3));

                            bool isUpdated = await updateSale(
                              id: widget.saledDetails.id,
                              accountName: updatedAccountName,
                              address: updatedAddress,
                              phoneNumber: updatedPhoneNumber,
                            );
                            _billingNameNotifier.value =updatedAccountName;
                            _addressNameNotifier.value = updatedAddress;
                            _phoneNotifier.value = updatedPhoneNumber;

                            Navigator.of(context).pop();
                            if (isUpdated) {
                              SuccessfullyMessage.show(
                                context: context,
                                message: 'Details updated successfully!',
                              );
                            } else {
                              CustomSnackBar.show(
                                context: context,
                                message: 'Failed to update sale details.',
                              );
                            }
                          }
                        },
                      ),
                      ActionbuttonsSpecification(
                        icon: Icons.phone_forwarded_outlined,
                        iconColor: Colors.green,
                        onPressed: () {
                          makePhoneCall(context,
                              widget.saledDetails.phoneNumber.toString());
                        },
                      ),
                    ])
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
