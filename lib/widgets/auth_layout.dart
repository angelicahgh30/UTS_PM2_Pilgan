import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import 'app_card.dart';
import 'navy_header_layout.dart';
import 'page_container.dart';

class AuthLayout extends StatelessWidget {
  final String title;
  final String subtitle;
  final Widget form;

  const AuthLayout({
    super.key,
    required this.title,
    required this.subtitle,
    required this.form,
  });

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final canPop = Navigator.canPop(context);

    if (r.isMobile) {
      return NavyHeaderLayout(
        headerHeight: 210,
        maxWidth: r.sp(480),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: canPop
                  ? IconButton(
                      tooltip: 'Kembali',
                      color: Colors.white,
                      onPressed: () => Navigator.maybePop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                    )
                  : SizedBox(height: r.sp(48)),
            ),
            SizedBox(height: r.sp(8)),
            Text(title, style: r.text(context.texts.headlineLarge).onNavy),
            SizedBox(height: r.sp(4)),
            Text(subtitle, style: r.text(context.texts.bodyMedium).onNavyMuted),
            SizedBox(height: r.sp(24)),
            AppCard(padding: EdgeInsets.all(r.sp(20)), child: form),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: Container(
            color: AppColors.navy,
            padding: EdgeInsets.all(r.sp(40)),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(r.sp(2)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(r.sp(11)),
                        ),
                        child: SvgPicture.asset(
                          'assets/images/logo.svg',
                          width: r.sp(34),
                        ),
                      ),
                      SizedBox(width: r.sp(10)),
                      Text(
                        'Kuisin',
                        style: r.text(context.texts.headlineSmall).onNavy,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/welcome.svg',
                        width: r.sp(340),
                      ),
                    ),
                  ),
                  Text(
                    'Belajar sedikit demi sedikit,\nnilai naik terus.',
                    style: r.text(context.texts.headlineSmall).onNavy,
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: SafeArea(
            child: Center(
              child: PageContainer(
                maxWidth: r.sp(460),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (canPop)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          tooltip: 'Kembali',
                          onPressed: () => Navigator.maybePop(context),
                          icon: const Icon(Icons.arrow_back_rounded),
                        ),
                      ),
                    SizedBox(height: r.sp(8)),
                    Text(title, style: r.text(context.texts.headlineLarge)),
                    SizedBox(height: r.sp(4)),
                    Text(
                      subtitle,
                      style: r
                          .text(context.texts.bodyMedium)
                          .copyWith(color: context.palette.muted),
                    ),
                    SizedBox(height: r.sp(24)),
                    form,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
