# OpenFin8:EOpenCA - Open Finance Data Recipient App

[![License: Apache 2.0](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://github.com/OpenFin8/openfin8-eopenca/blob/main/LICENSE)
[![Built with Flutter](https://img.shields.io/badge/Built%20with-Flutter-02569B?logo=flutter)](https://flutter.dev)
[![Website](https://img.shields.io/badge/website-openfin8.dev-0E7C66)](https://openfin8.dev/)

eOpenCA is the open-finance **Data Recipient** demo app of the
OpenFin8 vertical (formerly eFintech of bank8): it catalogs external
open-finance data providers, initiates consent flows, tracks consent
state, and renders consented account + transaction data through the
recipient APIs served by `openfin8-ca`. It also carries a small staff
admin surface (instance overview, recipient-side administration).

The recipient model is the two-ledger design: the fintech institution
(e.g. "iOpenCA") runs its own environment; its customers connect to
external providers under explicit consent; the app consumes only the
recipient-side surfaces (`/v1/recipient/*`) through the platform BFF.

> Docs: [openfin8.dev](https://openfin8.dev/) - the vertical's
> reference docs are harvested from this repository.

## Motivation

A recipient-only fintech holds no banking data of its own: its value is
the customer's *permissioned* view into their banks. The app therefore
demonstrates the complete recipient plane - provider discovery, the
consent ceremony (hosted by the provider bank's authorization server),
delegated reads, revocation - with no shortcuts: every data read is
attributable to a live consent grant, enforced server-side by the
openfin8 kernel.

## What it covers

| Surface | What the app exercises |
|---|---|
| Provider catalog | Discovery of connectable providers (`/v1/recipient/providers`) |
| Consent journey | Start, authorize (hosted screen at the provider bank), callback, active connection |
| Consented data | Account list + detail, transactions - delegated reads |
| Consent review | Dashboard of active grants + revocation |
| Admin | Instance overview + recipient-side administration (RFW pages) |

## Development

```bash
flutter pub get
flutter run           # requires the platform BFF (see the platform docs)
flutter test
```

The app targets iOS, Android, and Web. Backend access rides the
platform BFF by service name (`openfin8-ca`); no service is called
directly.

## License

Apache-2.0 (see [LICENSE](LICENSE), [NOTICE](NOTICE)). The security
model is platform-wide - read [SECURITY.md](SECURITY.md).

---

**Architecture & Design:** openfin8:eopenca and its underlying concepts
were designed by [Hamid Jahanzad](https://www.linkedin.com/in/hamidjahanzad/).
