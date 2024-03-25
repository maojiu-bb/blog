import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BlogPage extends GetView<BlogController> {
  const BlogPage({super.key});

  Widget _buildMain() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          const SizedBox(height: 50),
          for (var i = 0; i < 6; i++)
            const BlogItemWidget(
              cover: AssetsImages.codeCat,
              title: '基于 Flutter web 的个人博客系统',
              text:
                  'Flutter Web 是 Flutter 框架的 web 版本，可以用来开发响应式 web 应用程序。Flutter Web 使用 Dart 语言编写，并使用 WebAssembly 进行编译。WebAssembly 是一种可以在现代浏览器中运行的字节码格式。是一种可以在现代浏览器中运行的字节码格式。',
              date: '2024-03-25',
            ),
        ],
      ),
    );
  }

  Widget _buildView() {
    return CustomScrollView(
      slivers: [
        sliverAppBar(),
        _buildMain(),
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
