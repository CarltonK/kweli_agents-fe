import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/widgets.dart';
import '../provider/provider.dart';
import '../utilities/utilities.dart';

class BaseHomeScreen extends StatefulWidget {
  const BaseHomeScreen({Key? key}) : super(key: key);

  @override
  State<BaseHomeScreen> createState() => _BaseHomeScreenState();
}

class _BaseHomeScreenState extends State<BaseHomeScreen> {
  AuthProvider? _authProvider;
  Future<bool> _onWillPop() {
    return _buildPopStack() ?? false;
  }

  _exitApp() => _authProvider!.signOut();

  _buildPopStack() {
    return dialogExitApp(context, _exitApp);
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        GlobalCircleButton(
          color: Colors.black,
          icon: Icons.exit_to_app,
          tooltip: 'Exit',
          onPressed: () => dialogExitApp(context, _exitApp),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _authProvider = context.read<AuthProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: _appBar(),
      ),
    );
  }
}
