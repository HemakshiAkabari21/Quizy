import 'package:animated_loader_demo_flutter/app_theme/app_colors.dart';
import 'package:animated_loader_demo_flutter/app_theme/style_helper.dart';
import 'package:animated_loader_demo_flutter/model/country_model.dart';
import 'package:animated_loader_demo_flutter/utils/const_images.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ExpandableDeliveryBoyTextField extends StatefulWidget {
  final List<CountryModel> countryList;
  final CountryModel? selectedCountry;
  final Function(CountryModel?) onCountrySelected;
  final Function(CountryModel?)? onCountrySaved;
  final Function? validator;
  final String hintText;
  final String? title;
  final String labelText;
  final Color? borderColor;
  final Color? errorBorderColor;
  final bool? isError;
  final bool? readOnly;
  final String? errorText;
  final double? borderRadius;
  final String? searchHintText;
  final TextEditingController? controller;
  final String? typeofUser;
  final Widget? prefix;

  const ExpandableDeliveryBoyTextField({
    super.key,
    required this.countryList,
    this.controller,
    this.selectedCountry,
    required this.onCountrySelected,
    this.onCountrySaved,
    this.title,
    this.readOnly = false,
    this.validator,
    this.hintText = '',
    this.labelText = '',
    this.borderColor,
    this.errorBorderColor,
    this.isError,
    this.errorText,
    this.borderRadius,
    this.searchHintText,
    this.typeofUser,
    this.prefix,
  });

  @override
  State<ExpandableDeliveryBoyTextField> createState() => _ExpandableDeliveryBoyTextFieldState();
}

class _ExpandableDeliveryBoyTextFieldState extends State<ExpandableDeliveryBoyTextField> {
  bool isExpanded = false;
  late TextEditingController controller;
  late TextEditingController searchController;
  CountryModel? selectedCountry;
  List<CountryModel> filteredCountry = [];

  @override
  void initState() {
    super.initState();
    selectedCountry = widget.selectedCountry;
    controller = TextEditingController();
    searchController = TextEditingController();
    filteredCountry = widget.countryList;
    _updateControllerText();
  }

  @override
  void didUpdateWidget(ExpandableDeliveryBoyTextField oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.selectedCountry != widget.selectedCountry) {
      setState(() {
        selectedCountry = widget.selectedCountry;
        _updateControllerText();
      });
    }

