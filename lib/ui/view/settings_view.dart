import 'package:astrologer/core/view_model/view/settings_view_model.dart';
import 'package:astrologer/ui/base_widget.dart';
import 'package:astrologer/ui/shared/route_paths.dart';
import 'package:astrologer/ui/shared/ui_helpers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingsViewModel>(
      model: SettingsViewModel(
        settingsService: Provider.of(context),
        homeService: Provider.of(context),
      ),
      onModelReady: (model) {},
      builder: (context, model, _) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 500),
          decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: ListView(
            children: <Widget>[
              _buildHeader(context),
              UIHelper.verticalSpaceMedium,
              _buildSettings(context, model),
            ],
          ),
        );
      },
    );
  }

  Widget _buildHeader(context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                child: Image.asset(
                  'assets/images/settings.gif',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            UIHelper.verticalSpaceMedium,
            /* Text(
              'Here are some settings that can be changed to match your preference.',
              style: Theme.of(context).textTheme.subhead,
              softWrap: true,
            ),*/
          ],
        ),
      ),
    );
  }

  _buildSettings(BuildContext context, SettingsViewModel model) {
    return Column(
      children: <Widget>[
        SwitchListTile(
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Dark Mode'),
          ),
          value: model.darkModeEnabled ?? false,
          onChanged: model.toggleDarkMode,
          secondary: const Icon(Icons.lightbulb_outline),
        ),
        ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text('Logout'),
          ),
          leading: Icon(Icons.swap_horiz),
          onTap: () async {
            await model.logout();
            Navigator.popAndPushNamed(context, RoutePaths.login);
          },
        ),
      ],
    );
  }
}
