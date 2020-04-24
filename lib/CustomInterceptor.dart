import 'dart:collection';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

class CustomInterceptor extends InterceptorsWrapper {
  var VERSION2_KEY = "jdvylqchJZrfw0o2DgAbsmCGUapF1YChc";
  var VERSION6_KEY = "zWpfzystJLrfw7o3SgGlMmGGPupK2YLhB";

  var VERSION15_KEY =
      "AAAAB3NzaC1yc2EAAAADAQABAAABAQC1WAth281wjZj5XhGU9Iza5EXzOy5U/AKgGxF14svnCEWrTH6i3lZd+lMTFLvTakGI5l1RJmutFRku6CvDVCEc7dJURVWsrgQTFNBuu0t5WOkoUY0zNa05pejDmBC4w4MscH2OexCrKfHNEYi/FpjBJv1bwjU0luxt/cvsjBjlthgY47I4KNy+T953CpBiYQmkSJZUBzsN2Zz+jEA+CvLEK9BPHBlKcz0GupalgnHHSnS/JoUz8+RTjZr1O2sjSyrcg0LL+vWeCnJN07Uv4jJaTDqc6Ig1Mw+TJrrsARxoA+Frc66Qo7GFxACimuJ1LeCc9iFlMzZNZly3JxYAR019";

  @override
  Future onRequest(RequestOptions options) async {
    var version = options.path.split("/")[0]; //获取版本号
    var extraParams = getExtraParams(version); //获取公共参数
    var method = options.method;
    if (method == "POST") {
      if (options.data is FormData) {
        Map<String, dynamic> map = new Map();
        for (var value in (options.data as FormData).fields) {
          map['${value.key}'] = "${value.value}";
        }
        extraParams.addAll(map);
      }
      var map2 = encrypt(version, extraParams);
      options.data = FormData.fromMap(map2);
    } else {
      extraParams.addAll(options.queryParameters); //添加原参数
      options.queryParameters = encrypt(version, extraParams);
    }
    return options;
  }

  Map<String, dynamic> encrypt(
      String version, Map<String, dynamic> extraParams) {
    var sb = new StringBuffer();
    //使用TreeMap排序
    SplayTreeMap.from(extraParams).forEach((key, value) {
      sb.write(key);
      sb.write("=");
      sb.write(value);
    });
    switch (version.toLowerCase()) {
      case "v1":
      case "v2":
      case "v3":
      case "v4":
        var sign =
            md5.convert(utf8.encode(sb.toString() + VERSION2_KEY)).toString();
        extraParams['sign'] = sign;
        return extraParams;
      case "v6":
      case "v14":
        var sign =
            md5.convert(utf8.encode(sb.toString() + VERSION6_KEY)).toString();
        extraParams['token'] = sign;
        return extraParams;
      case "v15":
      case "v16":
      case "v17":
        //jwt写死
        extraParams['token'] =
            "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJhYyI6IjEiLCJhbmRyb2lkaWQiOiIzYzNhNTQ5NDM3NjY4NDEwIiwiYXBwX25hbWUiOiJ6cWtkX2FwcCIsImJlaG90X3RpbWUiOiIxNTg3NDU4OTIxNDE1IiwiY2hhbm5lbCI6ImMxMDIzIiwiY291bnQiOiIxMCIsImRldmljZV9icmFuZCI6Ik9uZVBsdXMiLCJkZXZpY2VfcGxhdGZvcm0iOiJhbmRyb2lkIiwiZGV2aWNlX3R5cGUiOiJPbmVQbHVzNiIsImRwaSI6IjQyMCIsImd0X3VpZCI6ImI3MmZjNGY2NTMyN2ZkODFlODRlMzJlMWQ4NDk0NDA5IiwiaW5uZXJfdmVyc2lvbiI6IjIwMjAwNDIxMTY0OCIsImxhbmd1YWdlIjoiemgiLCJtaSI6IjAiLCJtb2JpbGVfdHlwZSI6IjEiLCJuZXRfdHlwZSI6IjEiLCJvYWlkIjoiQjM2MUM4MURDQ0U2NkExNzYwQzA2NkQ4NEE1RkQyMEZGNTg3NDUwNzRFRUZCNzQ5QzQ5MTlFRDYwQURGQzhDOCIsIm9wIjoiMCIsIm9wZW51ZGlkIjoiM2MzYTU0OTQzNzY2ODQxMCIsIm9zX2FwaSI6IjI5Iiwib3NfdmVyc2lvbiI6Ik9ORVBMVVMrQTYwMDBfMjJfMjAwMzI0IiwicmVzb2x1dGlvbiI6IjEwODAuMCoyMDc1LjAiLCJzbV9kZXZpY2VfaWQiOiIyMDIwMDExNTE1MDczNTg0NDYxZTcxMTdlNmMyZDkzNmQxZDc2ZDVlNGU0NWQ3MDE0ZjM4YjQ4OTcwODQxYiIsInN6bG1fZGRpZCI6IkR1WnJicUV0SlJJZkJxQzVVeVdOaUZZNEZqczJ1SkVvMkU4MVlQS291RmFvYndNZmRjeXdqaE9pT0F6TE1mTTdGN0lxREtpZ29lejBCZHJnN0hsbHFUSmciLCJ0cyI6IjE1ODc0NjA4NDEiLCJ0eXBlIjoiMyIsInVpZCI6IjQ1MzUyNzYxIiwidmVyc2lvbl9jb2RlIjoiNDYiLCJ2ZXJzaW9uX25hbWUiOiIyLjAuMiIsInpxa2V5IjoiTURBd01EQXdNREF3TUpDTXBOLXcwOVd0ZzUtQmIzNmVoNkNQcUh1YWxJZWpscS1Gc1dPd3paZHJoSXlwNExEUHlHbDlvbnFrajNacVlKYThZODk4bmFqV3NKdXBZN0tubDJtRmpKeWJyOS11YXBxR2NYWSIsInpxa2V5X2lkIjoiODllZDIwNjFkZGQzZDY3MDc1MjllZjJiNTY3M2ZkZmIifQ.5y-UbRoZ6mkAKwbCM7S8h99RfHmqLdFoODawoiXc-lGVwBylWl8tTtju9cqQkLpd3l8g4c19kDYmKGds2erDdA";
        return extraParams;
    }
  }

