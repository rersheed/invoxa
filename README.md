# INVOXA

Offline-first invoicing and payment tracking for Nigerian small businesses. Android only. There is no account, server, or analytics. Creating an invoice, a PDF, and a WhatsApp message works without internet. Sending the message uses WhatsApp, which needs a connection.

Version 1.0.0. Application id `com.invoxa.app`.

## Setup

Install [Flutter 3.47.8](https://docs.flutter.dev/install) (stable) and the Android SDK (compile SDK 36, NDK 28.2.13676358, Java 17).

```bash
flutter pub get
flutter analyze
flutter test
flutter run
```

The design notes — architecture, schema, colours, journeys, and package limits — are in [docs/DESIGN.md](docs/DESIGN.md).

## Architecture

Feature screens live in `lib/features`. Money, numbering, status, branding, reminders, reports, backup, and PDF rules live in `lib/core` as plain Dart. Drift (SQLite) is behind `InvoxaStore` in `lib/data`. Riverpod holds the store and the lock. GoRouter owns navigation.

Money is an integer of minor units. A line is quantity × price, with half-up rounding. The grand total is subtotal − discount + tax + charges. Outstanding is the grand total minus payments. Invoice numbers look like `INV-2026-0001`. The sequence never goes backwards, including after a delete. An issued invoice stores a snapshot of the brand and bank details used that day.

Payment statuses are what you record. INVOXA does not check a bank.

## Build a release

```bash
flutter build apk --release
flutter build appbundle --release
```

If `android/key.properties` is missing, the release build is signed with the debug key so a developer can try it. Do not ship that build. The file is gitignored. It looks like this:

```
storePassword=...
keyPassword=...
keyAlias=invoxa
storeFile=/absolute/path/invoxa-release.jks
```

Never commit the keystore or the passwords.

### GitHub Actions secrets

The release workflow (tag `v*`) signs with these repository secrets when they exist:

| Secret | Value |
| --- | --- |
| `KEYSTORE_BASE64` | The `.jks` file, base64-encoded, on one line |
| `KEYSTORE_PASSWORD` | Keystore password |
| `KEY_ALIAS` | Key alias, for example `invoxa` |
| `KEY_PASSWORD` | Key password |

Create a keystore on your own machine and add the secrets in GitHub → Settings → Secrets and variables → Actions:

```bash
keytool -genkeypair -v \
  -keystore invoxa-release.jks \
  -storetype PKCS12 \
  -alias invoxa \
  -keyalg RSA -keysize 2048 -validity 10000
base64 -w 0 invoxa-release.jks
```

Paste the base64 output into `KEYSTORE_BASE64`. Keep the `.jks` somewhere safe and do not put it in the repo.

If those secrets are absent, CI generates a one-off key, prints a warning, and still uploads `INVOXA.apk` and `INVOXA.aab`. That signature changes every build, so a later release will not install over it. Add the secrets before you publish an update.

The download URL is stable:

https://github.com/rersheed/invoxa/releases/latest/download/INVOXA.apk

## Your data

Invoices live in a SQLite file on the phone. Android Auto Backup is off. Export a backup from Settings and keep the file. If the phone is lost or reset and you have no backup, the records cannot be recovered. A password on the backup uses AES-GCM. A lost password cannot be recovered either.

## Website

`site/` is a static download page. GitHub Actions deploys it to GitHub Pages. It is not a web build of the app.

The workflow file has to be on the default branch before Pages can use “GitHub Actions” as the source. If the site is not live, open **Settings → Pages → Build and deployment → Source** and choose **GitHub Actions**.

## CI

[`.github/workflows/ci.yml`](.github/workflows/ci.yml) analyzes and tests on pull requests and on `main`. A tag such as `v1.0.0` also builds the APK and the AAB and attaches them to the GitHub Release. Pushes to `main` deploy `site/`.
