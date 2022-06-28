import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:omar_adel_posts/helpers/extensions.dart';

import '../../helpers/sized_boxes.dart';
import '../../router/custom_router.gr.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final cover = 200.sp;
  final avatar = 200.sp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          _buildTop(),
          _buildProfileInfo(),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: <Widget>[
        _buildCoverImage(),
        _buildProfileImage(),
      ],
    );
  }

  Widget _buildCoverImage() {
    return Container(
      margin: EdgeInsets.only(bottom: avatar / 2),
      width: double.infinity,
      child: Image.asset(
        'assets/images/cover.png',
        height: 200.sp,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildProfileImage() {
    final top = cover - avatar / 2;
    return Positioned(
      top: top,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/profile.png',
            fit: BoxFit.cover,
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            'Omar Adel',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileInfo() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleAvatar(
            backgroundColor: context.colorScheme.secondary,
            child: IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.edit,
              ),
              onPressed: () {
                AutoRouter.of(context).push(const MySavedPostsRoute());
              },
            ),
            radius: 25.0.sp,
          ),
          CircleAvatar(
            backgroundColor: context.colorScheme.secondary,
            child: IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.settings,
              ),
              onPressed: () {
                //AutoRouter.of(context).push( const MySettingsRoute());
              },
            ),
            radius: 25.0.sp,
          ),
          CircleAvatar(
            backgroundColor: context.colorScheme.secondary,
            child: IconButton(
              color: Colors.white,
              icon: Icon(
                Icons.star,
              ),
              onPressed: () {
                AutoRouter.of(context).push(const MySavedPostsRoute());
              },
            ),
            radius: 25.0.sp,
          ),
        ],
      ),
    );
  }
}
