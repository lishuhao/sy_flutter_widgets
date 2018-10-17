class GithubRepo {
  String name;
  String description;
  int star;
  String avatar;

  GithubRepo({this.name, this.description, this.star, this.avatar});

  factory GithubRepo.fromJson(Map<String, dynamic> json) => GithubRepo(
      name: json['name'],
      description: json['description'],
      star: json['stargazers_count'],
      avatar: json['owner']['avatar_url']);
}