  Map<String, dynamic> getExtraParams(String version) {
    switch (version.toLowerCase()) {
      case "v1":
      case "v2":
        return getV2Params();
      case "v3":
        return getV3Params();
      case "v6":
      case "v14":
        return getV6Params();
      case "v16":
        return getV16Params();
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
      "app-version": "2.0.2",
      "app_version": "2.0.2",
      "carrier": "CHN-UNICOM",
      "channel": "c1023",
      "device_brand": "OnePlus",
      "device_id": "40773822",
      "device_model": "ONEPLUS A6000",
      "device_platform": "android",
      "device_type": "android",
      "gt_uid": "b72fc4f65327fd81e84e32e1d8494409",
      "imei": "null",
      "inner_version": "202004231402",
      "mc": "02:00:00:00:00:00",
      "mi": "0",
      "mobile_type": "1",
      "net_type": "1",
      "oaid":
          "B361C81DCCE66A1760C066D84A5FD20FF58745074EEFB749C4919ED60ADFC8C8",
      "openudid": "3c3a549437668410",
      "os_api": "29",
      "os_version": "ONEPLUS A6000_22_200324",
      "request_time": "1587622057",
      "resolution": "1080.0x2075.0",
      "sim": "1",
      "sm_device_id":
          "2020011515073584461e7117e6c2d936d1d76d5e4e45d7014f38b48970841b",
      "subv": "1.2.2",
      "szlm_ddid":
          "DuZrbqEtJRIfBqC5UyWNiFY4Fjs2uJEo2E81YPKouFaobwMfdcywjhOiOAzLMfM7F7IqDKigoez0Bdrg7HllqTJg",
      "uid": "45352761",
      "version_code": "46",
      "zqkey":
          "MDAwMDAwMDAwMJCMpN-w09Wtg5-Bb36eh6CPqHualIejlq-FsWOwzZdrhIyp4LDPyGl9onqkj3ZqYJa8Y898najWsJupY7Knl2uEon7dr7nEapqGcXY",
      "zqkey_id": "861943fb637c2ac34de2f0ef20c9081b"
    };
  }

  Map<String, dynamic> getV16Params() {
    return {
      "ac": "1",
      "androidid": "3c3a549437668410",
      "app_name": "zqkd_app",
      "channel": "c1023",
      "device_brand": "OnePlus",
      "device_platform": "android",
      "device_type": "OnePlus6",
      "dpi": "420",
      "gt_uid": "b72fc4f65327fd81e84e32e1d8494409",
      "imei": "null",
      "inner_version": "202004211648",
      "language": "zh",
      "mi": "0",
      "mobile_type": "1",
      "net_type": "1",
      "oaid":
          "B361C81DCCE66A1760C066D84A5FD20FF58745074EEFB749C4919ED60ADFC8C8",
      "openudid": "3c3a549437668410",
      "os_api": "29",
      "os_version": "ONEPLUS A6000_22_200324",
      "resolution": "1080.0*2075.0",
      "sm_device_id":
          "2020011515073584461e7117e6c2d936d1d76d5e4e45d7014f38b48970841b",
      "szlm_ddid":
          "DuZrbqEtJRIfBqC5UyWNiFY4Fjs2uJEo2E81YPKouFaobwMfdcywjhOiOAzLMfM7F7IqDKigoez0Bdrg7HllqTJg",
      "ts": "1587460841",
      "uid": "45352761",
      "version_code": "46",
      "version_name": "2.0.2",
      "zqkey":
          "MDAwMDAwMDAwMJCMpN-w09Wtg5-Bb36eh6CPqHualIejlq-FsWOwzZdrhIyp4LDPyGl9onqkj3ZqYJa8Y898najWsJupY7Knl2mFjJybr9-uapqGcXY",
      "zqkey_id": "89ed2061ddd3d6707529ef2b5673fdfb"
    };
  }
}
