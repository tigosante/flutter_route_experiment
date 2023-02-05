enum RouteEnum {
  home("/", "home"),
  user("user", "user"),
  profile("profile", "profile"),
  login("login", "login"),
  notFound("404", "notFound");

  final String path;
  final String name;

  const RouteEnum(this.path, this.name);
}
