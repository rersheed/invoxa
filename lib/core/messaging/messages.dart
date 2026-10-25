import '../invoicing/enums.dart';
import '../money/money.dart';

const invoiceTemplateBody = '''
{greeting} {customer},

Thank you for your business.

Invoice: {invoice_number}
Service: {service}
Quantity: {quantity}
Total: {total}
Due: {due_date}

Kindly pay into:
{bank}

Please reply to confirm once the transfer is done.

Thank you,
{business}
{phone}
''';

const reminderTemplateBody = '''
{greeting} {customer},

This is a gentle reminder that invoice {invoice_number} for {total} is outstanding.

Amount still due: {outstanding}
Due date: {due_date}

Kindly pay into:
{bank}

Please reply once payment is made.

Thank you,
{business}
{phone}
''';

const confirmationTemplateBody = '''
{greeting} {customer},

We have received your payment of {amount} for invoice {invoice_number}.

Remaining balance: {outstanding}
Status: {status}

Thank you for your business.

{business}
{phone}
''';

String renderTemplate(String template, Map<String, String> values) {
  var output = template.trim();
  for (final entry in values.entries) {
    output = output.replaceAll('{${entry.key}}', entry.value);
  }
  return output;
}

/// Returns a WhatsApp-ready international number, or null when it is empty.
String? whatsappNumber(String raw) {
  final digits = raw.replaceAll(RegExp(r'\D'), '');
  if (digits.isEmpty) return null;
  if (digits.startsWith('0') && digits.length >= 10) {
    return '234${digits.substring(1)}';
  }
  return digits;
}

Uri whatsappUri(String internationalNumber, String text) {
  return Uri.https('wa.me', '/$internationalNumber', {'text': text});
}

class InvoiceMessageInput {
  const InvoiceMessageInput({
    required this.customerName,
    required this.invoiceNumber,
    required this.serviceSummary,
    required this.quantitySummary,
    required this.totalMinor,
    required this.outstandingMinor,
    required this.amountMinor,
    required this.currency,
    required this.dueDateLabel,
    required this.bankText,
    required this.businessName,
    required this.phone,
    required this.statusLabel,
    required this.now,
  });

  final String customerName;
  final String invoiceNumber;
  final String serviceSummary;
  final String quantitySummary;
  final int totalMinor;
  final int outstandingMinor;
  final int amountMinor;
  final String currency;
  final String dueDateLabel;
  final String bankText;
  final String businessName;
  final String phone;
  final String statusLabel;
  final DateTime now;

  Map<String, String> get placeholders => {
    'greeting': greetingWord(now),
    'customer': customerName,
    'invoice_number': invoiceNumber,
    'service': serviceSummary,
    'quantity': quantitySummary,
    'total': formatMoney(totalMinor, currency),
    'due_date': dueDateLabel,
    'bank': bankText,
    'business': businessName,
    'phone': phone,
    'outstanding': formatMoney(outstandingMinor, currency),
    'amount': formatMoney(amountMinor, currency),
    'status': statusLabel,
  };
}

String greetingWord(DateTime now) {
  if (now.hour < 12) return 'Good morning';
  if (now.hour < 17) return 'Good afternoon';
  return 'Good evening';
}

String defaultTemplate(TemplateType type) => switch (type) {
  TemplateType.invoice => invoiceTemplateBody,
  TemplateType.reminder => reminderTemplateBody,
  TemplateType.confirmation => confirmationTemplateBody,
};
