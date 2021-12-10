import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/models.dart';
import '../../services/services.dart';
import '../../screens/screens.dart';
import '../../widgets/widgets.dart';
import '../../provider/provider.dart';
import '../../utilities/utilities.dart';

class BaseHomeScreen extends StatefulWidget {
  const BaseHomeScreen({Key? key}) : super(key: key);

  @override
  State<BaseHomeScreen> createState() => _BaseHomeScreenState();
}

class _BaseHomeScreenState extends State<BaseHomeScreen> {
  AuthProvider? _authProvider;
  Location? devicePosition;

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
      bottom: _tabHeaders(),
      title: const Text('K-Agents'),
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

  _tabHeaders() {
    return const TabBar(
      isScrollable: true,
      tabs: [
        TabWidget(title: 'Kiosk'),
        TabWidget(title: 'Wholesaler'),
      ],
    );
  }

  final List<Widget> _pages = [const KioskScreen(), const WholesalerScreen()];

  @override
  void initState() {
    super.initState();

    _authProvider = context.read<AuthProvider>();
    getDevicePosition().then((value) {
      devicePosition = Location(
        latitude: value.latitude,
        longitude: value.longitude,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: _appBar(),
          body: TabBarView(
            children: _pages,
          ),
        ),
      ),
    );
  }
}
