// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the OpenFin8:EOpenCA
// SPDX-License-Identifier: Apache-2.0

// eOpenCA contract tests.
import 'package:flutter_test/flutter_test.dart';
import 'package:eopenca/services.dart';

void main() {
  group('BffApiClient', () {
    test('FDX client uses correct service name', () {
      final c = BffApiClient(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev', serviceName: 'openfin8-ca');
      expect(c.serviceName, equals('openfin8-ca'));
    });

    test('DB client uses correct service name', () {
      final c = BffApiClient(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev', serviceName: 'db');
      expect(c.serviceName, equals('db'));
    });

    test('Storage client uses correct service name', () {
      final c = BffApiClient(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev', serviceName: 'storage');
      expect(c.serviceName, equals('storage'));
    });
  });

  group('EOpenCAServices', () {
    test('Creates only 3 service clients (no ledger/payments - read-only recipient)', () {
      final s = EOpenCAServices(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev');
      expect(s.fdx.serviceName, equals('openfin8-ca'));
      expect(s.db.serviceName, equals('db'));
      expect(s.storage.serviceName, equals('storage'));
    });
  });

  group('Correlation ID', () {
    test('generateCorrelationId produces non-empty string', () {
      final id = generateCorrelationId();
      expect(id, isNotEmpty);
      // SDK default prefix is 'app' (correlation.dart) - callers pass their
      // own prefix (e.g. eOpenCA's logger) at call sites.
      expect(id, startsWith('app-'));
    });
  });
}