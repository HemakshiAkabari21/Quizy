import 'dart:convert';
import 'dart:io';


import 'package:quizy/app_theme/app_colors.dart';
import 'package:quizy/app_theme/style_helper.dart';
import 'package:quizy/model/pdf_model.dart';
import 'package:quizy/repository/api_services.dart';
import 'package:quizy/repository/network_function.dart';
import 'package:quizy/screens/login_screen/login_screen.dart';
import 'package:quizy/utils/const_images.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import 'custom_button.dart';



showToast({required String message}) {
  Fluttertoast.showToast(
    msg: message.tr,
    backgroundColor: AppColors.orange,
    textColor: Colors.white,
    fontSize: 14.sp,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    // textColor: Colors.pink
  );
}

class PaddingHorizontal15 extends StatelessWidget {
  const PaddingHorizontal15({super.key, required this.child, this.top, this.bottom, this.horizontal});

  final Widget child;
  final double? top;
  final double? bottom;
  final double? horizontal;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.only(left: horizontal ?? 15.w, right: horizontal ?? 15.w, top: top ?? 0, bottom: bottom ?? 0), child: child);
  }
}

getAppVersion() async {
  final versionInfo = await PackageInfo.fromPlatform();
  return versionInfo.version;
}

/// User-detail

/*UserDetail getUserDetail() {
  UserDetail userDetail = UserDetail();
  if (getStorage.read(USER_DETAIL) != null) {
    userDetail = UserDetail.fromJson(jsonDecode(getStorage.read(USER_DETAIL).toString()));
  }
  return userDetail;
}*/

class AnimatedBuildDot extends StatelessWidget {
  const AnimatedBuildDot({super.key, required this.index, required this.currentBannerImageIndex, this.height, this.width, this.offColor, this.onColor});

  final int index, currentBannerImageIndex;
  final double? height, width;
  final Color? offColor, onColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.linearToEaseOut,
      margin: EdgeInsets.only(right: 5.w),
      height: height ?? 5.h,
      width: width ?? 5.w,
      decoration: BoxDecoration(
        color: index == currentBannerImageIndex ? onColor ?? AppColors.orange : offColor ?? AppColors.lightGray,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(color: index == currentBannerImageIndex ? onColor ?? AppColors.orange : offColor ?? AppColors.lightGray),
      ),
    );
  }
}

