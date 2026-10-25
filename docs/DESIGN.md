# INVOXA design

INVOXA is an offline-first Android app for Nigerian small businesses. A returning user should be able to raise a basic invoice in about 30 seconds. The product should feel like a calm fintech tool, not accounting software. There is no account, server, cloud database, subscription, analytics, or tracking. WhatsApp delivery may use the network. Creating the message and the PDF does not.

## Architecture

Feature-first Clean Architecture. Feature screens live under `lib/features`. Business rules that must stay correct live in `lib/core` as pure Dart (money, numbering, status, branding, reminders, reports, backup, PDF). Drift is the only database, behind `InvoxaStore` in `lib/data`. Riverpod exposes the store, navigation, and the lock state. Widgets format and collect input. They do not reimplement totals.

```
UI (features/*/presentation)
    → InvoxaStore (transactions, snapshots, files)
        → pure rules in lib/core
        → AppDatabase (Drift / SQLite)
```

Issued invoices store a snapshot of the business or service brand, customer, prices, and bank details used at save time. Later edits to the business profile do not rewrite old invoices. Saving the invoice again refreshes that invoice's snapshot only.

Money is an integer of minor units (kobo, cents). Quantities are integers of thousandths (`quantityMilli`), so 1.5 hours is `1500`. Line totals use half-up integer division. Nothing in the calculation path uses `double`. Charts may use `double` only as a visual scale. The figures on the cards stay exact.

One business profile per device. Many bank accounts, services, and customers.

## Database

SQLite file `invoxa.sqlite` in the app documents directory. Schema version **2**. Version 2 adds `app_settings.insight_enabled` (default true). Fresh installs run `onCreate`. Older files run `onUpgrade`. Foreign keys are enabled on open. UUIDs are text primary keys. Invoice numbers and receipt numbers are unique. Draft invoice numbers are null, and SQLite allows many nulls under that unique index. Sequences only move forward, including after delete.

### businesses

| Column | Type | Notes |
| --- | --- | --- |
| id | text pk | |
| legal_name | text | |
| trading_name | text? | |
| phone, whatsapp, email, address | text | |
| website, registration_number, tin, description | text? | |
| default_currency | text | default `NGN` |
| created_at, updated_at | datetime | |

### brand_profiles

Polymorphic: `owner_type` is `business` or `service`, unique with `owner_id`.

| Column | Type | Notes |
| --- | --- | --- |
| id | text pk | |
| owner_type, owner_id | text | |
| logo_bytes, signature_bytes | blob? | copied into invoice snapshots |
| primary_color, secondary_color, accent_color | text | `#RRGGBB` |
| tagline, footer, trading_name | text? | |
| contact_phone, contact_whatsapp, contact_email, contact_address | text? | used by service branding |
| template | text | `corporate`, `minimal`, `premium`, `compact` |
| created_at, updated_at | datetime | |

### bank_accounts

`business_id` → businesses. `bank_name`, `account_name`, `account_number`, optional `label`, `is_default`, `is_active`, `created_at`.

### services

`business_id` → businesses. `name`, `description`, `category`, `default_price_minor`, `unit`, optional `custom_unit`, `currency`, optional `bank_account_id` → bank_accounts, `is_active`, `branding_mode` (`business` or `custom`), timestamps.

### customers

`business_id` → businesses. `name`, `phone`, `whatsapp`, optional `email`, `address`, `notes`, timestamps. One-time customers are not inserted here. Their details live on the invoice.

### invoices

`business_id` → businesses. Nullable unique `number`. `status` is the last stored value (`draft`, `unpaid`, `partial`, `paid`, `overdue`, `cancelled`). The app recomputes the effective status on read: paid when nothing is outstanding, overdue when a non-draft balance is past the due date, otherwise partial or unpaid.

Also: `issue_date`, `due_date`, nullable `customer_id`, customer snapshot columns (`customer_name`, `customer_phone`, `customer_whatsapp`, `customer_email`, `customer_address`, `customer_saved`), `discount_minor`, `tax_rate_bps` (100 = 1%), `tax_minor`, `charges_minor`, `subtotal_minor`, `grand_total_minor`, `currency`, nullable `bank_account_id`, `bank_snapshot`, `branding_snapshot` (JSON, logos as base64), `payment_instructions`, `notes`, `terms`, `terms_preset`, `template`, `issued_at`, `settled_at`, `cancelled_at`, timestamps.

