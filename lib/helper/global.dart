class GlobalConst {
  static const String HOME = "Home";

  // static const String ELECTRICAL_CATEGORIES = "https://blog.voltagelab.com/wp-json/wp/v2/posts?per_page=10";
  static const String ELECTRICAL_CATEGORIES =
      "https://blog.voltagelab.com/wp-json/wp/v2/posts?categories=15&per_page=1&offset=1&_fields[]=id&_fields[]=title&_fields[]";
  static const String VL_CAT_BASE_URL =
      "https://blog.voltagelab.com/wp-json/wp/v2/posts?categories="; // get id, title , filter category wise , filter total number post
  static const String VL_CAT_PER_PAGE = "&per_page=";
  static const String VL_CAT_OFFSET = "&offset=";
  static const String VL_CAT_AFTER_OFFSET =
      "&_fields[]=id&_fields[]=title&_fields[]";
  static const String BN_REGULAR = "solaimanlipi";
}
