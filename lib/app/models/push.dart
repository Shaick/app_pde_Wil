class Push {
  final String? appId;
  final List<String>? includePlayers;
  final Map? contents;
  final Map? headings;
  final Map? data;
  final String? androidLedColor;
  final String? androidAccentColor;
  final String? androidChannelId;

  Push(
      {this.appId,
      this.includePlayers,
      this.contents,
      this.headings,
      this.data,
      this.androidAccentColor,
      this.androidLedColor,
      this.androidChannelId});

  factory Push.fromJson(Map<String, dynamic> json) {
    return Push(
      appId: json['app_id'],
      includePlayers: json['include_player_ids'],
      contents: json['contents'],
      headings: json['headings'],
      data: json['data'],
      androidLedColor: json['android_led_color'],
      androidAccentColor: json['android_accent_color'],
      androidChannelId: json['android_channel_id'],
    );
  }
}
