import 'package:finstagram/services/firebase_service.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double? _deviceHeight, _deviceWidth;
  FirebaseService? _firebaseService;

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: _deviceWidth! * 0.05,
        vertical: _deviceHeight! * 0.02,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [],
      ),
    );
  }

  Widget _profileImage() {
    return Container(
      height: _deviceHeight! * 0.15,
      width: _deviceHeight! * 0.15,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: NetworkImage(
          _firebaseService!.currentUser!["image"],
        ),
      )),
    );
  }
}
