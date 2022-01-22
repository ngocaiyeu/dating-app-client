import 'package:datting_social/intro.dart';
import 'package:datting_social/router/app_router.dart';
import 'package:datting_social/screens/home/components/detail_item_user_gird.dart';
import 'package:datting_social/screens/home/home_binding.dart';
import 'package:datting_social/screens/home/home_main.dart';
import 'package:datting_social/screens/login/login_screen.dart';
import 'package:datting_social/screens/login/register_screen.dart';
import 'package:datting_social/screens/news/full_imgae.dart';
import 'package:datting_social/screens/news/news_screen.dart';
import 'package:datting_social/screens/post_status/post_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppPages {
  static var listPage = [
    GetPage(
      name: AppRoutes.intro,
      page: () => const IntroPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
    ),
    GetPage(
        name: AppRoutes.home,
        page: () => const HomeMain(),
        binding: HomeBinding()),
    GetPage(
      name: AppRoutes.item,
      page: () => const DetailInformationScreen(),
    ),
    GetPage(
      name: AppRoutes.fullImage,
      page: () => const FullImage(),
    ),
    GetPage(
      name: AppRoutes.post,
      page: () => const PostScreen(),
    ),
  ];
}
