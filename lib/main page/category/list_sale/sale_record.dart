import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vaultora_inventory_app/db/functions/salefuction.dart';
import 'package:vaultora_inventory_app/db/models/sale/onsale.dart';
import 'package:vaultora_inventory_app/main%20page/add/add_product/appbar.dart';
import 'package:vaultora_inventory_app/main%20page/category/list_sale/clear_bottom_sale.dart';

import 'sale_filter.dart';

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

  void _showClearFilterBottomSheetSale() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      builder: (context) {
        return ClearFilterBottomSaleSheet(
          onClear: () {},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const MyAppBarTwo(titleText: 'Sales Record'),
      body: GestureDetector(
        onTap: _closeFilter,
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
              child: Column(
                children: [
                  SizedBox(height: screenHeight * 0.03),
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

                                  return SalesCard(
                                      data: formattedDate,
                                      name: sale.accountName,
                                      address: sale.address,
                                      phone: sale.phoneNumber,
                                      total: sale.totalPrice,
                                      ifcCode: sale.salesNumber);
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
                screenWidth: screenWidth,
                screenHeight: screenHeight,
              ),
          ],
        ),
      ),
    );
  }
}

class SalesCard extends StatefulWidget {
  final String data;
  final String name;
  final String address;
  final String phone;
  final String total;
  final String ifcCode;

  const SalesCard({
    super.key,
    required this.data,
    required this.name,
    required this.address,
    required this.phone,
    required this.total,
    required this.ifcCode,
  });

  @override
  State<SalesCard> createState() => _SalesCardState();
}

class _SalesCardState extends State<SalesCard> {
  bool showDetails = false;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Card(
      color: Colors.white,
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SizedBox(
        height: screenHeight * 0.166,
        width: double.infinity,
        child: Stack(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: screenHeight * 03,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xFFE8EDEB),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: screenWidth * 0.35,
                                height: screenHeight * 0.04,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  color: Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(2.0),
                                      child: Icon(Icons.calendar_month),
                                    ),
                                    SizedBox(width: screenWidth * 0.02),
                                    Text(widget.data),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  const Icon(Icons.person),
                                  SizedBox(
                                    width: screenWidth * 0.03,
                                  ),
                                  SizedBox(
                                    width: screenWidth * 0.4,
                                    child: Text(
                                      widget.name,
                                      style: GoogleFonts.kodchasan(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (showDetails) ...[
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    const Icon(Icons.location_on),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.4,
                                      child: Text(
                                        widget.address,
                                        style: GoogleFonts.kodchasan(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 4.0),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    const Icon(Icons.phone,
                                        color: Colors.green),
                                    SizedBox(
                                      width: screenWidth * 0.03,
                                    ),
                                    SizedBox(
                                      width: screenWidth * 0.4,
                                      child: Text(
                                        widget.phone,
                                        style: GoogleFonts.kodchasan(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  showDetails = !showDetails;
                                });
                              },
                              child: Text(
                                showDetails ? 'Hide Details' : 'Show Details',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Total',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          '₹ ${widget.total}.00',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 0, 140, 255),
                  borderRadius: BorderRadius.circular(15),
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.ifcCode,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 8,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchbarSale extends StatefulWidget {
  final String hintText;
  final VoidCallback onSearchPressed;
  final VoidCallback onFilterPressed;
  final bool isFilterActive;

  const SearchbarSale({
    super.key,
    required this.hintText,
    required this.onSearchPressed,
    required this.onFilterPressed,
    required this.isFilterActive,
  });

  @override
  State<SearchbarSale> createState() => _SearchbarSaleState();
}

class _SearchbarSaleState extends State<SearchbarSale> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: screenHeight * 0.07,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: screenWidth * 0.04,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            onPressed: widget.onFilterPressed,
            icon: Icon(
              widget.isFilterActive ? Icons.close : Icons.filter_alt,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 5),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF68C5CC),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  widget.onSearchPressed();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.06, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Search",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth * 0.04,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ClearFilterBottomSheetSale extends StatelessWidget {
  final VoidCallback onClear;

  const ClearFilterBottomSheetSale({
    super.key,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Clear Filters",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            "Would you like to clear the following filters?",
            style: TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 129, 129, 129)),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                        color: Color.fromRGBO(158, 158, 158, 1), width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "Cancel",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: onClear,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text("Clear"),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ],
      ),
    );
  }
}
