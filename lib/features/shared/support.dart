import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/errors.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/messaging/messages.dart';
import '../../core/money/money.dart';
import '../../core/pdf/document_pdf.dart';
import '../../core/widgets/ui.dart';
import '../../data/pdf_mapper.dart';
import '../../domain/models.dart';

class PdfFonts {
  Uint8List? regular;
  Uint8List? bold;

  Future<void> load() async {
    if (regular != null && bold != null) return;
    final regularData = await rootBundle.load('assets/fonts/NotoSans-Regular.ttf');
    final boldData = await rootBundle.load('assets/fonts/NotoSans-Bold.ttf');
    regular = regularData.buffer.asUint8List(regularData.offsetInBytes, regularData.lengthInBytes);
    bold = boldData.buffer.asUint8List(boldData.offsetInBytes, boldData.lengthInBytes);
  }
}

final pdfFonts = PdfFonts();

Future<T?> guard<T>(BuildContext context, Future<T> Function() action) async {
  try {
    return await action();
  } on InvoxaException catch (error) {
    if (context.mounted) showNotice(context, error.message);
  } on Object {
    if (context.mounted) showNotice(context, 'That could not be completed.');
  }
  return null;
}

Future<Uint8List> invoicePdfBytes(InvoiceDetail invoice) async {
  await pdfFonts.load();
  return buildInvoicePdf(data: invoiceToPdf(invoice), regularFont: pdfFonts.regular!, boldFont: pdfFonts.bold!);
}

Future<Uint8List> receiptPdfBytes(ReceiptItem receipt, String currency) async {
  await pdfFonts.load();
  return buildReceiptPdf(
    data: receiptToPdf(receipt: receipt, currency: currency),
    regularFont: pdfFonts.regular!,
    boldFont: pdfFonts.bold!,
  );
}

Future<void> shareFile(Uint8List bytes, String filename, String mime) async {
  final directory = await getTemporaryDirectory();
  final file = File('${directory.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);
  await SharePlus.instance.share(
    ShareParams(files: [XFile(file.path, mimeType: mime, name: filename)]),
  );
}

Future<bool> saveFile(Uint8List bytes, String filename, String mime) async {
  final saved = await FilePicker.saveFile(fileName: filename, bytes: bytes, mimeType: mime, dialogTitle: 'Save $filename');
  return saved != null;
}

String bankLines(Map<String, Object?>? bank) {
  if (bank == null) return '';
  return [
    bank['label'],
    bank['bankName'],
    bank['accountName'],
    bank['accountNumber'],
  ].whereType<String>().where((line) => line.trim().isNotEmpty).join('\n');
}

InvoiceMessageInput messageInput(
  InvoiceDetail invoice, {
  required String businessName,
  required String phone,
  int? amountMinor,
}) {
  final quantities = invoice.lines.map((line) => '${formatQuantity(line.quantityMilli)} ${unitLabel(line.unit, line.customUnit)}').join(', ');
  return InvoiceMessageInput(
    customerName: invoice.customerName,
    invoiceNumber: invoice.number ?? 'Draft',
    serviceSummary: invoice.lines.map((line) => line.name).join(', '),
    quantitySummary: quantities,
    totalMinor: invoice.grandMinor,
    outstandingMinor: invoice.outstandingMinor,
    amountMinor: amountMinor ?? invoice.paidMinor,
    currency: invoice.currency,
    dueDateLabel: formatLongDate(invoice.dueDate),
    bankText: bankLines(invoice.bankSnapshot),
    businessName: businessName,
    phone: phone,
    statusLabel: invoice.status.label,
    now: DateTime.now(),
  );
}

Future<bool> openWhatsApp({required String number, required String text}) async {
  final international = whatsappNumber(number);
  if (international == null) return false;
  final uri = whatsappUri(international, text);
  try {
    return await launchUrl(uri, mode: LaunchMode.externalApplication);
  } on Object {
    return false;
  }
}

Future<void> openPhone(String number) async {
  final uri = Uri(scheme: 'tel', path: number);
  await launchUrl(uri);
}

Future<void> showMessageSheet(
  BuildContext context, {
  required String title,
  required String initial,
  required String? whatsapp,
  Future<void> Function(String text)? onSent,
}) async {
  final controller = TextEditingController(text: initial);
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 20, 20 + MediaQuery.viewInsetsOf(context).bottom),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text(
              'Edit the message, then copy it or open WhatsApp. The PDF is shared separately. Nothing is sent until you tap send in WhatsApp.',
            ),
            const SizedBox(height: 12),
            TextField(controller: controller, maxLines: 10, decoration: const InputDecoration(alignLabelWithHint: true)),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: controller.text));
                if (context.mounted) showNotice(context, 'Message copied.');
              },
              child: const Text('Copy message'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: (whatsapp == null || whatsapp.trim().isEmpty)
                  ? null
                  : () async {
                      final opened = await openWhatsApp(number: whatsapp, text: controller.text);
                      if (!context.mounted) return;
                      if (!opened) {
                        showNotice(context, 'WhatsApp is not installed, or this number cannot be opened.');
                      }
                    },
              child: const Text('Open WhatsApp'),
            ),
            if (onSent != null) ...[
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () async {
                  await onSent(controller.text);
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Mark as sent'),
              ),
            ],
          ],
        ),
      );
    },
  );
  controller.dispose();
}