    if (oldWidget.countryList != widget.countryList) {
      setState(() {
        filteredCountry = widget.countryList;
        _filterDeliveryBoys(searchController.text);
      });
    }
  }

  void _updateControllerText() {
    if (selectedCountry == null || (selectedCountry?.name?.common?.isEmpty ?? true)) {
      controller.text = '';
    } else {
      controller.text = selectedCountry?.name?.common ?? '';
    }
  }

  void _filterDeliveryBoys(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredCountry = widget.countryList;
      } else {
        filteredCountry = widget.countryList.where((deliveryBoy) {
          final name = deliveryBoy.name?.common?.toLowerCase() ?? '';
          final address = deliveryBoy.name?.official?.toLowerCase() ?? '';
          final searchQuery = query.toLowerCase();
          return name.contains(searchQuery) || address.contains(searchQuery);
        }).toList();
      }
    });
  }

  void _clearSearch() {
    searchController.clear();
    _filterDeliveryBoys('');
  }

  @override
  void dispose() {
    controller.dispose();
    searchController.dispose();
    super.dispose();
  }

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
      if (!isExpanded) {
        _clearSearch();
      }
    });
  }

  void selectDeliveryBoy(CountryModel deliveryBoy) {
    setState(() {
      selectedCountry = deliveryBoy;
      isExpanded = !isExpanded;
      _updateControllerText();
    });

    _clearSearch();

    // Debug Print
    debugPrint('=== Delivery Boy Selection Debug ===');
    debugPrint('Selected delivery boy: ${selectedCountry?.name} (ID: ${selectedCountry?.name})');
    debugPrint('====================================');

    widget.onCountrySelected(selectedCountry);
  }

  void clearSelection() {
    setState(() {
      selectedCountry = null;
      _updateControllerText();
    });

    debugPrint('=== Delivery Boy Selection Cleared ===');
    debugPrint('Selected delivery boy: $selectedCountry');
    debugPrint('======================================');

    widget.onCountrySelected(selectedCountry);
  }

  bool isSameDeliveryBoy(CountryModel? boy1, CountryModel? boy2) {
    if (boy1 == null && boy2 == null) return true;
    if (boy1 == null || boy2 == null) return false;
    return boy1.name == boy2.name;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: TextFormField(
            controller: controller,
            readOnly: true,
            validator: (value) {
              if (widget.validator != null) {
                return widget.validator!.call(value);
              }
              return null;
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              labelText: widget.labelText,
              filled: true,
              fillColor: AppColors.white,
              prefixIcon: widget.prefix,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 0.h,
              ),
              hintStyle: StyleHelper.customStyle(
                color: AppColors.primary,
                size: 12.sp,
                family: bold,
              ),
              labelStyle: TextStyle(
                  backgroundColor: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: AppColors.primary
              ),
              suffixIcon: GestureDetector(
                onTap: toggleExpansion,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.all(12.sp),
                  child: AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: Duration(milliseconds: 300),
                    child: SvgPicture.asset(
                      AppImages.arrowDown,
                      height: 16.h,
                      width: 16.w,
                      color: isExpanded ? AppColors.primary : AppColors.black,
                    ),
                  ),
                ),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                  borderSide: BorderSide(width: isExpanded ? 2.w : 1.w, color: widget.borderColor ?? AppColors.slateGray)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                  borderSide: BorderSide(width: 1.w, color: widget.isError ?? false ? AppColors.errorColor : AppColors.slateGray)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
                  borderSide: BorderSide(width: 1.w, color: widget.errorBorderColor ?? AppColors.slateGray)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide(width: 1.w, color: widget.errorBorderColor ?? AppColors.slateGray)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
                  borderSide: BorderSide(width: 1.w, color: isExpanded ? AppColors.slateGray : widget.borderColor ?? AppColors.slateGray)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius ?? 8.r),
                  borderSide: BorderSide(width: 1.w, color: widget.borderColor ?? AppColors.slateGray)),
            ),
            onTap: toggleExpansion,
            style: StyleHelper.customStyle(
              color: AppColors.primary,
              size: 14.sp,
              family: semiBold,
            ),
          ),
        ),

        if(widget.isError ?? false)
          Text(
            widget.errorText ?? "",
            softWrap: true,
            maxLines: null,
            style: StyleHelper.customStyle(
                color: AppColors.errorColor,
                size: 12.sp,
                family: regular
            ),
          ),

        if(!(widget.readOnly ?? false))
        AnimatedContainer(
          duration: Duration(milliseconds: 1000),
          curve: Curves.easeInOutQuart,
          height: isExpanded ? (Get.height): 0,
          child: AnimatedOpacity(
            opacity: isExpanded ? 1.0 : 0.0,
            duration: Duration(milliseconds: 300),
            child: Container(
              height: (Get.height/3),
              margin: EdgeInsets.only(top: 8.h),
              padding: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.slateGray,
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withOpacity(0.5),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min, // Add this line
                children: [
                  Text(
                    widget.title ?? 'Search Country...'.tr,
                    style: StyleHelper.customStyle(
                      color: AppColors.primary,
                      size: 14.sp,
                      family: semiBold,
                    ),
                  ).paddingOnly(bottom: 8.h),
                  TextField(
                    controller: searchController,
                    cursorColor: AppColors.black.withOpacity(0.6),
                    onChanged: _filterDeliveryBoys,
                    decoration: InputDecoration(
                      hintText: widget.searchHintText ?? 'Search Country...'.tr,
                      hintStyle: StyleHelper.customStyle(
                        color: AppColors.black.withOpacity(0.6),
                        size: 12.sp,
                        family: regular,
                      ),
                      filled: true,
                      fillColor: AppColors.white,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 8.h,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        size: 16.sp,
                        color: AppColors.primary.withOpacity(0.7),
                      ),
                      suffixIcon: searchController.text.isNotEmpty
                          ? GestureDetector(
                        onTap: _clearSearch,
                        child: Icon(
                          Icons.clear,
                          size: 16.sp,
                          color: AppColors.primary.withOpacity(0.7),
                        ),
                      )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color:AppColors.slateGray,
                          width: 1.w,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: AppColors.slateGray,
                          width: 1.w,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color:AppColors.slateGray,
                          width: 1.w,
                        ),
                      ),
                    ),
                    style: StyleHelper.customStyle(
                      color: AppColors.black,
                      size: 12.sp,
                      family: medium,
                    ),
                  ),

                  Flexible(
                    child: filteredCountry.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 32.sp,
                            color: AppColors.primary.withOpacity(0.5),
                          ),
                          SizedBox(height: 8.h),
                          Text('No Country found'.tr,
                            style: StyleHelper.customStyle(
                              color: AppColors.primary.withOpacity(0.7),
                              size: 12.sp,
                              family: medium,
                            ),
                          ),
                        ],
                      ),
                    )
                        : ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: filteredCountry.length,
                      itemBuilder: (context, index) {
                        final deliveryBoy = filteredCountry[index];
                        final isSelected = isSameDeliveryBoy(selectedCountry, deliveryBoy);
                        return Container(
                          width: Get.width,
                          margin: EdgeInsets.only(bottom: 4.h),
                          child: GestureDetector(
                            onTap: () => selectDeliveryBoy(deliveryBoy),
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 12.h,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary.withOpacity(0.1)
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(8.r),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary.withOpacity(0.5)
                                      : AppColors.primary.withOpacity(0.2),
                                  width: isSelected ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  if (deliveryBoy.flags?.png != null) CachedNetworkImage(imageUrl: deliveryBoy.flags?.png ?? '',width: 24.w,height: 18.h,),
                                  SizedBox(width: 10.w),
                                  Expanded(
                                    child: Text(deliveryBoy.name?.common ?? '', style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}