class CommonDialog extends StatelessWidget {
  const CommonDialog({super.key, this.onTapNo, required this.onTapYes, required this.title, this.description, this.tapNoText, this.tapYesText});
  final Function()? onTapNo;
  final Function() onTapYes;
  final String title;
  final String? description;
  final String? tapNoText;
  final String? tapYesText;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.tr, style: StyleHelper.customStyle()),
          if (description != null) Padding(padding: EdgeInsets.only(top: 5.h), child: Text(description!.tr, style: StyleHelper.customStyle())),
          SizedBox(height: 15.h),
          Row(
            children: [
              if (onTapNo != null) Expanded(child: CustomButton(onTap: onTapNo, borderColor: AppColors.grayBorder, color: AppColors.white, borderRadius: 100, rightMargin: 15.w, height: 35.h, childWidget: Text(tapNoText ?? "no".tr, style: StyleHelper.customStyle()))),

              Expanded(child: CustomButton(onTap: onTapYes, borderColor: AppColors.primary, color: AppColors.primary, borderRadius: 100, height: 35.h, childWidget: Text(tapYesText ?? "yes".tr, style: StyleHelper.customStyle(color: AppColors.white)))),
            ],
          ),
        ],
      ),
    );
  }
}

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Rx<File?> selectedImage = Rx<File?>(null);
  static Rx<File?> selectedPDF = Rx<File?>(null);

  static Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source, imageQuality: 40);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  static Future<void> pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null && result.files.single.path != null) {
      selectedPDF.value = File(result.files.single.path!);
    } else {
      Get.snackbar("Error", "No PDF selected.");
    }
  }

  static void showImagePickerOptions(BuildContext context) {
    Get.bottomSheet(
      Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        child: Wrap(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(Icons.clear, color: AppColors.black, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Text('upload_image'.tr, style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: medium)),
              ],
            ).paddingOnly(top: 16.h, bottom: 8.h, right: 16.w, left: 16.w),
            Divider(thickness: 1.w, color: AppColors.grayBorder),
            SizedBox(height: 8.h),
            optionForBottomSheet(
              icon: Icon(Icons.camera_alt_outlined, color: AppColors.primary, size: 24.sp),
              optionName: 'take_photo_using_camera'.tr,
              onTap: () async {
                pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            optionForBottomSheet(
              icon: Icon(Icons.image_outlined, color: AppColors.primary, size: 24.sp),
              optionName: 'choose_from_gallery'.tr,
              onTap: () async {
                pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget optionForBottomSheet({required Widget icon, required String optionName, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Row(children: [icon, SizedBox(width: 16.w), Text(optionName, style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp, family: medium))]),
        Divider(thickness: 1.w, color: AppColors.grayBorder, indent: (Get.width / 11).w),
      ],
    ),
  ).paddingSymmetric(horizontal: 16.w, vertical: 8.h);
}

void showDownloadOptions(BuildContext context, String url, Map<String, dynamic> body, String userName) {
  NetworkFunctions.apiRequest(url: url, isShowLoader: true, body: json.encode(body)).then((response) {
    if (response != null) {
      DownloadLedger result = DownloadLedger.fromJson(json.decode(response.body));
      if (result.status!) {
        String filePath = result.pdfUrl ?? '';
        if (filePath.isNotEmpty) {
          showDownloadSuccessDialog(context, filePath, userName);
        }
      } else {
        showToast(message: '${result.message}');
      }
    }
  });
}

// Show Open/Share Dialog after download with improved UI
void showDownloadSuccessDialog(BuildContext context, String filePath, String userName) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: AppColors.primary, size: 48),
              SizedBox(height: 16),
              Text("Ledger Downloaded", style: StyleHelper.customStyle(color: AppColors.black, family: medium, size: 16.sp)),
              SizedBox(height: 8),
              Text("Do you want to open or share the ledger?", textAlign: TextAlign.center, style: StyleHelper.customStyle(color: AppColors.gray, size: 14.sp)),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.white, foregroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4), side: BorderSide(color: AppColors.primary))),
                      onPressed: () async {
                        // Close the options dialog first using Get
                        Get.back();

                        // Then show loading dialog
                        showDownloadingProgress(context, "Opening file...");

                        // Download PDF in background
                        String savedPath = await downloadPDF(filePath, userName);

                        // Close the loading dialog when done using Get
                        Get.back();

                        if (savedPath.isNotEmpty) {
                          OpenFile.open(savedPath);
                        } else {
                          showToast(message: "File download failed.");
                        }
                      },
                      child: Text("Open"),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
                      onPressed: () async {
                        // Close the options dialog first using Get
                        Get.back();

                        // Then show loading dialog
                        showDownloadingProgress(context, "Preparing to share...");

                        // Download PDF in background
                        String savedPath = await downloadPDF(filePath, userName);

                        // Close the loading dialog when done using Get
                        Get.back();

                        if (savedPath.isNotEmpty) {
                          Share.shareXFiles([XFile(savedPath)], text: "Here is the downloaded ledger.");
                        } else {
                          showToast(message: "File download failed.");
                        }
                      },
                      child: Text("Share"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

// Update the loading dialog function to also use context-free navigation
void showDownloadingProgress(BuildContext context, String message) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary)), SizedBox(width: 20), Expanded(child: Text(message, style: StyleHelper.customStyle(color: AppColors.black, size: 14.sp)))]),
        ),
      );
    },
  );
}

Future<String> downloadPDF(String filePath, String userName) async {
  try {
    String todayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    String fileName = "${userName}_ledger_${todayDate}_${DateTime.now().millisecond}.pdf";

    Directory? downloadsDirectory;
    if (Platform.isAndroid) {
      downloadsDirectory = Directory('/storage/emulated/0/Download');
    } else {
      downloadsDirectory = await getApplicationDocumentsDirectory();
    }

    String fullPath = '${downloadsDirectory.path}/$fileName';
    String fileUrl = "${ApiServices.imageURL}$filePath";

    print('Downloading from: $fileUrl to $fullPath');
    await Dio().download(fileUrl, fullPath);
    print("File Downloaded Successfully: $fullPath");

    return fullPath;
  } catch (e) {
    print("Download error: $e");
    return "";
  }
}

