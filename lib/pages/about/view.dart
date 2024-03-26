import 'package:blog/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AboutPage extends GetView<AboutController> {
  const AboutPage({super.key});

  Widget _buildMain() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 60,
          bottom: 60,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100),
                  ),
                  child: Image.asset(
                    AssetsImages.avatar,
                    width: 200,
                    height: 200,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'MaoJiu',
                  style: TextStyle(
                    color: AppColors.onBackground,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.location_on_outlined),
                        SelectableText('China'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.link_outlined),
                        SelectableText('https://github.com/maojiu-bb'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.link_outlined),
                        SelectableText('https://gitee.com/maojiubb'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.link_outlined),
                        SelectableText('https://juejin.cn/user/13638078834695'),
                      ],
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(Icons.link_outlined),
                        SelectableText('maojiu.king@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                Column(
                  children: [
                    Text(
                      'Introduction',
                      style: TextStyle(
                        color: AppColors.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 5),
                    const Text('一只会写代码的猫'),
                    const SizedBox(height: 5),
                    Image.asset(
                      AssetsImages.cat,
                      width: 100,
                      height: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Column(
                  children: [
                    Text(
                      'Languages & Tools',
                      style: TextStyle(
                        color: AppColors.onBackground,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetsSvgs.dart,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.figma,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.flutter,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.git,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.hexo,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.javascript,
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetsSvgs.mongodb,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.mysql,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.nodejs,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.react,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.vue,
                          width: 50,
                          height: 50,
                        ),
                        const SizedBox(width: 20),
                        SvgPicture.asset(
                          AssetsSvgs.typescript,
                          width: 50,
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
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
