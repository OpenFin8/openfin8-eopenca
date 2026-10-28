// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the OpenFin8:EOpenCA
// SPDX-License-Identifier: Apache-2.0

// eOpenCA auth provider — re-exported from sentin8.
export 'package:sentin8/sentin8.dart'
    show BffAuthProvider, AuthState, AppUser;

import 'package:sentin8/sentin8.dart';

/// Backward-compatible alias.
typedef AuthProvider = BffAuthProvider;

/// Backward-compatible alias.
typedef EOpenCAUser = AppUser;