class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = 9, dashSpace = 5, startX = 0;
    final paint =
    Paint()
      ..color = AppColors.lightGray
      ..strokeWidth = 1;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

ColorFilter setSvgColor(Color color) {
  return ColorFilter.mode(color, BlendMode.srcIn);
}

/// DashLine Vertical
class DashedVerticalLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 3, dashSpace = 5, startY = 0;
    final paint =
    Paint()
      ..color = AppColors.primary
      ..strokeWidth = 1.5.w;
    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

/// formatDDMMMYYYY
String formatDDMMYYYY(String date) {
  try {
    DateTime parsedDate = DateFormat("yyyy-MM-dd").parse(date);
    return DateFormat("dd-MM-yyyy").format(parsedDate);
  } catch (e) {
    return '';
  }
}

/// formatTimeToAmPm
String formatTimeToAmPm(String time) {
  try {
    final parsedTime = DateFormat("HH:mm:ss").parse(time);
    return DateFormat("hh:mm a").format(parsedTime);
  } catch (e) {
    return '';
  }
}

///calculate discount percentage
double calculateDiscountPercentage({required double actualPrice, required double discountPrice}) {
  if (actualPrice == 0) return 0;
  return ((actualPrice - discountPrice) / actualPrice) * 100;
}



showGuestDialog() {
  Get.defaultDialog(
    backgroundColor: AppColors.white,
    buttonColor: AppColors.primary,
    contentPadding: EdgeInsets.all(8.sp),
    radius: 12.r,
    title: 'guest_login'.tr,
    middleText:
    'you_are_currently_logged'.tr,
    textConfirm: 'register'.tr,
    confirmTextColor: Colors.white,
    onConfirm: () {
      Get.back(); // Close the dialog
      Get.to(()=> LoginScreen()); // Navigate to the register screen
    },
    textCancel: 'cancel'.tr,
  );
}



openDatePicker(
    {required context,
      required Function(String) pickDate,
      String? initialDate,
      DateTime? firstDate,
      DateTime? lastDate}) async {

  final format = DateFormat('dd-MM-yyyy');
  DateTime? initialDateTime;

  try {
    initialDateTime = initialDate != null ? format.parseStrict(initialDate) : DateTime.now();
  } catch (e) {
    initialDateTime = DateTime.now();
  }

  DateTime? temp = await showDatePicker(
    context: context,
    initialDate: initialDateTime,
    firstDate: firstDate ??DateTime.now(),
    lastDate: lastDate ??  DateTime(2050, 01, 01),
    // initialEntryMode: DatePickerEntryMode.calendarOnly,
    builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
          ),
        ),
        child: child!,
      );
    },
  );

  if (temp != null) {
    pickDate.call(formatDDMMYYYY(temp.toString()));
  }
}


class SwipeActionTile extends StatefulWidget {
  final double? height;
  final double? width;
  final Widget child;
  final Key dismissibleKey;
  final int index;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double borderRadius;
  final String? editLabel;
  final String? deleteLabel;
  final String? editIconPath;
  final String? deleteIconPath;
  final Color editColor;
  final Color deleteColor;
  final Color iconBackgroundColor;
  final TextStyle? labelStyle;
  final double? iconSize;
  final bool? isDelete;

  const SwipeActionTile({
    super.key,
    required this.child,
    required this.dismissibleKey,
    required this.index,
    this.width,
    this.height,
    this.onEdit,
    this.onDelete,
    this.borderRadius = 16,
    this.editLabel = "Edit",
    this.deleteLabel = "Delete",
    this.editIconPath = AppImages.edit,
    this.deleteIconPath = AppImages.delete,
    this.editColor = const Color(0xFF90C63A),
    this.deleteColor = const Color(0xFFFF5050),
    this.iconBackgroundColor = AppColors.primary,
    this.labelStyle,
    this.iconSize,
    this.isDelete = true,
  });

