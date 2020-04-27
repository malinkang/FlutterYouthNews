class Article {
  String account_id;
  String account_name;
  String article_id;
  String article_type;
  int behot_time;
  String catid;
  String catname;
  String cmt_num;
  int ctype;
  String description;
  String detail_url;
  List<String> extra;
  ExtraData extra_data;
  String id;
  String image_type;
  int input_time;
  String is_cache;
  String is_timely;
  int isext;
  String oid;
  String op_mark;
  String op_mark_icolor;
  String op_mark_iurl;
  String read_num;
  String share_abstract;
  String share_cover_image;
  String share_num;
  String tagid;
  String thumb;
  String tip;
  String title;
  String url;
  String wurl;
  String video_time;
  String video_play_url;

  Article(
      {this.account_id,
      this.account_name,
      this.article_id,
      this.article_type,
      this.behot_time,
      this.catid,
      this.catname,
      this.cmt_num,
      this.ctype,
      this.description,
      this.detail_url,
      this.extra,
      this.extra_data,
      this.id,
      this.image_type,
      this.input_time,
      this.is_cache,
      this.is_timely,
      this.isext,
      this.oid,
      this.op_mark,
      this.op_mark_icolor,
      this.op_mark_iurl,
      this.read_num,
      this.share_abstract,
      this.share_cover_image,
      this.share_num,
      this.tagid,
      this.thumb,
      this.tip,
      this.title,
      this.url,
      this.wurl,
      this.video_time,
      this.video_play_url});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      account_id: json['account_id'],
      account_name: json['account_name'],
      article_id: json['article_id'],
      article_type: json['article_type'],
      behot_time: json['behot_time'],
      catid: json['catid'],
      catname: json['catname'],
      cmt_num: json['cmt_num'],
      ctype: json['ctype'],
      description: json['description'],
      detail_url: json['detail_url'],
      extra: json['extra'] != null
          ? List<String>.from(json['extra'] as List)
          : null,
      extra_data: json['extra_data'] != null
          ? ExtraData.fromJson(json['extra_data'])
          : null,
      id: json['id'],
      image_type: json['image_type'] is String
          ? json['image_type']
          : json['image_type'].toString(),
      input_time: json['input_time'],
      is_cache: json['is_cache'],
      is_timely: json['is_timely'],
      isext: json['isext'],
      oid: json['oid'],
      op_mark: json['op_mark'],
      op_mark_icolor: json['op_mark_icolor'],
      op_mark_iurl: json['op_mark_iurl'],
      read_num: json['read_num'] is String
          ? json['read_num']
          : json['read_num'].toString(),
      share_abstract: json['share_abstract'],
      share_cover_image: json['share_cover_image'],
      share_num: json['share_num'],
      tagid: json['tagid'],
      thumb: json['thumb'],
      tip: json['tip'],
      title: json['title'],
      url: json['url'],
      wurl: json['wurl'],
      video_time: json['video_time'],
      video_play_url: json['video_play_url'],
    );
  }
}

class ExtraData {
  String exp_id;
  String log_id;
  String retrieve_id;
  String strategy_id;

  ExtraData({this.exp_id, this.log_id, this.retrieve_id, this.strategy_id});

  factory ExtraData.fromJson(Map<String, dynamic> json) {
    return ExtraData(
      exp_id: json['exp_id'],
      log_id: json['log_id'],
      retrieve_id: json['retrieve_id'],
      strategy_id: json['strategy_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['exp_id'] = this.exp_id;
    data['log_id'] = this.log_id;
    data['retrieve_id'] = this.retrieve_id;
    data['strategy_id'] = this.strategy_id;
    return data;
  }
}
