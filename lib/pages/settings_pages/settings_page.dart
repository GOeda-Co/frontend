import 'package:flutter/material.dart';
import 'package:frontend/app.dart';


class SettingsPage extends StatelessWidget {
  final VoidCallback? onToggleTheme;
  final VoidCallback? onLogout;

  const SettingsPage({super.key, this.onToggleTheme, this.onLogout});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Theme Switch Button
        ListTile(
          onTap: () {
            currentThemeMode.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
          },
          title: Text(
            'Dark Theme',
            style: TextStyle(color: colorScheme.onSurface, fontSize: 20),
          ),
          trailing: Switch(
            value: isDarkMode,
            onChanged: null,
            activeColor: colorScheme.primary,
          ),
          leading: Icon(Icons.dark_mode, color: colorScheme.onSurfaceVariant),
          
        ),
        const Divider(),

        // Logout Button 
        ListTile(
          title: Text(
            'Logout',
            style: TextStyle(color: colorScheme.error, fontSize: 20),
          ),
          trailing: Icon(Icons.logout, color: colorScheme.onSurfaceVariant),
          onTap: () {
            // Implement your logout logic here
            // This usually involves:
            // 1. Clearing user session/authentication tokens (e.g., from SharedPreferences, secure storage)
            // 2. Navigating to the login/onboarding screen
            // Example:
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Confirm Logout'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss dialog
                      },
                    ),
                    TextButton(
                      child: const Text('Logout'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Dismiss dialog
                        // Perform actual logout (e.g., clear tokens, navigate)
                        // Call the passed-in logout function
                        onLogout?.call();
                        // You can also add a fallback navigation if onLogout is null
                        // For example:
                        // if (onLogout == null) {
                        //   Navigator.of(context).pushReplacementNamed('/login');
                        // }
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}