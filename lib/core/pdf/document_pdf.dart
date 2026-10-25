import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfParty {
  const PdfParty({
    required this.name,
    this.tradingName,
    this.phone = '',
    this.email = '',
    this.address = '',
    this.extra = '',
  });

  final String name;
  final String? tradingName;
  final String phone;
  final String email;
  final String address;
  final String extra;

  String get displayName {
    final trading = tradingName?.trim() ?? '';
    if (trading.isEmpty || trading == name) return name;
    return trading;
  }
}

class PdfLine {
  const PdfLine({
    required this.name,
    this.description = '',
    required this.quantity,
    required this.unit,
    required this.unitPrice,
    required this.total,
  });

  final String name;
  final String description;
  final String quantity;
  final String unit;
  final String unitPrice;
  final String total;
}

class InvoicePdfData {
  const InvoicePdfData({
    required this.template,
    required this.number,
    required this.statusLabel,
    required this.issueDate,
    required this.dueDate,
    required this.business,
    required this.customer,
    required this.lines,
    required this.subtotal,
    required this.discount,
    required this.tax,
    required this.charges,
    required this.grand,
    required this.paid,
    required this.outstanding,
    required this.showDiscount,
    required this.showTax,
    required this.showCharges,
    required this.showPaid,
    required this.bankText,
    required this.paymentInstructions,
    this.notes = '',
    this.terms = '',
    this.footer = '',
    this.tagline = '',
    this.logo,
    this.signature,
    this.primaryHex = '#1B2A4A',
    this.secondaryHex = '#243B67',
    this.accentHex = '#0E8F62',
  });

  final String template;
  final String number;
  final String statusLabel;
  final String issueDate;
  final String dueDate;
  final PdfParty business;
  final PdfParty customer;
  final List<PdfLine> lines;
  final String subtotal;
  final String discount;
  final String tax;
  final String charges;
  final String grand;
  final String paid;
  final String outstanding;
  final bool showDiscount;
  final bool showTax;
  final bool showCharges;
  final bool showPaid;
  final String bankText;
  final String paymentInstructions;
  final String notes;
  final String terms;
  final String footer;
  final String tagline;
  final Uint8List? logo;
  final Uint8List? signature;
  final String primaryHex;
  final String secondaryHex;
  final String accentHex;
}

class ReceiptPdfData {
  const ReceiptPdfData({
    required this.number,
    required this.invoiceNumber,
    required this.marker,
    required this.business,
    required this.customer,
    required this.amount,
    required this.date,
    required this.method,
    required this.reference,
    required this.remaining,
    required this.primaryHex,
    this.signature,
    this.footer = '',
  });

  final String number;
  final String invoiceNumber;
  final String marker;
  final PdfParty business;
  final PdfParty customer;
  final String amount;
  final String date;
  final String method;
  final String reference;
  final String remaining;
  final String primaryHex;
  final Uint8List? signature;
  final String footer;
}

class ReportPdfData {
  const ReportPdfData({
    required this.title,
    required this.rangeLabel,
    required this.businessName,
    required this.rows,
    required this.sections,
  });

  final String title;
  final String rangeLabel;
  final String businessName;
  final List<(String, String)> rows;
  final List<(String, List<(String, String)>)> sections;
}

