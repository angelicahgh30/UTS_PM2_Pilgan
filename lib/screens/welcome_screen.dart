import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../routes/app_routes.dart';
import '../widgets/app_button.dart';
import '../widgets/navy_header_layout.dart';
import '../widgets/page_container.dart';
import '../widgets/theme_toggle_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final top = MediaQuery.paddingOf(context).top;
    final illustration = SvgPicture.asset(
      'assets/images/welcome.svg',
      width: (r.size.shortestSide * 0.72).clamp(220.0, 400.0),
    );
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const _Intro(),
        SizedBox(height: r.sp(28)),
        const _AuthButtons(),
      ],
    );

    if (r.isWide) {
      return Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: AppColors.navy,
                padding: EdgeInsets.fromLTRB(
                  r.sp(32),
                  top + r.sp(24),
                  r.sp(32),
                  r.sp(24),
                ),
                child: Column(
                  children: [
                    const _Brand(),
                    Expanded(child: Center(child: illustration)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SafeArea(
                child: Center(
                  child: PageContainer(maxWidth: r.sp(460), child: content),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(
                r.pagePadding,
                top + r.sp(12),
                r.pagePadding,
                r.sp(28),
              ),
              decoration: BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(r.sp(36)),
                ),
              ),
              child: Column(
                children: [
                  const _Brand(),
                  SizedBox(height: r.sp(16)),
                  illustration,
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                r.pagePadding,
                r.sp(24),
                r.pagePadding,
                r.sp(24) + MediaQuery.paddingOf(context).bottom,
              ),
              child: content,
            ),
          ],
        ),
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(r.sp(2)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(r.sp(11)),
          ),
          child: SvgPicture.asset('assets/images/logo.svg', width: r.sp(34)),
        ),
        SizedBox(width: r.sp(10)),
        Text('Kuisin', style: r.text(context.texts.headlineSmall).onNavy),
        const Spacer(),
        const ThemeToggleButton(color: Colors.white),
      ],
    );
  }
}

class _Intro extends StatelessWidget {
  const _Intro();

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Latihan soal jadi lebih seru',
          style: r.text(context.texts.headlineLarge),
        ),
        SizedBox(height: r.sp(8)),
        Text(
          'Kerjakan kuis pilihan ganda materi Ilmu Komputer, lihat '
          'pembahasannya, dan pantau perkembangan belajarmu.',
          style: r.text(context.texts.bodyLarge).copyWith(color: palette.muted),
        ),
        SizedBox(height: r.sp(16)),
        Wrap(
          spacing: r.sp(8),
          runSpacing: r.sp(8),
          children: const [
            _Feature(icon: Icons.timer_outlined, label: 'Timer tiap soal'),
            _Feature(icon: Icons.menu_book_outlined, label: 'Pembahasan soal'),
            _Feature(icon: Icons.insights_rounded, label: 'Riwayat nilai'),
          ],
        ),
      ],
    );
  }
}

class _Feature extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Feature({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: r.sp(12), vertical: r.sp(8)),
      decoration: BoxDecoration(
        color: context.palette.primarySoft,
        borderRadius: BorderRadius.circular(r.sp(20)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: r.sp(16), color: context.colors.primary),
          SizedBox(width: r.sp(6)),
          Text(
            label,
            style: r
                .text(context.texts.labelMedium)
                .copyWith(color: context.colors.primary),
          ),
        ],
      ),
    );
  }
}

class _AuthButtons extends StatelessWidget {
  const _AuthButtons();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      label: 'Mulai',
      onPressed: () => Navigator.pushNamed(context, AppRoutes.login),
    );
  }
}