Formulas, checked in tests and on backup import:

- line = half-up(`quantity_milli` × `unit_price_minor` / 1000)
- subtotal = sum of lines
- discount cannot exceed subtotal
- tax = half-up((subtotal − discount) × `tax_rate_bps` / 10000)
- grand = subtotal − discount + tax + charges
- outstanding = grand − sum of payments

### invoice_items

`invoice_id` → invoices, cascade delete. Optional `service_id`. `name`, `description`, `quantity_milli`, `unit`, `custom_unit`, `unit_price_minor`, `line_total_minor`, `position`.

### payments

`invoice_id` → invoices, no cascade. Unique `idempotency_key` so a double tap cannot insert twice. `amount_minor`, `paid_at`, `method` (`bank_transfer`, `cash`, `pos`, `card`, `other`), optional `bank_account_id`, `reference`, `notes`, `created_at`. A payment is rejected when it is not positive or when it exceeds the outstanding balance. Insert, receipt, and status update run in one transaction.

### receipts

Unique `number`, unique `payment_id`, `invoice_id`, `amount_minor`, `remaining_minor`, `marker` (`paid` or `part_payment`), `snapshot`, `issued_at`.

### reminders

`invoice_id` → invoices, cascade delete. `kind` (`before_due`, `on_due`, `after_3`, `after_7`, `custom`), `scheduled_at`, `notification_id`, `status` (`scheduled`, `sent`, `cancelled`), `sent_at`, `message`, `created_at`. Paying or cancelling an invoice marks scheduled reminders cancelled and cancels the local notification.

### message_templates

`type` (`invoice`, `reminder`, `confirmation`), `name`, `body`, `is_default`, `updated_at`. Placeholders: `{greeting}`, `{customer}`, `{invoice_number}`, `{service}`, `{quantity}`, `{total}`, `{due_date}`, `{bank}`, `{business}`, `{phone}`, `{outstanding}`, `{amount}`, `{status}`.

### app_settings

Single row `id = app`. Onboarding flag, invoice and receipt prefixes, next sequences, padding, default currency, tax switch and rate, default terms and due days, default notes and payment instructions, notification switches, reminder offsets, PIN enabled flag (the hash is not stored here), biometric flag, auto-lock seconds, sensitive-screen flag, last backup time, theme mode, enabled payment methods, insight flag, timestamps.

### backup_metadata

`id`, `created_at`, `file_name`, `format_version`, `encrypted`, `size_bytes`, `note`.

## Design system

Light surfaces are soft off-white `#F7F5F2` with white cards, 20px radius, and a light shadow. Primary actions are deep navy `#1B2A4A`. Money received and success are emerald `#0E8F62`. Warnings are `#8A5A00`. Overdue is muted red `#9C2F2F`. Dark mode uses `#10151C` / `#1C2433` with lighter navy text and brighter emerald. No heavy gradients.

Type is Inter, with Noto Sans as the fallback so `₦` renders. Spacing is on an 4/8/12/16/20/24 scale. Buttons are at least 52px tall. Icon buttons are 48px. Status is a text badge, not colour alone. Empty screens explain what to do next and offer one action. Motion is limited to short fades and chart updates.

PDF templates share one data model and differ in layout: Corporate (navy band and filled table header), Minimal (type and hairlines), Premium (accent bar and a large total), Compact (tighter type for long invoices).

## Main journeys