Future<Uint8List> buildInvoicePdf({
  required InvoicePdfData data,
  required Uint8List regularFont,
  required Uint8List boldFont,
  bool compress = true,
}) {
  return _document(regularFont, boldFont, compress, (contextFonts) {
    final style = data.template;
    final primary = PdfColor.fromHex(data.primaryHex);
    final accent = PdfColor.fromHex(data.accentHex);
    final compact = style == 'compact';
    final minimal = style == 'minimal';
    final corporate = style == 'corporate';
    final premium = style == 'premium';
    final margin = compact ? 24.0 : 36.0;
    final titleSize = compact ? 16.0 : 22.0;
    final body = compact ? 8.5 : 10.0;
    return pw.MultiPage(
      pageTheme: pw.PageTheme(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(margin),
        theme: contextFonts,
        buildBackground: premium
            ? (context) => pw.FullPage(
                ignoreMargins: true,
                child: pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Container(width: 10, color: accent),
                ),
              )
            : null,
      ),
      header: (context) {
        if (context.pageNumber == 1) return pw.SizedBox();
        return pw.Container(
          margin: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(data.business.displayName, style: pw.TextStyle(fontSize: body, color: primary)),
              pw.Text(data.number, style: pw.TextStyle(fontSize: body, color: PdfColors.grey700)),
            ],
          ),
        );
      },
      footer: (context) => pw.Column(
        children: [
          pw.SizedBox(height: 8),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(
                child: pw.Text(
                  data.footer.isEmpty ? 'INVOXA · recorded on this device · not bank-verified' : data.footer,
                  style: pw.TextStyle(fontSize: compact ? 7 : 8, color: PdfColors.grey600),
                ),
              ),
              pw.Text(
                'Page ${context.pageNumber} of ${context.pagesCount}',
                style: pw.TextStyle(fontSize: compact ? 7 : 8, color: PdfColors.grey600),
              ),
            ],
          ),
        ],
      ),
      build: (context) => [
        if (corporate)
          pw.Container(
            color: primary,
            padding: const pw.EdgeInsets.all(16),
            child: _identity(data, PdfColors.white, titleSize, body, light: true),
          )
        else
          _identity(data, primary, titleSize, body, light: false),
        if (!minimal) pw.SizedBox(height: compact ? 8 : 14),
        if (minimal)
          pw.Container(height: 0.6, color: PdfColors.grey400, margin: const pw.EdgeInsets.symmetric(vertical: 10)),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(child: _party('Bill to', data.customer, body)),
            pw.SizedBox(width: 16),
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  _meta('Invoice', data.number, body, primary),
                  _meta('Issued', data.issueDate, body, primary),
                  _meta('Due', data.dueDate, body, primary),
                  pw.SizedBox(height: 6),
                  pw.Container(
                    padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    color: _statusColor(data.statusLabel),
                    child: pw.Text(
                      data.statusLabel.toUpperCase(),
                      style: pw.TextStyle(
                        color: PdfColors.white,
                        fontSize: compact ? 8 : 9,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        pw.SizedBox(height: compact ? 8 : 16),
        _tableHeader(primary, body, corporate),
        for (final line in data.lines) ...[
          _lineRow(line, body),
          if (line.description.trim().isNotEmpty)
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 4),
              child: pw.Text(
                line.description,
                style: pw.TextStyle(fontSize: body - 1, color: PdfColors.grey700),
              ),
            ),
        ],
        pw.SizedBox(height: 10),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  if (data.bankText.trim().isNotEmpty) ...[
                    pw.Text('Pay into', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: body, color: primary)),
                    pw.SizedBox(height: 3),
                    pw.Text(data.bankText, style: pw.TextStyle(fontSize: body)),
                    pw.SizedBox(height: 8),
                  ],
                  if (data.paymentInstructions.trim().isNotEmpty)
                    pw.Text(data.paymentInstructions, style: pw.TextStyle(fontSize: body - 0.5, color: PdfColors.grey800)),
                ],
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Container(
              width: compact ? 180 : 210,
              padding: premium ? const pw.EdgeInsets.all(10) : pw.EdgeInsets.zero,
              decoration: premium ? pw.BoxDecoration(border: pw.Border.all(color: accent, width: 1.2)) : null,
              child: pw.Column(
                children: [
                  _total('Subtotal', data.subtotal, body),
                  if (data.showDiscount) _total('Discount', '- ${data.discount}', body),
                  if (data.showTax) _total('Tax', data.tax, body),
                  if (data.showCharges) _total('Charges', data.charges, body),
                  pw.Divider(color: primary, thickness: corporate ? 1.4 : 0.6),
                  _total('Total', data.grand, body + 1, strong: true),
                  if (data.showPaid) _total('Paid', data.paid, body),
                  if (data.showPaid) _total('Outstanding', data.outstanding, body, strong: true),
                ],
              ),
            ),
          ],
        ),
        if (data.notes.trim().isNotEmpty) ...[
          pw.SizedBox(height: 12),
          pw.Text('Notes', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: body, color: primary)),
          pw.Text(data.notes, style: pw.TextStyle(fontSize: body - 0.5)),
        ],
        if (data.terms.trim().isNotEmpty) ...[
          pw.SizedBox(height: 8),
          pw.Text('Terms', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: body, color: primary)),
          pw.Text(data.terms, style: pw.TextStyle(fontSize: body - 0.5)),
        ],
        if (data.signature != null) ...[
          pw.SizedBox(height: 16),
          pw.Image(pw.MemoryImage(data.signature!), height: 48),
          pw.Text('Authorised signature', style: pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
        ],
      ],
    );
  });
}

