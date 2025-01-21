import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quran/core/constant/appcolors/appcolors.dart';

class CustomSearchBar extends StatelessWidget {
  final void Function(String)? func;
  final void Function() btnFunc;
  final void Function()? testFunc;
  final TextEditingController? feildControl;

  const CustomSearchBar({
    super.key,
    required this.btnFunc,
    this.func,
    this.testFunc,
    this.feildControl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
      margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.sp)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              child: TextFormField(
            controller: feildControl,
            onEditingComplete: testFunc,

            // onChanged: func,
            decoration: InputDecoration(
                hintText: "بحث",
                hintStyle: TextStyle(fontSize: 14.sp),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search_outlined),
                  onPressed: () {},
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true,
                fillColor: AppColors.bgColorLightGreen),
          )),
          IconButton(
              onPressed: btnFunc,
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 30.sp,
                color: AppColors.bgColorLightGreen,
              ))
        ],
      ),
    );
  }
}
