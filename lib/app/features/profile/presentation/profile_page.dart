import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_test/app/_shared/settings/cubit/settings_cubit.dart';
import 'package:app_test/app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_test/generated/l10n.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SettingsCubit settingsCubit;

  @override
  void initState() {
    super.initState();
    settingsCubit = context.read<SettingsCubit>();
  }

  void _logout() async {
    await showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.logout),
        content: Text(S.current.areYouSureLogout),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              S.current.cancel,
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              context.read<AuthCubit>().logout();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
            child: Text(S.current.yesLogout),
          ),
        ],
      ),
    );
  }

  _selectLanguage() {
    showAdaptiveDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(S.current.language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text(S.current.english),
              onTap: () {
                settingsCubit.setLocale('en');
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text(S.current.spanish),
              onTap: () {
                settingsCubit.setLocale('es');
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final language = state.cache.locale == 'en'
              ? S.current.english
              : S.current.spanish;
          return BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              final user = authState.cache.user;
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        foregroundImage: const NetworkImage(
                          'https://static.vecteezy.com/system/resources/previews/027/951/137/non_2x/stylish-spectacles-guy-3d-avatar-character-illustrations-png.png',
                        ),
                      ),
                      const SizedBox(height: 20),
                      ListTile(
                        title: Text(S.current.email),
                        subtitle: Text(user?.email ?? '?'),
                        trailing: const Icon(Icons.email),
                      ),
                      ListTile(
                        title: Text(S.current.language),
                        subtitle: Text(language),
                        trailing: const Icon(Icons.language),
                        onTap: _selectLanguage,
                      ),
                      SwitchListTile.adaptive(
                        title: Text(S.current.darkMode),
                        value: state.cache.isDarkMode,
                        onChanged: (value) {
                          settingsCubit.setDarkMode(value);
                        },
                      ),
                      const Spacer(),
                      ListTile(
                        title: Text(S.current.logout),
                        onTap: _logout,
                        trailing: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