  @override
  State<SwipeActionTile> createState() => _SwipeActionTileState();

}

class _SwipeActionTileState extends State<SwipeActionTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  double _dragExtent = 0;
  bool _isEditing = false;
  bool _isDeleting = false;
  final GlobalKey _childKey = GlobalKey();
  double _childHeight = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.4).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateChildHeight();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateChildHeight() {
    if (_childKey.currentContext != null) {
      final RenderBox renderBox =
          _childKey.currentContext!.findRenderObject() as RenderBox;
      setState(() {
        _childHeight = renderBox.size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            AnimatedOpacity(
              opacity: _isEditing ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildBackground(
                iconSize: widget.iconSize,
                alignment: Alignment.centerLeft,
                color: widget.editColor,
                iconPath: widget.editIconPath,
                label: widget.editLabel!,
                width: widget.width,
              ),
            ),
            if(widget.isDelete ?? false)
            AnimatedOpacity(
              opacity: _isDeleting ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: _buildBackground(
                iconSize: widget.iconSize,
                alignment: Alignment.centerRight,
                color: widget.deleteColor,
                iconPath: widget.deleteIconPath,
                label: widget.deleteLabel!,
                width: widget.width,
              ),
            ),
          ],
        ),
        GestureDetector(
          onHorizontalDragStart: (_) {
            setState(() {
              _isEditing = false;
              _isDeleting = false;
              _dragExtent = 0;
            });
          },
          onHorizontalDragUpdate: (details) {
            setState(() {
              _dragExtent += details.delta.dx;
              if (_dragExtent < 0 ) {
                _isDeleting = true;
                _isEditing = false;
              } else if (_dragExtent > 0) {
                _isEditing = true;
                _isDeleting = false;
              }
              _animationController.value =
                  (_dragExtent.abs() / 300.0).clamp(0.0, 1.0);
            });
          },
          onHorizontalDragEnd: (details) {
            final velocity = details.velocity.pixelsPerSecond.dx;
            if (_animationController.value > 0.6 || velocity.abs() > 1000) {
              if (_isEditing && widget.onEdit != null) {
                widget.onEdit!();
              } else if ( _isDeleting && widget.onDelete != null) {
                widget.onDelete!();
              }
            }
            setState(() {
              _dragExtent = 0;
              _isEditing = false;
              _isDeleting = false;
              _animationController.reverse();
            });
          },
          child: Transform.translate(
            offset: Offset(_dragExtent, 0),
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: KeyedSubtree(
                key: _childKey,
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBackground({
    required Alignment alignment,
    required Color color,
    required String label,
    required String? iconPath,
    required double? width,
    required double? iconSize,
  }) {
    final double containerHeight =
        widget.height ?? (_childHeight > 0 ? _childHeight : 60.h);
    return Container(
      height: containerHeight,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(widget.borderRadius.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: alignment == Alignment.centerLeft
            ? MainAxisAlignment.start
            : MainAxisAlignment.end,
        children: alignment == Alignment.centerLeft
            ? [
                _buildIcon(iconPath, widget.iconSize),
                SizedBox(width: 10.w),
                Text(
                  label,
                  style: widget.labelStyle ??
                      StyleHelper.customStyle(color: Colors.white, size: 14.sp),
                ),
              ]
            : [
                Text(
                  label,
                  style: widget.labelStyle ??
                      StyleHelper.customStyle(color: Colors.white, size: 14.sp),
                ),
                SizedBox(width: 10.w),
                _buildIcon(iconPath, widget.iconSize),
              ],
      ),
    );
  }

  Widget _buildIcon(String? iconPath, double? iconSize) {
    if (iconPath == null) return const SizedBox();
    return Container(
      decoration: BoxDecoration(
        // color: widget.iconBackgroundColor,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(10.w),
      child: SvgPicture.asset(
        iconPath,
        color: AppColors.white,
        height: iconSize == null ? 18.sp : iconSize.sp,
        width: iconSize == null ? 18.sp : iconSize.sp,
      ),
    );
  }
}

getCurrentMonthDates({
  required Function(Map<String, String>) callBack,
  required int month,
  required int year,
  }) {
  final firstDate = DateTime(year, month, 1);
  final lastDate = DateTime(year, month + 1, 0);
  final dateFormat = DateFormat('dd-MM-yyyy');
  callBack.call({
    'fromDate': dateFormat.format(firstDate),
    'toDate': dateFormat.format(lastDate),
  });
}

String ddMMYYYYDateFormat(String date) {
  try {
    DateTime parsedDate = DateFormat('yyyy-MM-dd').parseStrict(date);
    return DateFormat('dd-MM-yyyy').format(parsedDate);
  } catch (e) {
    return '';
  }
}
String yyyyMMDDDateFormat(String date) {
  try {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parseStrict(date);
    return DateFormat('yyyy-MM-dd').format(parsedDate);
  } catch (e) {
    return '';
  }
}

Widget noData(String noDataText){
  return Center(
      child: Container(
        color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppImages.noDataFound,width: 150.h,height: 150.h,),
              Text(noDataText,style: StyleHelper.customStyle(color: AppColors.gray,family: semiBold,size: 13.sp,),)
            ],
          )
      )
  );
}

Widget rowBuilder(String image,bool type,String titleText,){
  return Row(
    children: [
      Image.asset(image,color: type?AppColors.primary:AppColors.errorColor,height: 20.h,width: 20.h,),
      SizedBox(width: 10.h,),
      Expanded(child: Text("${titleText}", style: StyleHelper.customStyle(color: type?AppColors.black:AppColors.errorColor,size: 14.sp,family: semiBold))),
    ],
  );
}



/*Future<void> onDownload(BuildContext context, String pdfFileName, String url,{String? number}) async {
  if (Platform.isAndroid) {
    if (await isAndroid13OrAbove()) {
      await handleDownload(context, pdfFileName, url,number: number);
    } else {
      if (await requestPermission()) {
        await handleDownload(context, pdfFileName, url,number: number);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Permission Denied")),
        );
      }
    }
  } else if (Platform.isIOS) {
    await handleDownloadIOS(context, pdfFileName, url,number: number);
  }
}

Future<void> handleDownloadIOS(BuildContext context, String pdfFileName, String url,{String? number}) async {

  try {
    final directory = await getApplicationDocumentsDirectory();

    final savePath = '${directory.path}/BhagyaLaxmi Milk App/$pdfFileName.pdf';

    await Dio().download(url, savePath);
    showDownloadBottomSheet(context, savePath,number: number);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Download failed: ${e.toString()}")),
    );
  }


}

Future<void> handleDownload(BuildContext context, String pdfFileName, String url,{String? number}) async {
  try {
    final docDir = await getApplicationDocumentsDirectory();

    final directory = Platform.isAndroid ? Directory("/storage/emulated/0/Download/BhagyaLaxmi Milk App") : Directory('${docDir.path}/BhagyaLaxmi Milk App');
    final savePath = '${directory.path}/$pdfFileName.pdf';

    await Dio().download(url, savePath);
    showDownloadBottomSheet(context, savePath,number: number);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Download failed: ${e.toString()}")),
    );
  }
}*/

class DownloadLoader extends StatefulWidget {
  final String currentStep;
  final bool isVisible;

  const DownloadLoader({
    super.key,
    required this.currentStep,
    required this.isVisible,
  });

  @override
  State<DownloadLoader> createState() => _DownloadLoaderState();
}

class _DownloadLoaderState extends State<DownloadLoader>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _textController;
  late AnimationController _scaleController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _rotationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0,
      end: 2 * 3.14159,
    ).animate(CurvedAnimation(
      parent: _rotationController,
      curve: Curves.linear,
    ));

    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    if (widget.isVisible) {
      _scaleController.forward();
      _textController.forward();
    }
  }

  @override
  void didUpdateWidget(DownloadLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentStep != oldWidget.currentStep) {
      _textController.reset();
      _textController.forward();
    }

    if (widget.isVisible != oldWidget.isVisible) {
      if (widget.isVisible) {
        _scaleController.forward();
        _textController.forward();
      } else {
        _scaleController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _textController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isVisible) return SizedBox.shrink();

    return Material(
      color: Colors.black54,
      child: Center(
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 60.w),
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 20,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Animated Loader
                // AnimatedBuilder(
                //   animation: _rotationAnimation,
                //   builder: (context, child) {
                //     return Transform.rotate(
                //       angle: _rotationAnimation.value,
                //       child: Container(
                //         width: 60,
                //         height: 60,
                //         decoration: BoxDecoration(
                //           gradient: LinearGradient(
                //             colors: [
                //               Colors.blue,
                //               Colors.purple,
                //               Colors.pink,
                //               Colors.blue,
                //             ],
                //             stops: [0.0, 0.3, 0.7, 1.0],
                //           ),
                //           shape: BoxShape.circle,
                //         ),
                //         child: Center(
                //           child: Container(
                //             width: 40,
                //             height: 40,
                //             decoration: BoxDecoration(
                //               color: Colors.white,
                //               shape: BoxShape.circle,
                //             ),
                //             child: Icon(
                //               Icons.download_rounded,
                //               color: Colors.blue,
                //               size: 24,
                //             ),
                //           ),
                //         ),
                //       ),
                //     );
                //   },
                // ),

                Container(
                  width: 48.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.primary, width: 2),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 6),
                          child: Text(
                            "PDF",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 6),
                          child: Icon(
                            Icons.picture_as_pdf_rounded,
                            size: 28,
                            color: AppColors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),


                SizedBox(height: 20.h),

                // 📄 Animated Step Text
                FadeTransition(
                  opacity: _textFadeAnimation,
                  child: Text(
                      widget.currentStep,
                    style: StyleHelper.customStyle(color: AppColors.black,family: semiBold,size: 12.sp),
                  ),
                ),

                SizedBox(height: 15.h),

                // Progress dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: _getStepIndex() > index
                            ? AppColors.primary
                            : Colors.grey[300],
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int _getStepIndex() {
    switch (widget.currentStep.toLowerCase()) {
      case 'preparing download...':
        return 0;
      case 'downloading...':
        return 1;
      case 'processing...':
        return 2;
      case 'opening...':
        return 3;
      default:
        return 0;
    }
  }
}

