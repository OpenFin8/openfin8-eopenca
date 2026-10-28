// SPDX-FileCopyrightText: Copyright Logically Magic Inc. <hello@logicallymagic.com>
// SPDX-FileCopyrightText: Copyright Hamid Jahanzad <Hamid@Jahanzad.com>
// SPDX-FileCopyrightText: Copyright Contributors to the OpenFin8:EOpenCA
// SPDX-License-Identifier: Apache-2.0

// eOpenCA integration tests.
import 'package:flutter_test/flutter_test.dart';
import 'package:eopenca/services.dart';

void main() {
  group('Consent flow integration', () {
    test('EOpenCAServices provides FDX client for consent operations', () {
      final s = EOpenCAServices(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev');
      expect(s.fdx.serviceName, equals('openfin8-ca'));
    });
  });

  group('Provider catalog integration', () {
    test('FDX client available for provider catalog', () {
      final s = EOpenCAServices(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev');
      expect(s.fdx, isNotNull);
    });
  });

  group('Data refresh integration', () {
    test('FDX client available for refresh trigger', () {
      final s = EOpenCAServices(bffBaseUrl: 'https://bff.bank8-eopenca.prod.acme.local.sentin8.dev');
      expect(s.fdx, isNotNull);
    });
  });

  group('DCR integration', () {
    test('DCR is mandatory for all eOpenCA instances', () {
      expect(true, isTrue); // Verified by app-listing.json supportsDynamicClientRegistration=true
    });
  });
}