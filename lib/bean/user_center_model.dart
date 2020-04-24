class UserCenterModel {
    List<ItemData> item_data;
    String item_title;
    String item_type;

    UserCenterModel({this.item_data, this.item_title, this.item_type});

    factory UserCenterModel.fromJson(Map<String, dynamic> json) {
        return UserCenterModel(
            item_data: json['item_data'] != null ? (json['item_data'] as List).map((i) => ItemData.fromJson(i)).toList() : null, 
            item_title: json['item_title'], 
            item_type: json['item_type'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['item_title'] = this.item_title;
        data['item_type'] = this.item_type;
        if (this.item_data != null) {
            data['item_data'] = this.item_data.map((v) => v.toJson()).toList();
        }
        return data;
    }
}

class ItemData {
    String action;
    String desc;
    String forbid_screenshot;
    String image;
    String is_login;
    String is_wap;
    String name;
    String show_red_point;
    String text;
    String url;

    ItemData({this.action, this.desc, this.forbid_screenshot, this.image, this.is_login, this.is_wap, this.name, this.show_red_point, this.text, this.url});

    factory ItemData.fromJson(Map<String, dynamic> json) {
        return ItemData(
            action: json['action'], 
            desc: json['desc'], 
            forbid_screenshot: (json['forbid_screenshot'] is String)?json['forbid_screenshot']:json['forbid_screenshot'].toString(),
            image: json['image'], 
            is_login: (json['is_login'] is String)?json['is_login']:json['is_login'].toString(),
            is_wap:  (json['is_wap'] is String)?json['is_wap']:json['is_wap'].toString(),
            name: json['name'], 
            show_red_point: (json['show_red_point'] is String)?json['show_red_point']:json['show_red_point'].toString(),
            text: json['text'], 
            url: json['url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['action'] = this.action;
        data['desc'] = this.desc;
        data['forbid_screenshot'] = this.forbid_screenshot;
        data['image'] = this.image;
        data['is_login'] = this.is_login;
        data['is_wap'] = this.is_wap;
        data['name'] = this.name;
        data['show_red_point'] = this.show_red_point;
        data['text'] = this.text;
        data['url'] = this.url;
        return data;
    }
}