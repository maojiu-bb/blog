import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectPage extends GetView<ProjectController> {
  const ProjectPage({super.key});

  Widget _buildView() {
    return CustomScrollView(
      slivers: [
        sliverAppBar(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildView(),
      ),
    );
  }
}
