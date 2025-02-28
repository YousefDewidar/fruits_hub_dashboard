import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fruits_hub_dashboard/core/supabase/ksupabase.dart';
import 'package:fruits_hub_dashboard/core/utils/app_colors.dart';
import 'package:fruits_hub_dashboard/generated/l10n.dart';
import 'package:fruits_hub_dashboard/views/dashboard_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: kSupabaseUrl,
    anonKey: kSupabaseAnonKey,
  );

  runApp(const FruitsHubDashboard());
}

class FruitsHubDashboard extends StatelessWidget {
  const FruitsHubDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruits Hub',
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        fontFamily: 'cairo',
      ),
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('ar'),
      home: const DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
