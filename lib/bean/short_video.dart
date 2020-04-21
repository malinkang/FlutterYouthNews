class ShortVideo {
    int behot_time;
    int comment_count;
    String description;
    int duration;
    ExtraData extra_data;
    FirstFrameImage first_frame_image;
    int id;
    int is_support;
    MediaInfo media_info;
    int play_count;
    int share_count;
    ShareInfo share_info;
    int support_count;
    ThumbImage thumb_image;
    String title;
    String video_play_url;

    ShortVideo({this.behot_time, this.comment_count, this.description, this.duration, this.extra_data, this.first_frame_image, this.id, this.is_support, this.media_info, this.play_count, this.share_count, this.share_info, this.support_count, this.thumb_image, this.title, this.video_play_url});

    factory ShortVideo.fromJson(Map<String, dynamic> json) {
        return ShortVideo(
            behot_time: json['behot_time'], 
            comment_count: json['comment_count'], 
            description: json['description'], 
            duration: json['duration'], 
            extra_data: json['extra_data'] != null ? ExtraData.fromJson(json['extra_data']) : null, 
            first_frame_image: json['first_frame_image'] != null ? FirstFrameImage.fromJson(json['first_frame_image']) : null, 
            id: json['id'], 
            is_support: json['is_support'], 
            media_info: json['media_info'] != null ? MediaInfo.fromJson(json['media_info']) : null, 
            play_count: json['play_count'], 
            share_count: json['share_count'], 
            share_info: json['share_info'] != null ? ShareInfo.fromJson(json['share_info']) : null, 
            support_count: json['support_count'], 
            thumb_image: json['thumb_image'] != null ? ThumbImage.fromJson(json['thumb_image']) : null, 
            title: json['title'], 
            video_play_url: json['video_play_url'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['behot_time'] = this.behot_time;
        data['comment_count'] = this.comment_count;
        data['description'] = this.description;
        data['duration'] = this.duration;
        data['id'] = this.id;
        data['is_support'] = this.is_support;
        data['play_count'] = this.play_count;
        data['share_count'] = this.share_count;
        data['support_count'] = this.support_count;
        data['title'] = this.title;
        data['video_play_url'] = this.video_play_url;
        if (this.extra_data != null) {
            data['extra_data'] = this.extra_data.toJson();
        }
        if (this.first_frame_image != null) {
            data['first_frame_image'] = this.first_frame_image.toJson();
        }
        if (this.media_info != null) {
            data['media_info'] = this.media_info.toJson();
        }
        if (this.share_info != null) {
            data['share_info'] = this.share_info.toJson();
        }
        if (this.thumb_image != null) {
            data['thumb_image'] = this.thumb_image.toJson();
        }
        return data;
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

class MediaInfo {
    String avatar_url;
    int id;
    String name;
    String verified_info;
    int verified_status;

    MediaInfo({this.avatar_url, this.id, this.name, this.verified_info, this.verified_status});

    factory MediaInfo.fromJson(Map<String, dynamic> json) {
        return MediaInfo(
            avatar_url: json['avatar_url'], 
            id: json['id'], 
            name: json['name'], 
            verified_info: json['verified_info'], 
            verified_status: json['verified_status'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['avatar_url'] = this.avatar_url;
        data['id'] = this.id;
        data['name'] = this.name;
        data['verified_info'] = this.verified_info;
        data['verified_status'] = this.verified_status;
        return data;
    }
}

class ThumbImage {
    int height;
    String url;
    int width;

    ThumbImage({this.height, this.url, this.width});

    factory ThumbImage.fromJson(Map<String, dynamic> json) {
        return ThumbImage(
            height: json['height'], 
            url: json['url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['height'] = this.height;
        data['url'] = this.url;
        data['width'] = this.width;
        return data;
    }
}

class FirstFrameImage {
    int height;
    String url;
    int width;

    FirstFrameImage({this.height, this.url, this.width});

    factory FirstFrameImage.fromJson(Map<String, dynamic> json) {
        return FirstFrameImage(
            height: json['height'], 
            url: json['url'], 
            width: json['width'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['height'] = this.height;
        data['url'] = this.url;
        data['width'] = this.width;
        return data;
    }
}

class ShareInfo {
    String cover_image;
    String desc;
    String share_url;
    String title;

    ShareInfo({this.cover_image, this.desc, this.share_url, this.title});

    factory ShareInfo.fromJson(Map<String, dynamic> json) {
        return ShareInfo(
            cover_image: json['cover_image'], 
            desc: json['desc'], 
            share_url: json['share_url'], 
            title: json['title'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['cover_image'] = this.cover_image;
        data['desc'] = this.desc;
        data['share_url'] = this.share_url;
        data['title'] = this.title;
        return data;
    }
}