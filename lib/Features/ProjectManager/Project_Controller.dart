import 'package:flutter/material.dart';
import '../../Constants/ApiService.dart';
import '../../Constants/ApiConstants.dart';
import 'ProjectModal.dart';



class ProjectController extends ChangeNotifier {
  final ApiService _api = ApiService();
  bool loading = false;

  List<Project> projects = [];

  Future<void> fetchProjects() async {
    loading = true;
    notifyListeners();

    final res = await _api.get(ApiConstants.projects);
    final List data = res.data['data'];

    projects = data.map((e) => Project.fromJson(e)).toList();

    loading = false;
    notifyListeners();
  }
}