Future<Uint8List> buildReceiptPdf({
  required ReceiptPdfData data,
  required Uint8List regularFont,
  required Uint8List boldFont,
  bool compress = true,
}) {
  final primary = PdfColor.fromHex(data.primaryHex);
  return _document(regularFont, boldFont, compress, (theme) {
    return pw.MultiPage(
      pageTheme: pw.PageTheme(pageFormat: PdfPageFormat.a4, margin: const pw.EdgeInsets.all(36), theme: theme),
      footer: (context) => pw.Text(
        data.footer.isEmpty ? 'INVOXA · recorded on this device · not bank-verified' : data.footer,
        style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
      ),
      build: (context) => [
        pw.Text(data.business.displayName, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold, color: primary)),
        if (data.business.address.isNotEmpty) pw.Text(data.business.address, style: const pw.TextStyle(fontSize: 10)),
        if (data.business.phone.isNotEmpty) pw.Text(data.business.phone, style: const pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 16),
        pw.Text('Receipt ${data.number}', style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 6),
        pw.Container(
          padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          color: data.marker == 'PAID' ? PdfColor.fromHex('#0E8F62') : PdfColor.fromHex('#8A5A00'),
          child: pw.Text(data.marker, style: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10)),
        ),
        pw.SizedBox(height: 14),
        _meta('Customer', data.customer.displayName, 11, primary),
        _meta('Invoice', data.invoiceNumber, 11, primary),
        _meta('Amount', data.amount, 11, primary),
        _meta('Date', data.date, 11, primary),
        _meta('Method', data.method, 11, primary),
        if (data.reference.isNotEmpty) _meta('Reference', data.reference, 11, primary),
        _meta('Remaining balance', data.remaining, 11, primary),
        if (data.signature != null) ...[
          pw.SizedBox(height: 20),
          pw.Image(pw.MemoryImage(data.signature!), height: 48),
          pw.Text('Authorised signature', style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey700)),
        ],
      ],
    );
  });
}

Future<Uint8List> buildReportPdf({
  required ReportPdfData data,
  required Uint8List regularFont,
  required Uint8List boldFont,
  bool compress = true,
}) {
  return _document(regularFont, boldFont, compress, (theme) {
    return pw.MultiPage(
      pageTheme: pw.PageTheme(pageFormat: PdfPageFormat.a4, margin: const pw.EdgeInsets.all(36), theme: theme),
      footer: (context) => pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
      ),
      build: (context) => [
        pw.Text(data.businessName, style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700)),
        pw.Text(data.title, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: PdfColor.fromHex('#1B2A4A'))),
        pw.Text(data.rangeLabel, style: const pw.TextStyle(fontSize: 11)),
        pw.SizedBox(height: 12),
        for (final row in data.rows) _total(row.$1, row.$2, 11, strong: true),
        for (final section in data.sections) ...[
          pw.SizedBox(height: 14),
          pw.Text(section.$1, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 4),
          if (section.$2.isEmpty) pw.Text('Nothing in this period.', style: const pw.TextStyle(fontSize: 10)),
          for (final row in section.$2) _total(row.$1, row.$2, 10),
        ],
      ],
    );
  });
}

Future<Uint8List> _document(
  Uint8List regularFont,
  Uint8List boldFont,
  bool compress,
  pw.Page Function(pw.ThemeData theme) build,
) async {
  final regular = pw.Font.ttf(ByteData.sublistView(regularFont));
  final bold = pw.Font.ttf(ByteData.sublistView(boldFont));
  final theme = pw.ThemeData.withFont(base: regular, bold: bold, italic: regular, boldItalic: bold);
  final doc = pw.Document(compress: compress, theme: theme);
  doc.addPage(build(theme));
  return doc.save();
}

pw.Widget _identity(InvoicePdfData data, PdfColor color, double titleSize, double body, {required bool light}) {
  final muted = light ? PdfColors.grey300 : PdfColors.grey700;
  return pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      if (data.logo != null) ...[
        pw.Container(
          height: 48,
          width: 48,
          child: pw.Image(pw.MemoryImage(data.logo!), fit: pw.BoxFit.contain),
        ),
        pw.SizedBox(width: 10),
      ],
      pw.Expanded(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              data.business.displayName,
              style: pw.TextStyle(fontSize: titleSize, fontWeight: pw.FontWeight.bold, color: color),
            ),
            if ((data.tagline).trim().isNotEmpty)
              pw.Text(data.tagline, style: pw.TextStyle(fontSize: body, color: muted)),
            if (data.business.name != data.business.displayName)
              pw.Text(data.business.name, style: pw.TextStyle(fontSize: body - 1, color: muted)),
            if (data.business.address.isNotEmpty)
              pw.Text(data.business.address, style: pw.TextStyle(fontSize: body - 1, color: muted)),
            pw.Text(
              [data.business.phone, data.business.email].where((part) => part.trim().isNotEmpty).join(' · '),
              style: pw.TextStyle(fontSize: body - 1, color: muted),
            ),
            if (data.business.extra.trim().isNotEmpty)
              pw.Text(data.business.extra, style: pw.TextStyle(fontSize: body - 1, color: muted)),
          ],
        ),
      ),
    ],
  );
}

