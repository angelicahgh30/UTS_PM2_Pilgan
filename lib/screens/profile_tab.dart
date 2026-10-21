import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/theme/app_colors.dart';
import '../core/utils/responsive.dart';
import '../providers/auth_provider.dart';
import '../providers/history_provider.dart';
import '../providers/quiz_provider.dart';
import '../providers/theme_provider.dart';
import '../routes/app_routes.dart';
import '../widgets/app_button.dart';
import '../widgets/app_card.dart';
import '../widgets/navy_header_layout.dart';
import '../widgets/section_header.dart';
import '../widgets/user_avatar.dart';
import '../widgets/info_chip.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  Future<void> _logout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Keluar?'),
        content: const Text('Kuis yang sedang dikerjakan akan dihentikan.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Keluar'),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    context.read<QuizProvider>().resetQuiz();
    context.read<AuthProvider>().logout();
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.welcome, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    final r = context.responsive;
    final palette = context.palette;
    final user = context.watch<AuthProvider>().currentUser;
    if (user == null) return const SizedBox.shrink();

    final history = context.watch<HistoryProvider>();
    final results = history.resultsOf(user.id);

    return NavyHeaderLayout(
      headerHeight: 130,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const NavyTitle(title: 'Profil'),
          AppCard(
            padding: EdgeInsets.all(r.sp(20)),
            child: Row(
              children: [
                UserAvatar(initials: user.initials, size: 64),
                SizedBox(width: r.sp(16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.name, style: r.text(context.texts.titleLarge)),
                      SizedBox(height: r.sp(8)),
                      Wrap(
                        spacing: r.sp(6),
                        runSpacing: r.sp(6),
                        children: [
                          InfoChip(
                            icon: Icons.task_alt_rounded,
                            label: '${results.length} kuis selesai',
                          ),
                          InfoChip(
                            icon: Icons.bar_chart_rounded,
                            label:
                                'Rata-rata ${history.averageScore(user.id)}',
                            color: palette.success,
                            background: palette.successSoft,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: r.sp(20)),
          const SectionHeader(title: 'Pengaturan'),
          AppCard(
            padding: EdgeInsets.symmetric(
              horizontal: r.sp(16),
              vertical: r.sp(6),
            ),
            child: SwitchListTile(
              contentPadding: EdgeInsets.zero,
              secondary: Icon(
                Icons.dark_mode_outlined,
                color: context.colors.primary,
              ),
              title: Text(
                'Mode gelap',
                style: r.text(context.texts.titleSmall),
              ),
              subtitle: Text(
                'Lebih nyaman untuk belajar malam',
                style: r
                    .text(context.texts.bodySmall)
                    .copyWith(color: palette.muted),
              ),
              value: context.watch<ThemeProvider>().isDark(context),
              onChanged: context.read<ThemeProvider>().setDark,
            ),
          ),
          SizedBox(height: r.sp(24)),
          AppButton.outlined(
            label: 'Keluar',
            icon: Icons.logout_rounded,
            color: palette.danger,
            onPressed: () => _logout(context),
          ),
        ],
      ),
    );
  }
}
