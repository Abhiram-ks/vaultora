import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:vaultora_inventory_app/main%20page/category/list_sale/sale_class/subclass_sale/clear_bottom_sale.dart';
import 'package:vaultora_inventory_app/main%20page/category/list_sale/sale_class/subclass_sale/date_invoice.dart';

class SaleFilter extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onClearFilters;
  final Function(DateTime?, DateTime?) onApplyFilters;
  final double screenWidth;
  final double screenHeight;

  const SaleFilter({
    super.key,
    required this.onClose,
    required this.onClearFilters,
    required this.onApplyFilters,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SaleFilterState createState() => _SaleFilterState();
}

class _SaleFilterState extends State<SaleFilter> {
  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;

  void _updateSelectedDates(DateTime startDate, DateTime endDate) {
    setState(() {
      _selectedStartDate = startDate;
      _selectedEndDate = endDate;
    });
  }

  void _showClearFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return ClearFilterBottomSaleSheet(
          onClear: () {
            setState(() {
              _selectedStartDate = null;
              _selectedEndDate = null;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    String startDateText = _selectedStartDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedStartDate!)
        : 'Start Date';
    String endDateText = _selectedEndDate != null
        ? DateFormat('dd/MM/yyyy').format(_selectedEndDate!)
        : 'End Date';

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
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(Icons.calendar_month,
                          color: Colors.black, size: 28),
                      onPressed: () {
                        showBottomSheet(
                            backgroundColor: Colors.white,
                            context: context,
                            builder: (context) {
                              return DateRangePickerPopup(
                                selectedStartDate: _selectedStartDate,
                                selectedEndDate: _selectedEndDate,
                                onDateRangeSelected: _updateSelectedDates,
                              );
                            });
                      },
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Text(startDateText),
                  SizedBox(width: screenWidth * 0.05),
                  Text(endDateText),
                ],
              ),
              SizedBox(height: widget.screenHeight * 0.01),
              Row(
                children: [
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [],
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onApplyFilters(
                            _selectedStartDate, _selectedEndDate);
                      },
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
