// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the OpenFin8:EOpenCA
// SPDX-License-Identifier: Apache-2.0

// eOpenCA services — BFF proxy access layer for FDX, DB, Storage.
//
// BffApiClient, ApiResponse, and generateCorrelationId are re-exported
// from sentin8. EOpenCAServices is app-specific.

// Re-export shared types from the package.
export 'package:sentin8/sentin8.dart'
    show BffApiClient, ApiResponse, generateCorrelationId;

import 'package:sentin8/sentin8.dart';

/// Centralized service registry for eOpenCA.
class EOpenCAServices {
  final BffApiClient fdx;
  final BffApiClient db;
  final BffApiClient storage;

  EOpenCAServices._({required this.fdx, required this.db, required this.storage});

  factory EOpenCAServices({
    required String bffBaseUrl,
    String? csrfToken,
    String? correlationId,
  }) {
    final base = bffBaseUrl.replaceAll(RegExp(r'/+$'), '');
    return EOpenCAServices._(
      fdx: BffApiClient(bffBaseUrl: base, serviceName: 'openfin8-ca', csrfToken: csrfToken, correlationId: correlationId),
      db: BffApiClient(bffBaseUrl: base, serviceName: 'db', csrfToken: csrfToken, correlationId: correlationId),
      storage: BffApiClient(bffBaseUrl: base, serviceName: 'storage', csrfToken: csrfToken, correlationId: correlationId),
    );
  }
}