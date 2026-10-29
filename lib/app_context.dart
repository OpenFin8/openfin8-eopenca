// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the OpenFin8:EOpenCA
// SPDX-License-Identifier: Apache-2.0

// eOpenCA app context - central runtime state.
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;
import 'bootstrap.dart';
import 'auth_provider.dart';
import 'services.dart';

class EOpenCAContext extends ChangeNotifier {
  final AppRuntimeContext runtimeContext;
  final AuthProvider auth;
  EOpenCAServices? services;
  final String correlationId;

  EOpenCAContext._({required this.runtimeContext, required this.auth, required this.correlationId}) {
    auth.addListener(_onAuthChanged);
    _updateServices();
  }

  static Future<EOpenCAContext> create(AppRuntimeContext runtimeContext) async {
    final corrId = generateCorrelationId();
    final auth = AuthProvider(bffBaseUrl: runtimeContext.bffBaseUrl, authDomain: runtimeContext.authDomain);
    auth.onRedirect = (String url) { web.window.location.href = url; };
    await auth.init();
    return EOpenCAContext._(runtimeContext: runtimeContext, auth: auth, correlationId: corrId);
  }

  void _onAuthChanged() { _updateServices(); notifyListeners(); }
  void _updateServices() {
    services = EOpenCAServices(bffBaseUrl: runtimeContext.bffBaseUrl, csrfToken: auth.csrfToken, correlationId: correlationId);
  }

  bool isFeatureEnabled(String feature) => runtimeContext.featureFlags[feature] ?? true;

  @override
  void dispose() { auth.removeListener(_onAuthChanged); auth.dispose(); super.dispose(); }
}
class EOpenCAContextProvider extends StatefulWidget {
  final AppRuntimeContext runtimeContext;
  final Widget child;
  const EOpenCAContextProvider({super.key, required this.runtimeContext, required this.child});
  @override
  State<EOpenCAContextProvider> createState() => _EOpenCAContextProviderState();
  static EOpenCAContext? of(BuildContext context) {
    final inh = context.dependOnInheritedWidgetOfExactType<_EOpenCAContextInherited>();
    return inh?.eOpenCAContext;
  }
}

class _EOpenCAContextProviderState extends State<EOpenCAContextProvider> {
  EOpenCAContext? _context;
  @override
  void initState() { super.initState(); _initContext(); }
  Future<void> _initContext() async {
    final ctx = await EOpenCAContext.create(widget.runtimeContext);
    if (mounted) setState(() => _context = ctx);
  }
  @override
  void dispose() { _context?.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    if (_context == null) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return _EOpenCAContextInherited(eOpenCAContext: _context!, child: widget.child);
  }
}

class _EOpenCAContextInherited extends InheritedWidget {
  final EOpenCAContext eOpenCAContext;
  final Widget child;
  const _EOpenCAContextInherited({required this.eOpenCAContext, required this.child}) : super(child: child);
  @override
  bool updateShouldNotify(_EOpenCAContextInherited old) => eOpenCAContext != old.eOpenCAContext;
}