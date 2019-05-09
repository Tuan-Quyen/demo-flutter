class BaseUrl {
  static final String baseurl = "https://api.stackexchange.com/2.2/";
  static final String key = "&key=mq*Z3A9J)zXCIsTkyU9TQA((";

  static String questionRequest(int page,String sort) {
    return baseurl +
        "questions?page=$page&pagesize=15&order=desc&sort=$sort&site=stackoverflow" +
        key;
  }

  static String siteImage(int page) {
    return baseurl + "sites?page=$page&pagesize=50" + key;
  }

  static String userImage(){
    return baseurl + "users?site=stackoverflow&sort=reputation&pagesize=100" + key;
  }
}
