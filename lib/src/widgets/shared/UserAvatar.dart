import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserAvatar extends StatelessWidget {
  final String? userImageUrl;
  final GestureTapCallback? onTap;
  const UserAvatar({Key? key, required this.userImageUrl, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageProvider image;
    if (userImageUrl != null) {
      image = NetworkImage(userImageUrl!);
    } else {
      image = const AssetImage("assets/user.png");
    }
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      padding: EdgeInsets.all(2.sp),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: image,
            fit: BoxFit.fill,
          ),
        ),
        height: 50.h,
        width: 50.h,
      ),
    );
  }
}
