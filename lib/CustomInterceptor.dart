import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends InterceptorsWrapper {
  var VERSION2_KEY = "jdvylqchJZrfw0o2DgAbsmCGUapF1YChc";

  @override
  Future onRequest(RequestOptions options) async {
    print("method = " + options.method);
    print("baseUrl = " + options.baseUrl);
    print("path = " + options.path);
    var version = options.path.split("/")[0]; //获取版本号
    var extraParams = getExtraParams(version); //获取公共参数
    extraParams.addAll(options.queryParameters); //添加原参数
    var sb = new StringBuffer();
    SplayTreeMap.from(extraParams).forEach((key, value) {
      sb.write(key);
      sb.write("=");
      sb.write(value);
    });
    var sign =
        md5.convert(utf8.encode(sb.toString() + VERSION2_KEY)).toString();
    extraParams['sign'] = sign;
    options.queryParameters = extraParams;
    return options;
  }

  Map<String, dynamic> getExtraParams(String version) {
    switch (version.toLowerCase()) {
      case "v1":
      case "v2":
        return getV2Params();
      case "v3":
        return getV3Params();
    }
  }

  Map<String, dynamic> getV2Params() {
    return {
      "androidid": "3c3a549437668410",
      "carrier": "CHN-UNICOM",
      "channel_code": "c1023",
      "client_version": "1.9.3",
      "debug": "1",
      "device_id": "40773822",
      "device_platform": "android",
      "device_type": "2",
      "gt_uid": "null",
      "imei": "null",
      "inner_version": "202004131951",
      "mi": "0",
      "mobile_type": "1",
      "net_type": "1",
      "oaid":
          "B361C81DCCE66A1760C066D84A5FD20FF58745074EEFB749C4919ED60ADFC8C8",
      "phone_code": "3c3a549437668410",
      "phone_network": "WIFI",
      "phone_sim": "1",
      "request_time": "1586779268",
      "sm_device_id":
          "2020011515073584461e7117e6c2d936d1d76d5e4e45d7014f38b48970841b",
      "szlm_ddid":
          "DuZrbqEtJRIfBqC5UyWNiFY4Fjs2uJEo2E81YPKouFaobwMfdcywjhOiOAzLMfM7F7IqDKigoez0Bdrg7HllqTJg",
      "uid": "45352761",
      "uuid": "a6d332c053574c0694c89747e4884cb5",
      "zqkey":
          "MDAwMDAwMDAwMJCMpN-w09Wtg5-Bb36eh6CPqHualIejlq-FsWOwzZdrhIyp4LDPyGl9onqkj3ZqYJa8Y898najWsJupY7KnjWyFspybsKnIapqGcXY",
      "zqkey_id": "64dc4290928c3ff164d35788c5e0c6a7",
    };
  }

  Map<String, dynamic> getV3Params() {
    return {
      "access": "WIFI",
      "androidid": "3c3a549437668410",
      "app_version": "1.9.3",
      "carrier": "CHN-UNICOM",
      "channel": "c1023",
      "debug": "1",
      "device_id": "40773822",
      "device_model": "ONEPLUS A6000",
      "device_platform": "android",
      "gt_uid": "null",
      "iid": "0",
      "imei": "null",
      "inner_version": "202004131951",
      "mi": "0",
      "mobile_type": "1",
      "net_type": "1",
      "oaid":
          "B361C81DCCE66A1760C066D84A5FD20FF58745074EEFB749C4919ED60ADFC8C8",
      "openudid": "3c3a549437668410",
      "os_api": "29",
      "os_version": "ONEPLUS A6000_22_200324",
      "phone_sim": "1",
      "request_time": "1586778988",
      "sm_device_id":
          "2020011515073584461e7117e6c2d936d1d76d5e4e45d7014f38b48970841b",
      "szlm_ddid":
          "DuZrbqEtJRIfBqC5UyWNiFY4Fjs2uJEo2E81YPKouFaobwMfdcywjhOiOAzLMfM7F7IqDKigoez0Bdrg7HllqTJg",
      "uid": "45352761",
      "version_code": "43",
      "zqkey":
          "MDAwMDAwMDAwMJCMpN-w09Wtg5-Bb36eh6CPqHualq2jmrCarWKxt4FqhKKYmK64qmqXr6NthJl7mI-shMmXeqDau4StacS3o7GFjJyYr9_EZ4OJibCEY2Ft",
      "zqkey_id": "4350e71a53737607dae47658928a2a13"
    };
  }

  Map<String, dynamic> getV5Params() {
    return {
      "androidid": "3c3a549437668410",
      "app_version": "1.9.3",
      "channel": "c1023",
      "device_id": "40773822",
      "device_platform": "android",
      "gt_uid": "null",
      "imei": "null",
      "inner_version": "202004131951",
      "mi": "0",
      "mobile_type": "1",
      "net_type": "1",
      "oaid":
          "B361C81DCCE66A1760C066D84A5FD20FF58745074EEFB749C4919ED60ADFC8C8",
      "request_time": "1586778988",
      "sm_device_id":
          "2020011515073584461e7117e6c2d936d1d76d5e4e45d7014f38b48970841b",
      "szlm_ddid":
          "DuZrbqEtJRIfBqC5UyWNiFY4Fjs2uJEo2E81YPKouFaobwMfdcywjhOiOAzLMfM7F7IqDKigoez0Bdrg7HllqTJg",
      "uid": "45352761",
      "zqkey":
          "MDAwMDAwMDAwMJCMpN-w09Wtg5-Bb36eh6CPqHualq2jmrCarWKxt4FqhKKYmK64qmqXr6NthJl7mI-shMmXeqDau4StacS3o7GFjJyYr9_EZ4OJibCEY2Ft",
      "zqkey_id": "4350e71a53737607dae47658928a2a13",
    };
  }

  Map<String, dynamic> getV6Params() {
    return {
      "access": "WIFI",
      "androidid": "3c3a549437668410",
      "app-version": "1.9.3",
      "app_version": "1.9.3",
      "carrier": "CHN-UNICOM",
      "channel": "c1023",
      "device_brand": "OnePlus",
      "device_id": "40773822",
      "device_model": "ONEPLUS A6000",
      "device_platform": "android",
      "device_type": "android",
      "gt_uid": "null",
      "imei": "null",
      "inner_version": "202004131951",
      "mc": "02:00:00:00:00:00",
      "mi": "0",
      "mobile_type": "1",
      "net_type": "1",
      "oaid":
          "B361C81DCCE66A1760C066D84A5FD20FF58745074EEFB749C4919ED60ADFC8C8",
      "openudid": "3c3a549437668410",
      "os_api": "29",
      "os_version": "ONEPLUS A6000_22_200324",
      "request_time": "1586778988",
      "resolution": "1080.0x2075.0",
      "sim": "1",
      "sm_device_id":
          "2020011515073584461e7117e6c2d936d1d76d5e4e45d7014f38b48970841b",
      "subv": "1.2.2",
      "szlm_ddid":
          "DuZrbqEtJRIfBqC5UyWNiFY4Fjs2uJEo2E81YPKouFaobwMfdcywjhOiOAzLMfM7F7IqDKigoez0Bdrg7HllqTJg",
      "uid": "45352761",
      "version_code": "43",
      "zqkey":
          "MDAwMDAwMDAwMJCMpN-w09Wtg5-Bb36eh6CPqHualq2jmrCarWKxt4FqhKKYmK64qmqXr6NthJl7mI-shMmXeqDau4StacS3o7GFjJyYr9_EZ4OJibCEY2Ft",
      "zqkey_id": "4350e71a53737607dae47658928a2a13"
    };
  }
}
