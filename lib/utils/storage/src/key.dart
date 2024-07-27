part of storage;

class StorageKey {
  static const String _keyPrefix = 'key';
  static const String USERINFO = '${_keyPrefix}_user_info';
  static const String FBUSERINFO = '${_keyPrefix}_fb_user_info';
  static const String IMUSERINFO = '${_keyPrefix}_im_user_info';
  static const String FAVOURITE_EVENTS = '${_keyPrefix}_favourite_events';
  static const String CURRENCY_TYPES = '${_keyPrefix}_cureency_type';
  static const String USERNAME = '${_keyPrefix}_username';
  static const String PASSWORD = '${_keyPrefix}_password';
  static const String PHONE = '${_keyPrefix}_phone';
  static const String PHONECODE = '${_keyPrefix}_phone_code';
  static const String CHECKAUTOLOGIN = '${_keyPrefix}_auto_login';
  static const String REMEMBER_PASSWORD = '${_keyPrefix}_remember_password';

  static const String LABEL_CONTAINER = '${_keyPrefix}_label_container';
  static const String EVENT_SEARCH_HISTORY =
      '${_keyPrefix}_event_search_history';
  static const String FOLLOWING_SPORT_GAMES =
      '${_keyPrefix}_following_sport_games';

  static const String FBGAME_STATIC_LIST = '${_keyPrefix}_fb_game_static_list';
  static const String FBGAME_STATISTIC_LIST =
      '${_keyPrefix}_fb_game_statistic_list';

  static const String FB_GAME_GAME_LIST = '${_keyPrefix}_fb_game_game_list';
  static const String FB_GAME_GAME_DETAIL = '${_keyPrefix}_fb_game_game_detail';

  static const String IM_COMPETITION_COUNT =
      '${_keyPrefix}_im_composition_count';

  static const String VALID_COUNTRY = '${_keyPrefix}_valid_country';
  static const String HOTLINE_KEY = '${_keyPrefix}_hotline_key';
  static const String BASE_ICON = '${_keyPrefix}_base_icon';
  static const String START_BACKGROUND_URL =
      '${_keyPrefix}_start_background_url';
  static const String NOTICE_LIST = '${_keyPrefix}_notice_list';
}
