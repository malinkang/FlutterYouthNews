class Claim {
    String ac;
    String androidid;
    String app_name;
    String channel;
    String device_brand;
    String device_platform;
    String device_type;
    String dpi;
    String gt_uid;
    String imei;
    String inner_version;
    String language;
    String mi;
    String mobile_type;
    String net_type;
    String oaid;
    String openudid;
    String os_api;
    String os_version;
    String resolution;
    String sm_device_id;
    String szlm_ddid;
    String ts;
    String uid;
    String version_code;
    String version_name;
    String zqkey;
    String zqkey_id;

    Claim({this.ac, this.androidid, this.app_name, this.channel, this.device_brand, this.device_platform, this.device_type, this.dpi, this.gt_uid, this.imei, this.inner_version, this.language, this.mi, this.mobile_type, this.net_type, this.oaid, this.openudid, this.os_api, this.os_version, this.resolution, this.sm_device_id, this.szlm_ddid, this.ts, this.uid, this.version_code, this.version_name, this.zqkey, this.zqkey_id});

    factory Claim.fromJson(Map<String, dynamic> json) {
        return Claim(
            ac: json['ac'], 
            androidid: json['androidid'], 
            app_name: json['app_name'], 
            channel: json['channel'], 
            device_brand: json['device_brand'], 
            device_platform: json['device_platform'], 
            device_type: json['device_type'], 
            dpi: json['dpi'], 
            gt_uid: json['gt_uid'], 
            imei: json['imei'], 
            inner_version: json['inner_version'], 
            language: json['language'], 
            mi: json['mi'], 
            mobile_type: json['mobile_type'], 
            net_type: json['net_type'], 
            oaid: json['oaid'], 
            openudid: json['openudid'], 
            os_api: json['os_api'], 
            os_version: json['os_version'], 
            resolution: json['resolution'], 
            sm_device_id: json['sm_device_id'], 
            szlm_ddid: json['szlm_ddid'], 
            ts: json['ts'], 
            uid: json['uid'], 
            version_code: json['version_code'], 
            version_name: json['version_name'], 
            zqkey: json['zqkey'], 
            zqkey_id: json['zqkey_id'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['ac'] = this.ac;
        data['androidid'] = this.androidid;
        data['app_name'] = this.app_name;
        data['channel'] = this.channel;
        data['device_brand'] = this.device_brand;
        data['device_platform'] = this.device_platform;
        data['device_type'] = this.device_type;
        data['dpi'] = this.dpi;
        data['gt_uid'] = this.gt_uid;
        data['imei'] = this.imei;
        data['inner_version'] = this.inner_version;
        data['language'] = this.language;
        data['mi'] = this.mi;
        data['mobile_type'] = this.mobile_type;
        data['net_type'] = this.net_type;
        data['oaid'] = this.oaid;
        data['openudid'] = this.openudid;
        data['os_api'] = this.os_api;
        data['os_version'] = this.os_version;
        data['resolution'] = this.resolution;
        data['sm_device_id'] = this.sm_device_id;
        data['szlm_ddid'] = this.szlm_ddid;
        data['ts'] = this.ts;
        data['uid'] = this.uid;
        data['version_code'] = this.version_code;
        data['version_name'] = this.version_name;
        data['zqkey'] = this.zqkey;
        data['zqkey_id'] = this.zqkey_id;
        return data;
    }
}