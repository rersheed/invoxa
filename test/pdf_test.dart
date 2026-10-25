import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:invoxa/core/pdf/document_pdf.dart';

/// Reconstructs drawn text from a subset TrueType PDF via its ToUnicode maps.
String pdfText(List<int> bytes) {
  final source = latin1.decode(bytes, allowInvalid: true);
  final objects = <int, String>{};
  for (final match in RegExp(r'(\d+) 0 obj\n(.*?)endobj', dotAll: true).allMatches(source)) {
    objects[int.parse(match.group(1)!)] = match.group(2)!;
  }
  final cmaps = <int, Map<int, int>>{};
  final pairs = RegExp(r'<([0-9A-Fa-f]{4})>\s*<([0-9A-Fa-f]{4})>');
  for (final entry in objects.entries) {
    if (!entry.value.contains('beginbfchar')) continue;
    final map = <int, int>{};
    for (final pair in pairs.allMatches(entry.value)) {
      map[int.parse(pair.group(1)!, radix: 16)] = int.parse(pair.group(2)!, radix: 16);
    }
    cmaps[entry.key] = map;
  }
  final fontObjectCmap = <int, Map<int, int>>{};
  for (final entry in objects.entries) {
    final link = RegExp(r'/ToUnicode\s+(\d+)\s+0\s+R').firstMatch(entry.value);
    if (link == null) continue;
    final map = cmaps[int.parse(link.group(1)!)];
    if (map != null) fontObjectCmap[entry.key] = map;
  }
  final named = <String, Map<int, int>>{};
  for (final entry in objects.entries) {
    if (!entry.value.contains('/Font')) continue;
    for (final link in RegExp(r'/(F\d+)\s+(\d+)\s+0\s+R').allMatches(entry.value)) {
      final map = fontObjectCmap[int.parse(link.group(2)!)];
      if (map != null) named[link.group(1)!] = map;
    }
  }
  final text = StringBuffer();
  for (final entry in objects.entries) {
    if (!entry.value.contains('TJ') && !entry.value.contains('Tj')) continue;
    Map<int, int>? current;
    final tokens = RegExp(r'/(F\d+)\s+[\d.]+\s+Tf|<([0-9A-Fa-f]+)>\s*Tj|\[<([0-9A-Fa-f]+)>\]\s*TJ');
    for (final token in tokens.allMatches(entry.value)) {
      if (token.group(1) != null) {
        current = named[token.group(1)];
        continue;
      }
      final hex = token.group(2) ?? token.group(3);
      if (hex == null || current == null) continue;
      for (var index = 0; index + 4 <= hex.length; index += 4) {
        final code = current[int.parse(hex.substring(index, index + 4), radix: 16)];
        if (code != null && code > 0) text.writeCharCode(code);
      }
    }
  }
  return text.toString();
}

String _flat(String value) => value.replaceAll(RegExp(r'\s+'), '');

int pdfPageCount(List<int> bytes) {
  final source = latin1.decode(bytes, allowInvalid: true);
  return RegExp(r'/Type\s*/Page(?!s)').allMatches(source).length;
}

void main() {
  late Uint8List regular;
  late Uint8List bold;

  setUpAll(() {
    regular = File('assets/fonts/NotoSans-Regular.ttf').readAsBytesSync();
    bold = File('assets/fonts/NotoSans-Bold.ttf').readAsBytesSync();
  });

  InvoicePdfData sample({String template = 'corporate', int lines = 2, String description = 'Short'}) {
    return InvoicePdfData(
      template: template,
      number: 'INV-2026-0001',
      statusLabel: 'Paid',
      issueDate: '25 Oct 2026',
      dueDate: '1 Nov 2026',
      business: const PdfParty(
        name: 'Ada Stores Limited',
        tradingName: 'Ada Stores',
        phone: '08030000000',
        email: 'ada@example.com',
        address: '12 Market Road, Lagos',
        extra: 'TIN 12345678',
      ),
      customer: const PdfParty(name: 'A very long customer name that should wrap inside the bill-to column without breaking the page'),
      lines: [
        for (var i = 0; i < lines; i++)
          PdfLine(
            name: 'Service $i',
            description: description,
            quantity: '1',
            unit: 'Piece',
            unitPrice: '₦50,000',
            total: '₦50,000',
          ),
      ],
      subtotal: '₦100,000',
      discount: '₦0',
      tax: '₦7,500',
      charges: '₦0',
      grand: '₦107,500',
      paid: '₦107,500',
      outstanding: '₦0',
      showDiscount: false,
      showTax: true,
      showCharges: false,
      showPaid: true,
      bankText: 'GTBank\nAda Stores\n0123456789',
      paymentInstructions: 'Please transfer the total and reply to confirm.',
      notes: 'Thank you.',
      terms: 'Payment is due within 7 days.',
      footer: 'Ada Stores · Lagos',
      tagline: 'Made for the neighbourhood',
      primaryHex: '#1B2A4A',
      accentHex: '#0E8F62',
    );
  }

  test('each template renders naira text offline', () async {
    for (final template in ['corporate', 'minimal', 'premium', 'compact']) {
      final bytes = await buildInvoicePdf(
        data: sample(template: template),
        regularFont: regular,
        boldFont: bold,
        compress: false,
      );
      expect(latin1.decode(bytes.sublist(0, 5)), '%PDF-');
      final text = pdfText(bytes);
      expect(text, contains('INV-2026-0001'));
      expect(_flat(text), contains(_flat('Ada Stores')));
      expect(text, contains('₦'));
      expect(text, contains('0123456789'));
    }
  });

  test('long descriptions flow onto another page', () async {
    final bytes = await buildInvoicePdf(
      data: sample(lines: 40, description: 'Detailed work ' * 30),
      regularFont: regular,
      boldFont: bold,
      compress: false,
    );
    expect(pdfPageCount(bytes), greaterThan(1));
    expect(_flat(pdfText(bytes)), contains(_flat('Detailed work')));
  });

  test('receipt and report pdfs render', () async {
    final receipt = await buildReceiptPdf(
      data: const ReceiptPdfData(
        number: 'RCT-2026-0001',
        invoiceNumber: 'INV-2026-0001',
        marker: 'PAID',
        business: PdfParty(name: 'Ada Stores', phone: '08030000000'),
        customer: PdfParty(name: 'Kemi'),
        amount: '₦75,000',
        date: '25 Oct 2026',
        method: 'Bank transfer',
        reference: 'TRF-1',
        remaining: '₦0',
        primaryHex: '#1B2A4A',
      ),
      regularFont: regular,
      boldFont: bold,
      compress: false,
    );
    expect(_flat(pdfText(receipt)), contains('RCT-2026-0001'));
    final report = await buildReportPdf(
      data: const ReportPdfData(
        title: 'Reports',
        rangeLabel: 'This month',
        businessName: 'Ada Stores',
        rows: [('Invoiced', '₦10,000'), ('Received', '₦4,000')],
        sections: [('By service', [('Design', '₦10,000')])],
      ),
      regularFont: regular,
      boldFont: bold,
      compress: false,
    );
    expect(_flat(pdfText(report)), contains('Received'));
  });
}