1. **First launch.** Splash, then welcome ("Your Business. Your Invoices. Your Control."), business profile, branding with a live preview, one or more bank accounts, then "Your business is ready!" with Create Your First Invoice and Explore Dashboard.
2. **30-second invoice.** New Invoice asks for a customer (search, create, or one-time), a service (price and bank account follow the service; quantity defaults to 1), then review (due date from the default terms). Generate assigns `INV-2026-0001`, writes the snapshot, and opens share actions.
3. **Several services.** If they point at different bank accounts, the review step asks where the customer should pay. The choice is stored on that invoice. Branding uses the service brand only when every line is that custom-branded service. Mixed lines use the main business brand.
4. **Payment.** Record Payment stores a new row. Overpayment and a second submit with the same idempotency key are rejected. A zero balance sets Paid, the settlement date, a receipt, and offers a WhatsApp acknowledgement. The screen states that INVOXA does not verify the bank.
5. **Reminder.** Local notifications before the due date, on the due date, 3 and 7 days after, or on a custom date. Tapping opens the invoice. Send Payment Reminder prepares an editable message. Nothing is sent until the user taps copy, WhatsApp, or share. Mark as sent is explicit. Full payment cancels scheduled reminders.
6. **Backup.** A versioned JSON file, logos included, optional AES-GCM with a PBKDF2-HMAC-SHA256 key. Restore validates the file before replacing data. The wrong password leaves the database as it was.

## Packages and limits

| Package | Role | Limit |
| --- | --- | --- |
| drift 2.35 + drift_flutter 0.3 + sqlite3 3.x | SQLite | Native SQLite ships through Dart hooks. `sqlite3_flutter_libs` 0.6.0+eol is an empty pin that drift_flutter requires so apps do not pull the old plugin. INVOXA does not call it. |
| flutter_riverpod 3.4 | State | Providers are hand-written. No code generation. |
| go_router 18 | Navigation | Shell plus full-screen flows. |
| pdf 3.13 + printing 5.15 | Documents | Layout is manual. Fonts must be bundled. `printing` can preview and share. It cannot silently print on every device. |
| share_plus 13 | Android share sheet | The user finishes the share. A PDF and a WhatsApp text are separate actions. |
| url_launcher | `wa.me` and `tel` | Opens WhatsApp or the dialer. Fails clearly when WhatsApp is not installed. Does not attach the PDF. |
| flutter_local_notifications 22 + timezone + flutter_timezone | Reminders | Needs notification permission on Android 13+. Exact alarms need `SCHEDULE_EXACT_ALARM`, which the user can deny. INVOXA then schedules an inexact alarm. Delivery is not guaranteed. |
| flutter_secure_storage 11 | PIN hash | Device-only. It is not inside the backup, so a restore asks for a new PIN. |
| local_auth 3 | Biometrics | Works only when the device has biometrics enrolled. PIN remains the fallback. |
| cryptography 2.9 | AES-GCM backups | 120,000 PBKDF2 iterations. A lost password cannot be recovered. |
| file_picker 13 | Save and open | Depends on the system picker. |
| image_picker + image | Logo | Gallery only, so the camera permission is not requested. Logos are resized before they are stored. |
| fl_chart | Charts | Visual only. |
| intl | Dates | Money formatting is INVOXA's own integer formatter so `₦` and grouping stay stable. |

Permissions: notifications, exact alarms, boot completed (so reminders can be rescheduled), vibrate, biometric use. Internet is not requested. Android Auto Backup is off. Private data is not written to logs.

## Folder structure

```
lib/
  main.dart
  app/                 app shell, router, providers
  core/
    theme/ widgets/
    money/ invoicing/ messaging/ backup/ pdf/ reports/
  data/
    db/app_database.dart
    invoxa_store.dart
  features/
    onboarding/ dashboard/ invoices/ customers/ services/
    payments/ receipts/ reminders/ reports/ settings/
    backup/ security/
assets/fonts/          Inter and Noto Sans
android/               applicationId com.invoxa.app
site/                  static landing page, not a Flutter web build
.github/workflows/     analyze, test, release APK/AAB, GitHub Pages
test/                  rules, store, backup, PDF, migrations
```

## Numbering, status, and safety

Numbers look like `INV-2026-0001` and `RCT-2026-0001`. The prefix is configurable. The sequence is global and is not reused. The year in the number is the issue year.

Statuses the user sees: Draft, Unpaid, Partially Paid, Paid, Overdue, Cancelled. Delete is only for drafts with no payments. Cancel keeps the row and its payments. Totals exclude drafts and cancelled invoices. Recorded payments still count as received.

The backup format id is `invoxa-backup`, version 1. Import rejects a bad format, a newer version, duplicate numbers, orphan rows, totals that do not match the formulas, overpayment, and a wrong password.
