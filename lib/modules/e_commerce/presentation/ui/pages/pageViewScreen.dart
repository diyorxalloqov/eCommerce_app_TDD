import 'package:ecommerce_app_with_tdd/core/constants/colors/appColors.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/presentation/ui/screens/pageViewScreens/firstPage.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/presentation/ui/screens/pageViewScreens/secondPage.dart';
import 'package:ecommerce_app_with_tdd/modules/e_commerce/presentation/ui/screens/pageViewScreens/thirdPage.dart';
import 'package:ecommerce_app_with_tdd/utils/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final List<Widget> _screens = const [FirstPage(), SecondPage(), ThirdPage()];
  final PageController _pageController = PageController(initialPage: 0);

  // Variable to track the current page
  int _currentPage = 0;
clear

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _currentPage == 0
              ? const SizedBox.shrink()
              : TextButton(
                  onPressed: () {
                    if (_currentPage > 0) {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    }
                  },
                  child: const Text(
                    "Prev",
                    style: TextStyle(
                      color: Color(0xFFC4C4C4),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < _screens.length; i++)
                AnimatedContainer(
                  decoration: BoxDecoration(
                    color: _currentPage == i
                        ? AppColor.activeIndicatorColor
                        : AppColor.inActiveIndicatorColor,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  width: _currentPage == i ? 30.w : 10.w,
                  height: 10.h,
                  duration: const Duration(milliseconds: 10),
                ),
              addWidth(5),
            ],
          ),
          TextButton(
            onPressed: () {
              if (_currentPage == _screens.length - 1) {
                Navigator.pushNamed(context, 'HomePage');
              } else {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.ease,
                );
              }
            },
            child: Text(
              _currentPage == _screens.length - 1 ? "Get Started" : "Next",
              style: const TextStyle(
                color: Color(0xFFF73658),
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