// Enhanced Download Functions
class DownloadController {
  static OverlayEntry? _overlayEntry;
  static String _currentStep = 'Preparing Download...';

  static void showLoader(BuildContext context) {
    hideLoader(); // Remove any existing loader

    _overlayEntry = OverlayEntry(
      builder: (context) => DownloadLoader(
        currentStep: _currentStep,
        isVisible: true,
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  static void updateStep(String step) {
    _currentStep = step;
    _overlayEntry?.markNeedsBuild();
  }

  static void hideLoader() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

// Updated Download Functions
Future<void> onDownload(BuildContext context, String pdfFileName, String url, {String? number}) async {
  try {
    if (Platform.isAndroid) {
      if (await isAndroid13OrAbove()) {
        await handleDownload(context, pdfFileName, url, number: number);
      } else {
        if (await requestPermission()) {
          await handleDownload(context, pdfFileName, url, number: number);
        } else {
          DownloadController.hideLoader();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Permission Denied"),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } else if (Platform.isIOS) {
      await handleDownloadIOS(context, pdfFileName, url, number: number);
    }
  } catch (e) {
    DownloadController.hideLoader();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Download failed: ${e.toString()}"),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> handleDownloadIOS(BuildContext context, String pdfFileName, String url, {String? number}) async {
  try {
    DownloadController.updateStep('Downloading...');

    final directory = await getApplicationDocumentsDirectory();
    final savePath = '${directory.path}/BhagyaLaxmi Milk App/$pdfFileName.pdf';

    // Create directory if it doesn't exist
    final dir = Directory('${directory.path}/BhagyaLaxmi Milk App');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    await Dio().download(url, savePath);

    DownloadController.updateStep('Processing...');
    await Future.delayed(Duration(seconds: 1)); // Processing time

    DownloadController.updateStep('Opening...');
    await Future.delayed(Duration(milliseconds: 500)); // Brief delay before opening

    DownloadController.hideLoader();

    // Small delay to ensure smooth transition
    await Future.delayed(Duration(milliseconds: 200));
    showDownloadBottomSheet(context, savePath, number: number);

  } catch (e) {
    DownloadController.hideLoader();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Download failed: ${e.toString()}"),
        backgroundColor: Colors.red,
      ),
    );
  }
}

Future<void> handleDownload(BuildContext context, String pdfFileName, String url, {String? number}) async {
  try {
    DownloadController.updateStep('Downloading...');

    final docDir = await getApplicationDocumentsDirectory();
    final directory = Platform.isAndroid
        ? Directory("/storage/emulated/0/Download/BhagyaLaxmi Milk App")
        : Directory('${docDir.path}/BhagyaLaxmi Milk App');

    // Create directory if it doesn't exist
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }

    final savePath = '${directory.path}/$pdfFileName.pdf';

    await Dio().download(url, savePath);

    DownloadController.updateStep('Processing...');
    await Future.delayed(Duration(seconds: 1)); // Processing time

    DownloadController.updateStep('Opening...');
    await Future.delayed(Duration(milliseconds: 500)); // Brief delay before opening

    DownloadController.hideLoader();

    // Small delay to ensure smooth transition
    await Future.delayed(Duration(milliseconds: 200));
    showDownloadBottomSheet(context, savePath, number: number);

  } catch (e) {
    DownloadController.hideLoader();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Download failed: ${e.toString()}"),
        backgroundColor: Colors.red,
      ),
    );
  }
}


Future<bool> isAndroid13OrAbove() async {
  return Platform.isAndroid && (await Permission.manageExternalStorage.status.isGranted);
}

Future<bool> requestPermission() async {
  final status = await Permission.manageExternalStorage.request();
  return status.isGranted;
}



Future<void> sharePDF(String filePath, {String? number}) async {
  // if(number.toString().isEmpty) {
    Share.shareXFiles([XFile(filePath)], text: "Here is your file");
  // }else {
    // try {
    //   await platform.invokeMethod("shareToWhatsApp", {
    //     "filePath": filePath,
    //     "message": "afasdfsdfdfasdfsdfasdfsdf",
    //     "phoneNumber": '91${number}',
    //   });
    // } catch (e) {
    //   print("Error sharing file to WhatsApp: $e");
    // }
  // }
}


void openPDF(String filePath){
  OpenFile.open(filePath);
}

void showDownloadBottomSheet(BuildContext context, String filePath,{String? number}) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    backgroundColor: AppColors.white,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Download Complete", style: StyleHelper.customStyle(size: 16.sp, family: bold)),
            SizedBox(height: 10.h),
            Text("File saved at: $filePath", style: StyleHelper.customStyle(size: 14.sp)),
            SizedBox(height: 20.h),

            Column(
              children: [
                GestureDetector(
                  onTap: () => openPDF(filePath),
                  child: Row(
                    children: [
                      Image.asset('assets/images/folder.png',color: AppColors.primary,height: 20.h,width: 20.h,),
                      SizedBox(width: 10.h,),
                      Expanded(child: Text("Open", style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: medium))),
                    ],
                  ),
                ),
                PaddingHorizontal15(top:8.h,bottom:8.h,child: Divider(height: 1.h,color: AppColors.primary,)),
                GestureDetector(
                  onTap: () async {
                    sharePDF(filePath, number: number);
                  },
                  child: Row(
                    children: [
                      Image.asset('assets/images/share.png',color: AppColors.primary,height: 20.h,width: 20.h,),
                      SizedBox(width: 10.h,),
                      Expanded(child: Text("Share", style: StyleHelper.customStyle(color: AppColors.black,size: 14.sp,family: medium))),
                    ],
                  ),
                ),
                PaddingHorizontal15(top:8.h,bottom:8.h,child: Divider(height: 1.h,color: AppColors.primary,)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Row(
                    children: [
                      Image.asset('assets/images/close.png',color: AppColors.errorColor,height: 20.h,width: 20.h,),
                      SizedBox(width: 10.h,),
                      Expanded(child: Text("Close", style: StyleHelper.customStyle(color: AppColors.errorColor,size: 14.sp,family: medium))),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}





