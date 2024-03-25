import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

SliverAppBar sliverAppBar() {
  return SliverAppBar(
    leading: Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Image.asset(
        AssetsImages.logo,
      ),
    ),
    title: Text(
      'MaoJiu',
      style: TextStyle(
        // fontStyle: FontStyle.italic,
        fontWeight: FontWeight.w600,
        fontFamily: AutofillHints.nickname,
        color: AppColors.onPrimary,
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Get.toNamed(RouteNames.home),
        child: Text(
          '首页',
          style: TextStyle(
            color: AppColors.onPrimary,
          ),
        ),
      ),
      TextButton(
        onPressed: () => Get.toNamed(RouteNames.about),
        child: Text(
          '关于',
          style: TextStyle(
            color: AppColors.onPrimary,
          ),
        ),
      ),
      TextButton(
        onPressed: () => Get.toNamed(RouteNames.blog),
        child: Text(
          '博客',
          style: TextStyle(
            color: AppColors.onPrimary,
          ),
        ),
      ),
      TextButton(
        onPressed: () => Get.toNamed(RouteNames.project),
        child: Text(
          '项目',
          style: TextStyle(
            color: AppColors.onPrimary,
          ),
        ),
      ),
      TextButton(
        onPressed: () => Get.toNamed(RouteNames.resource),
        child: Text(
          '资源',
          style: TextStyle(
            color: AppColors.onPrimary,
          ),
        ),
      ),
      IconButton(
        onPressed: () => ConfigService.to.switchTheme(),
        icon: Icon(
          Icons.wb_sunny_outlined,
          color: AppColors.onPrimary,
        ),
      ),
      const SizedBox(width: 20),
    ],
    backgroundColor: AppColors.primary,
    centerTitle: false,
    pinned: true,
  );
}
