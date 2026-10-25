import 'dart:convert';
import 'dart:typed_data';

import '../core/format.dart';
import '../core/money/money.dart';
import '../core/pdf/document_pdf.dart';
import '../domain/models.dart';
import '../core/invoicing/enums.dart';

InvoicePdfData invoiceToPdf(InvoiceDetail invoice) {
  final brand = invoice.brandSnapshot ?? const <String, Object?>{};
  final bank = invoice.bankSnapshot;
  String text(String key) => brand[key]?.toString() ?? '';
  Uint8List? bytes(String key) {
    final value = brand[key];
    if (value is! String || value.isEmpty) return null;
    try {
      return base64Decode(value);
    } on FormatException {
      return null;
    }
  }

  final business = PdfParty(
    name: text('legalName').isEmpty ? 'Business' : text('legalName'),
    tradingName: text('tradingName'),
    phone: text('phone'),
    email: text('email'),
    address: text('address'),
    extra: [
      if (text('registrationNumber').isNotEmpty) 'RC ${text('registrationNumber')}',
      if (text('tin').isNotEmpty) 'TIN ${text('tin')}',
      if (text('website').isNotEmpty) text('website'),
    ].join(' · '),
  );
  final bankText = bank == null
      ? ''
      : [
          bank['label'],
          bank['bankName'],
          bank['accountName'],
          bank['accountNumber'],
        ].whereType<String>().where((line) => line.trim().isNotEmpty).join('\n');
  return InvoicePdfData(
    template: invoice.template.storage,
    number: invoice.number ?? 'Draft',
    statusLabel: invoice.status.label,
    issueDate: formatLongDate(invoice.issueDate),
    dueDate: formatLongDate(invoice.dueDate),
    business: business,
    customer: PdfParty(
      name: invoice.customerName,
      phone: invoice.customerPhone,
      email: invoice.customerEmail ?? '',
      address: invoice.customerAddress ?? '',
    ),
    lines: [
      for (final line in invoice.lines)
        PdfLine(
          name: line.name,
          description: line.description,
          quantity: formatQuantity(line.quantityMilli),
          unit: unitLabel(line.unit, line.customUnit),
          unitPrice: formatMoney(line.unitPriceMinor, invoice.currency),
          total: formatMoney(line.lineTotalMinor, invoice.currency),
        ),
    ],
    subtotal: formatMoney(invoice.subtotalMinor, invoice.currency),
    discount: formatMoney(invoice.discountMinor, invoice.currency),
    tax: formatMoney(invoice.taxMinor, invoice.currency),
    charges: formatMoney(invoice.chargesMinor, invoice.currency),
    grand: formatMoney(invoice.grandMinor, invoice.currency),
    paid: formatMoney(invoice.paidMinor, invoice.currency),
    outstanding: formatMoney(invoice.outstandingMinor, invoice.currency),
    showDiscount: invoice.discountMinor > 0,
    showTax: invoice.taxMinor > 0,
    showCharges: invoice.chargesMinor > 0,
    showPaid: invoice.paidMinor > 0,
    bankText: bankText,
    paymentInstructions: invoice.paymentInstructions,
    notes: invoice.notes ?? '',
    terms: invoice.terms ?? '',
    footer: text('footer'),
    tagline: text('tagline'),
    logo: bytes('logoBase64'),
    signature: bytes('signatureBase64'),
    primaryHex: text('primaryColor').isEmpty ? '#1B2A4A' : text('primaryColor'),
    secondaryHex: text('secondaryColor').isEmpty ? '#243B67' : text('secondaryColor'),
    accentHex: text('accentColor').isEmpty ? '#0E8F62' : text('accentColor'),
  );
}

ReceiptPdfData receiptToPdf({
  required ReceiptItem receipt,
  required String currency,
}) {
  Map<String, Object?> snapshot = const {};
  try {
    final decoded = jsonDecode(receipt.snapshot);
    if (decoded is Map) snapshot = decoded.cast<String, Object?>();
  } on FormatException {
    snapshot = const {};
  }
  String text(String key) => snapshot[key]?.toString() ?? '';
  Uint8List? signature;
  final raw = snapshot['signatureBase64'];
  if (raw is String && raw.isNotEmpty) {
    try {
      signature = base64Decode(raw);
    } on FormatException {
      signature = null;
    }
  }
  return ReceiptPdfData(
    number: receipt.number,
    invoiceNumber: text('invoiceNumber'),
    marker: receipt.marker.label,
    business: PdfParty(
      name: text('businessName').isEmpty ? 'Business' : text('businessName'),
      phone: text('businessPhone'),
      address: text('businessAddress'),
    ),
    customer: PdfParty(name: text('customerName').isEmpty ? 'Customer' : text('customerName')),
    amount: formatMoney(receipt.amountMinor, currency),
    date: formatLongDate(receipt.issuedAt),
    method: text('method'),
    reference: text('reference'),
    remaining: formatMoney(receipt.remainingMinor, currency),
    primaryHex: text('primaryColor').isEmpty ? '#1B2A4A' : text('primaryColor'),
    signature: signature,
    footer: text('footer'),
  );
}
