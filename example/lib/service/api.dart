import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/repo.dart';

Future<List<GithubRepo>> getRepos(int page) async {
  final url =
      'https://api.github.com/search/repositories?q=go+language:go&sort=stars&order=desc&page=$page';
  final res = await http.get(Uri.parse(url));
  Map<String, dynamic> body = json.decode(res.body);

  return (body['items'] as List)
      .map((item) => GithubRepo.fromJson(item))
      .toList();
}