pw.Widget _party(String label, PdfParty party, double body) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.Text(label.toUpperCase(), style: pw.TextStyle(fontSize: body - 1.5, color: PdfColors.grey600, letterSpacing: 0.6)),
      pw.SizedBox(height: 3),
      pw.Text(party.displayName, style: pw.TextStyle(fontSize: body + 1, fontWeight: pw.FontWeight.bold)),
      if (party.address.isNotEmpty) pw.Text(party.address, style: pw.TextStyle(fontSize: body)),
      if (party.phone.isNotEmpty) pw.Text(party.phone, style: pw.TextStyle(fontSize: body)),
      if (party.email.isNotEmpty) pw.Text(party.email, style: pw.TextStyle(fontSize: body)),
    ],
  );
}

pw.Widget _meta(String label, String value, double body, PdfColor color) {
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 2),
    child: pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(text: '$label  ', style: pw.TextStyle(fontSize: body, color: PdfColors.grey700)),
          pw.TextSpan(
            text: value,
            style: pw.TextStyle(fontSize: body, fontWeight: pw.FontWeight.bold, color: color),
          ),
        ],
      ),
    ),
  );
}

pw.Widget _tableHeader(PdfColor primary, double body, bool filled) {
  final style = pw.TextStyle(
    fontSize: body - 1,
    fontWeight: pw.FontWeight.bold,
    color: filled ? PdfColors.white : primary,
  );
  return pw.Container(
    color: filled ? primary : PdfColors.grey200,
    padding: const pw.EdgeInsets.symmetric(vertical: 5, horizontal: 4),
    child: pw.Row(
      children: [
        pw.Expanded(flex: 5, child: pw.Text('Description', style: style)),
        pw.Expanded(flex: 2, child: pw.Text('Qty', style: style)),
        pw.Expanded(flex: 2, child: pw.Text('Price', style: style, textAlign: pw.TextAlign.right)),
        pw.Expanded(flex: 2, child: pw.Text('Amount', style: style, textAlign: pw.TextAlign.right)),
      ],
    ),
  );
}

pw.Widget _lineRow(PdfLine line, double body) {
  final style = pw.TextStyle(fontSize: body);
  return pw.Container(
    padding: const pw.EdgeInsets.symmetric(vertical: 4, horizontal: 4),
    decoration: const pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(color: PdfColors.grey300, width: 0.4)),
    ),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(flex: 5, child: pw.Text(line.name, style: pw.TextStyle(fontSize: body, fontWeight: pw.FontWeight.bold))),
        pw.Expanded(flex: 2, child: pw.Text('${line.quantity} ${line.unit}', style: style)),
        pw.Expanded(flex: 2, child: pw.Text(line.unitPrice, style: style, textAlign: pw.TextAlign.right)),
        pw.Expanded(flex: 2, child: pw.Text(line.total, style: style, textAlign: pw.TextAlign.right)),
      ],
    ),
  );
}

pw.Widget _total(String label, String value, double body, {bool strong = false}) {
  return pw.Padding(
    padding: const pw.EdgeInsets.symmetric(vertical: 1.5),
    child: pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(label, style: pw.TextStyle(fontSize: body, fontWeight: strong ? pw.FontWeight.bold : pw.FontWeight.normal)),
        pw.Text(value, style: pw.TextStyle(fontSize: body, fontWeight: pw.FontWeight.bold)),
      ],
    ),
  );
}

PdfColor _statusColor(String label) {
  final text = label.toLowerCase();
  if (text.contains('paid') && !text.contains('partial') && !text.contains('unpaid')) {
    return PdfColor.fromHex('#0E8F62');
  }
  if (text.contains('overdue')) return PdfColor.fromHex('#9C2F2F');
  if (text.contains('partial')) return PdfColor.fromHex('#8A5A00');
  if (text.contains('draft')) return PdfColors.grey700;
  if (text.contains('cancel')) return PdfColors.grey700;
  return PdfColor.fromHex('#1B2A4A');
}
