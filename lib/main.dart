import 'dart:io';

import 'package:api_handler/core/token/token.dart';
import 'package:api_handler/feature/api_handler/presentation/presentation_usecase.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feature/api_handler/data/enums/header_enum.dart';
import 'feature/api_handler/data/enums/response_enum.dart';
import 'feature/api_handler/data/enums/result_enums.dart';
import 'feature/api_handler/data/models/response_model.dart';

void main() async {
  var deviceInfo = DeviceInfoPlugin();
  if (Platform.isIOS) {
    var iosDeviceInfo = await deviceInfo.iosInfo;
    deviceID = iosDeviceInfo.identifierForVendor ?? 'API-HANDLER-IOS-DEVICE-ID';
  } else if (Platform.isAndroid) {
    var androidDeviceInfo = await deviceInfo.androidInfo;
    deviceID = androidDeviceInfo.id;
  }
  await Future.delayed(const Duration(milliseconds: 200));
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _ 3_');
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _ 46_');
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _45 _');
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _4 _');
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _ 3_');
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _ _2');
  print(deviceID);
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _ _');
  print(' _ __ _ _ ___ _ _ _ _ _ __ _ _ _ _ _ __ _ __ _ _ __ _ _ _ _##');
  runApp(mainpage());
}

String deviceID = '';

class mainpage extends StatefulWidget {
  const mainpage({Key? key}) : super(key: key);

  @override
  State<mainpage> createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Page(),
    );
  }
}

class Page extends StatefulWidget {
  const Page({Key? key}) : super(key: key);

  @override
  State<Page> createState() => _PageState();
}

class _PageState extends State<Page> {
  APIHandler api = APIHandler();
  @override
  void initState() {
    // TODO: implement initState
    // Token.token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2Njk2Mzc4NDUsInVzZXJfaWQiOiI3OTZhZWU2ZS00NWNhLTQwNjMtYmQwYS03ODY1Y2Q4NzU3ZTIiLCJ0ZW5hbnRfaWQiOiI1YmU0NGY0MC02MjJmLTQ0NjUtOWExYy0wMDNmOWI0MjU0MjgiLCJ1c2VyX3R5cGUiOiJ1c2VyIn0.RvjalVAnqWHcLAsuyF4Mgib1dvETlLRPRBcp9ex_C-Q";
    api.setToken(
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2Njk2Mzc4NDUsInVzZXJfaWQiOiI3OTZhZWU2ZS00NWNhLTQwNjMtYmQwYS03ODY1Y2Q4NzU3ZTIiLCJ0ZW5hbnRfaWQiOiI1YmU0NGY0MC02MjJmLTQ0NjUtOWExYy0wMDNmOWI0MjU0MjgiLCJ1c2VyX3R5cGUiOiJ1c2VyIn0.RvjalVAnqWHcLAsuyF4Mgib1dvETlLRPRBcp9ex_C-Q");

    mine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  Future<ResponseModel> mine() async {
    ResponseModel response = await api.get(
      "https://stg.mydoci.app/api/v1/package/mine",
      headerEnum: HeaderEnum.bearerHeaderEnum,
      responseEnum: ResponseEnum.responseModelEnum,
    );

    if (response.result == ResultEnum.SUCCESS) {
      print(response);
    }

    return response;
  }
}
