import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vaultora_inventory_app/main%20page/category/list_sale/clear_bottom_sale.dart';

class SaleFilter extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onClearFilters;
  final double screenWidth;
  final double screenHeight;

  const SaleFilter({
    super.key,
    required this.onClose,
    required this.onClearFilters,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SaleFilterState createState() => _SaleFilterState();
}

class _SaleFilterState extends State<SaleFilter> {


  

  void _showClearFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ClearFilterBottomSaleSheet(
          onClear: () {
        
          },
        );
      },
    );
  }






  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: widget.screenHeight * 0.10 + 10,
      left: widget.screenWidth * 0.03,
      right: widget.screenWidth * 0.03,
      child: GestureDetector(
        onTap: () {},
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Filters",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: InkWell(
                        onTap: _showClearFilterBottomSheet,
                        child: const Text("Clear Filters")),
                  ),
                ],
              ),
              SizedBox(height: widget.screenHeight * 0.02),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: GoogleFonts.kodchasan(
                    fontSize: 14,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.01),
             
              SizedBox(height: widget.screenHeight * 0.01),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Price Range',
                  style: GoogleFonts.kodchasan(
                    fontSize: 14,
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              Column(
                children: [
                 
                  SizedBox(height: widget.screenHeight * 0.02),
                ],
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                      ],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Apply"),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
