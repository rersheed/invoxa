import '../errors.dart';
import '../money/money.dart';

const invoiceCsvHeaders = [
  'number',
  'status',
  'issue_date',
  'due_date',
  'customer',
  'phone',
  'currency',
  'subtotal',
  'discount',
  'tax',
  'charges',
  'grand',
  'paid',
  'outstanding',
  'service',
  'notes',
];

class CsvInvoiceRow {
  const CsvInvoiceRow({
    required this.number,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    required this.customer,
    required this.phone,
    required this.currency,
    required this.subtotalMinor,
    required this.discountMinor,
    required this.taxMinor,
    required this.chargesMinor,
    required this.grandMinor,
    required this.paidMinor,
    required this.outstandingMinor,
    required this.service,
    required this.notes,
  });

  final String number;
  final String status;
  final String issueDate;
  final String dueDate;
  final String customer;
  final String phone;
  final String currency;
  final int subtotalMinor;
  final int discountMinor;
  final int taxMinor;
  final int chargesMinor;
  final int grandMinor;
  final int paidMinor;
  final int outstandingMinor;
  final String service;
  final String notes;
}

String invoicesToCsv(List<CsvInvoiceRow> rows) {
  final lines = <List<String>>[
    invoiceCsvHeaders,
    for (final row in rows)
      [
        row.number,
        row.status,
        row.issueDate,
        row.dueDate,
        row.customer,
        row.phone,
        row.currency,
        formatMoney(row.subtotalMinor, row.currency, forceDecimals: true),
        formatMoney(row.discountMinor, row.currency, forceDecimals: true),
        formatMoney(row.taxMinor, row.currency, forceDecimals: true),
        formatMoney(row.chargesMinor, row.currency, forceDecimals: true),
        formatMoney(row.grandMinor, row.currency, forceDecimals: true),
        formatMoney(row.paidMinor, row.currency, forceDecimals: true),
        formatMoney(row.outstandingMinor, row.currency, forceDecimals: true),
        row.service,
        row.notes,
      ],
  ];
  return lines.map(_encodeRow).join('\n');
}

String _encodeRow(List<String> cells) => cells.map(_encodeCell).join(',');

String _encodeCell(String value) {
  if (value.contains(',') || value.contains('"') || value.contains('\n')) {
    return '"${value.replaceAll('"', '""')}"';
  }
  return value;
}

List<List<String>> parseCsv(String input) {
  final rows = <List<String>>[];
  final row = <String>[];
  final cell = StringBuffer();
  var quoted = false;
  final text = input.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
  for (var i = 0; i < text.length; i++) {
    final char = text[i];
    if (quoted) {
      if (char == '"') {
        if (i + 1 < text.length && text[i + 1] == '"') {
          cell.write('"');
          i += 1;
        } else {
          quoted = false;
        }
      } else {
        cell.write(char);
      }
      continue;
    }
    if (char == '"') {
      quoted = true;
    } else if (char == ',') {
      row.add(cell.toString());
      cell.clear();
    } else if (char == '\n') {
      row.add(cell.toString());
      cell.clear();
      if (row.any((value) => value.isNotEmpty)) rows.add(List.of(row));
      row.clear();
    } else {
      cell.write(char);
    }
  }
  if (quoted) throw InvoxaException('The CSV file is incomplete.');
  if (cell.isNotEmpty || row.isNotEmpty) {
    row.add(cell.toString());
    if (row.any((value) => value.isNotEmpty)) rows.add(List.of(row));
  }
  return rows;
}

List<CsvInvoiceRow> parseInvoiceCsv(String input) {
  final rows = parseCsv(input);
  if (rows.isEmpty) throw InvoxaException('The CSV file is empty.');
  final header = rows.first.map((cell) => cell.trim().toLowerCase()).toList();
  for (final required in ['customer', 'grand', 'issue_date']) {
    if (!header.contains(required)) {
      throw InvoxaException('The CSV file needs a $required column.');
    }
  }
  int index(String name) => header.indexOf(name);
  String cell(List<String> row, String name) {
    final at = index(name);
    if (at < 0 || at >= row.length) return '';
    return row[at].trim();
  }

  final parsed = <CsvInvoiceRow>[];
  for (var i = 1; i < rows.length; i++) {
    final row = rows[i];
    final customer = cell(row, 'customer');
    if (customer.isEmpty) {
      throw InvoxaException('Row ${i + 1} is missing a customer.');
    }
    final currency = cell(row, 'currency').isEmpty ? 'NGN' : cell(row, 'currency').toUpperCase();
    final grand = parseMoneyToMinor(cell(row, 'grand'));
    final issue = cell(row, 'issue_date');
    if (DateTime.tryParse(issue) == null) {
      throw InvoxaException('Row ${i + 1} has a damaged issue date. Use YYYY-MM-DD.');
    }
    final due = cell(row, 'due_date').isEmpty ? issue : cell(row, 'due_date');
    if (DateTime.tryParse(due) == null) {
      throw InvoxaException('Row ${i + 1} has a damaged due date. Use YYYY-MM-DD.');
    }
    parsed.add(
      CsvInvoiceRow(
        number: cell(row, 'number'),
        status: cell(row, 'status').isEmpty ? 'unpaid' : cell(row, 'status'),
        issueDate: issue,
        dueDate: due,
        customer: customer,
        phone: cell(row, 'phone'),
        currency: currency,
        subtotalMinor: cell(row, 'subtotal').isEmpty ? grand : parseMoneyToMinor(cell(row, 'subtotal')),
        discountMinor: cell(row, 'discount').isEmpty ? 0 : parseMoneyToMinor(cell(row, 'discount')),
        taxMinor: cell(row, 'tax').isEmpty ? 0 : parseMoneyToMinor(cell(row, 'tax')),
        chargesMinor: cell(row, 'charges').isEmpty ? 0 : parseMoneyToMinor(cell(row, 'charges')),
        grandMinor: grand,
        paidMinor: cell(row, 'paid').isEmpty ? 0 : parseMoneyToMinor(cell(row, 'paid')),
        outstandingMinor: cell(row, 'outstanding').isEmpty
            ? grand
            : parseMoneyToMinor(cell(row, 'outstanding')),
        service: cell(row, 'service').isEmpty ? 'Service' : cell(row, 'service'),
        notes: cell(row, 'notes'),
      ),
    );
  }
  return parsed;
}
