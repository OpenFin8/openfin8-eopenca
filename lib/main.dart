// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the OpenFin8:EOpenCA
// SPDX-License-Identifier: Apache-2.0

// eOpenCA main entry point - bootstrap, runtime context, app shell.
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:web/web.dart' as web;
import 'theme.dart';
import 'app_context.dart';
import 'bootstrap.dart';
import 'pages/pages.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SemanticsBinding.instance.ensureSemantics();
  runApp(const EOpenCAApp());
}

class EOpenCAApp extends StatefulWidget {
  const EOpenCAApp({super.key});
  @override
  State<EOpenCAApp> createState() => _EOpenCAAppState();
}

class _EOpenCAAppState extends State<EOpenCAApp> {
  AppRuntimeContext? _ctx;
  String? _err;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    try {
      final appBaseUrl = web.window.location.origin;
      final ctx = await fetchRuntimeContext(appBaseUrl: appBaseUrl);
      setState(() => _ctx = ctx);
    } catch (e) {
      setState(() => _err = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _ctx?.displayName ?? 'eOpenCA',
      theme: _ctx != null ? sentin8ThemeForContext(_ctx!) : sentin8Theme(),
      debugShowCheckedModeBanner: false,
      home: _buildHome(),
      onGenerateRoute: _generateRoute,
    );
  }

  Widget _buildHome() {
    if (_err != null) return BootstrapErrorPage(error: _err!, appName: 'eOpenCA');
    if (_ctx == null) return const BootstrapLoaderPage(appName: 'eOpenCA');
    return EOpenCAContextProvider(
        runtimeContext: _ctx!, child: const EOpenCAShell());
  }

  Route<dynamic>? _generateRoute(RouteSettings settings) => null;
}
