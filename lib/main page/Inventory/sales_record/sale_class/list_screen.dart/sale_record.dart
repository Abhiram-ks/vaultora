import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/add/productfiles_sub/appbar.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/sales_record/sale_class/list_screen.dart/details_sale_page.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/sales_record/sale_class/subclass_sale/clear_bottom_sale.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/sales_record/sale_class/subclass_sale/sales_card.dart';
import 'package:vaultora_inventory_app/main%20page/Inventory/sales_record/sale_class/subclass_sale/search_sale.dart';

import '../subclass_sale/sale_filter.dart';

class SalesData extends StatefulWidget {
  const SalesData({
    super.key,
  });

  @override
  State<SalesData> createState() => _SalesDataState();
}

class _SalesDataState extends State<SalesData> {
  bool _isFilterVisible = false;

    @override
  void initState() {
    super.initState();
    _initializeSalesData();
  }

  Future<void> _initializeSalesData() async {
    await getAllSales();
  }


  void _toggleFilter() {
    setState(() {
      _isFilterVisible = !_isFilterVisible;
    });
  }

  void _closeFilter() {
    if (_isFilterVisible) {
      setState(() {
        _isFilterVisible = false;
      });
    }
  }

void _applyDateFilters(DateTime? startDate, DateTime? endDate) {
  if (startDate != null && endDate != null) {
    DateTime adjustedEndDate = endDate.add(const Duration(hours: 23, minutes: 59, seconds: 59));

    List<SalesModel> filteredList = originalSalesList.where((sale) {
      final saleTimestamp = int.tryParse(sale.id) ?? 0;
      final saleDate = DateTime.fromMicrosecondsSinceEpoch(saleTimestamp);
      return (saleDate.isAtSameMomentAs(startDate) || saleDate.isAfter(startDate)) && 
             (saleDate.isAtSameMomentAs(adjustedEndDate) || saleDate.isBefore(adjustedEndDate));
    }).toList();

    salesListNotifier.value = filteredList;
  } else {
    salesListNotifier.value = List.from(originalSalesList);
  }
  // ignore: invalid_use_of_protected_member
  salesListNotifier.notifyListeners();
  _closeFilter();
}



  void _showClearFilterBottomSheetSale() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return ClearFilterBottomSaleSheet(
          onClear: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const MyAppBarTwo(titleText: 'Sales Record'),
      body: GestureDetector(
        onTap: _closeFilter,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.01),
                  SearchbarSale(
                    hintText: 'Search for Customer',
                    onSearchPressed: () {},
                    onFilterPressed: _toggleFilter,
                    isFilterActive: _isFilterVisible,
                  ),
                  Expanded(
                      child: ValueListenableBuilder(
                          valueListenable: salesListNotifier,
                          builder: (context, List<SalesModel> salesList, _) {
                            if (salesList.isEmpty) {
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'assets/category/sale_empty.json',
                                      width: screenWidth * 0.5,
                                      height: screenHeight * 0.3,
                                    ),
                                    SizedBox(height: screenHeight * 0.02),
                                    Text(
                                      'No records found !',
                                      style: GoogleFonts.kodchasan(
                                        fontSize: 16,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              salesList.sort((a, b) {
                                final aTimestamp = int.tryParse(a.id) ?? 0;
                                final bTimestamp = int.tryParse(b.id) ?? 0;
                                return bTimestamp.compareTo(aTimestamp);
                              });

                              return ListView.builder(
                                itemCount: salesList.length,
                                itemBuilder: (context, index) {
                                  final sale = salesList[index];

                                  final timestamp = int.tryParse(sale.id) ?? 0;
                                  final dateTime =
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          timestamp);
                                  final formattedDate =
                                      DateFormat('dd/MM/yyyy').format(dateTime);
                                  final formattedTime = DateFormat('HH:mm:ss').format(dateTime); 

                                  return SalesCard(
                                      data: formattedDate,
                                      name: sale.accountName,
                                      address: sale.address,
                                      phone: sale.phoneNumber,
                                      total: sale.totalPrice,
                                      ifcCode: sale.salesNumber,
                                      time: formattedTime,
                                      onTap: () {
                                        Navigator.of(context).push(MaterialPageRoute(builder:  (context) => DetailsSalePage(saledDetails: sale,),));
                                      },
                                      );
                                },
                              );
                            }
                          }))
                ],
              ),
            ),
            if (_isFilterVisible)
              SaleFilter(
                onClose: () => setState(() => _isFilterVisible = false),
                onClearFilters: _showClearFilterBottomSheetSale,
                onApplyFilters: _applyDateFilters,
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
          ],
        ),
      ),
    );
  }
}

