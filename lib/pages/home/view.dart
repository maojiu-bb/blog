import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  Widget _buildMain() {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          Image.asset(
            AssetsImages.logo,
            width: 300,
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '会写代码的猫',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Image.asset(
                AssetsImages.cat,
                width: 100,
                height: 100,
              ),
            ],
          ),
          Text(
            '在午夜时分相遇，寻找真实的自己',
            style: TextStyle(
              color: AppColors.onBackground,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                AssetsImages.codeCat,
                width: 700,
              ),
            ),
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
