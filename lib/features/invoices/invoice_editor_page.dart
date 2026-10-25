import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../core/errors.dart';
import '../../core/format.dart';
import '../../core/invoicing/enums.dart';
import '../../core/invoicing/invoice_math.dart';
import '../../core/invoicing/invoice_rules.dart';
import '../../core/money/money.dart';
import '../../core/widgets/ui.dart';
import '../../domain/models.dart';
import '../shared/support.dart';

class _LineDraft {
  _LineDraft({
    this.serviceId,
    String name = '',
    String description = '',
    String quantity = '1',
    String price = '',
    this.unit = 'item',
    String? customUnit,
    this.brandingMode = BrandingMode.business,
    this.bankAccountId,
  }) : name = TextEditingController(text: name),
       description = TextEditingController(text: description),
       quantity = TextEditingController(text: quantity),
       price = TextEditingController(text: price),
       customUnit = TextEditingController(text: customUnit ?? '');

  final String? serviceId;
  final TextEditingController name;
  final TextEditingController description;
  final TextEditingController quantity;
  final TextEditingController price;
  final TextEditingController customUnit;
  String unit;
  BrandingMode brandingMode;
  String? bankAccountId;

  void dispose() {
    name.dispose();
    description.dispose();
    quantity.dispose();
    price.dispose();
    customUnit.dispose();
  }
}

class InvoiceEditorPage extends ConsumerStatefulWidget {
  const InvoiceEditorPage({super.key, this.invoiceId, this.customerId});

  final String? invoiceId;
  final String? customerId;

  @override
  ConsumerState<InvoiceEditorPage> createState() => _InvoiceEditorPageState();
}

class _InvoiceEditorPageState extends ConsumerState<InvoiceEditorPage> {
  final _customerName = TextEditingController();
  final _customerPhone = TextEditingController();
  final _customerWhatsapp = TextEditingController();
  final _customerEmail = TextEditingController();
  final _customerAddress = TextEditingController();
  final _search = TextEditingController();
  final _discount = TextEditingController(text: '0');
  final _tax = TextEditingController(text: '0');
  final _charges = TextEditingController(text: '0');
  final _notes = TextEditingController();
  final _instructions = TextEditingController();
  final _lines = <_LineDraft>[];
  String? _customerId;
  var _saveCustomer = true;
  var _step = 0;
  var _loading = true;
  var _saving = false;
  String _currency = 'NGN';
  DateTime _issueDate = DateTime.now();
  DateTime _dueDate = DateTime.now();
  TermsPreset _terms = TermsPreset.days7;
  String? _bankId;
  int _paidMinor = 0;
  List<ServiceItem> _services = const [];
  List<BankAccount> _banks = const [];
  List<CustomerItem> _matches = const [];
  String _savedNotes = '';

  @override
  void initState() {
    super.initState();
    _prepare();
  }

  Future<void> _prepare() async {
    final store = ref.read(storeProvider);
    final settings = await store.loadSettings();
    _services = await store.services(activeOnly: true);
    _banks = await store.bankAccounts(activeOnly: true);
    _currency = settings.defaultCurrency;
    _terms = settings.defaultTermsPreset;
    _issueDate = dateOnly(DateTime.now());
    _dueDate = dueDateFor(_issueDate, _terms);
    _notes.text = settings.defaultNotes;
    _savedNotes = settings.defaultNotes;
    _instructions.text = settings.defaultPaymentInstructions.isEmpty
        ? defaultPaymentInstructions
        : settings.defaultPaymentInstructions;
    if (settings.taxEnabled) _tax.text = formatBps(settings.defaultTaxRateBps);
    final requested = widget.customerId;
    if (requested != null) {
      final customer = await store.customer(requested);
      if (customer != null) _applyCustomer(customer, save: false);
    }
    if (widget.invoiceId != null) {
      final invoice = await store.invoice(widget.invoiceId!);
      _customerId = invoice.customerId;
      _saveCustomer = false;
      _customerName.text = invoice.customerName;
      _customerPhone.text = invoice.customerPhone;
      _customerWhatsapp.text = invoice.customerWhatsapp;
      _customerEmail.text = invoice.customerEmail ?? '';
      _customerAddress.text = invoice.customerAddress ?? '';
      _currency = invoice.currency;
      _issueDate = dateOnly(invoice.issueDate);
      _dueDate = dateOnly(invoice.dueDate);
      _terms = invoice.termsPreset;
      _bankId = invoice.bankAccountId;
      _paidMinor = invoice.paidMinor;
      _discount.text = minorInput(invoice.discountMinor);
      _tax.text = formatBps(invoice.taxRateBps);
      _charges.text = minorInput(invoice.chargesMinor);
      _notes.text = invoice.notes ?? '';
      _instructions.text = invoice.paymentInstructions;
      for (final line in invoice.lines) {
        _lines.add(
          _LineDraft(
            serviceId: line.serviceId,
            name: line.name,
            description: line.description,
            quantity: formatQuantity(line.quantityMilli),
            price: minorInput(line.unitPriceMinor),
            unit: line.unit,
            customUnit: line.customUnit,
            brandingMode: line.brandingMode,
            bankAccountId: line.bankAccountId,
          ),
        );
      }
    }
    if (mounted) setState(() => _loading = false);
  }

  void _applyCustomer(CustomerItem customer, {required bool save}) {
    _customerId = customer.id;
    _saveCustomer = save;
    _customerName.text = customer.name;
    _customerPhone.text = customer.phone;
    _customerWhatsapp.text = customer.whatsapp;
    _customerEmail.text = customer.email ?? '';
    _customerAddress.text = customer.address ?? '';
  }

  @override
  void dispose() {
    for (final controller in [
      _customerName,
      _customerPhone,
      _customerWhatsapp,
      _customerEmail,
      _customerAddress,
      _search,
      _discount,
      _tax,
      _charges,
      _notes,
      _instructions,
    ]) {
      controller.dispose();
    }
    for (final line in _lines) {
      line.dispose();
    }
    super.dispose();
  }

  BankSelection get _bankSelection => selectPaymentAccounts(
    serviceAccountIds: _lines.map((line) => line.bankAccountId).toList(),
    businessDefaultAccountId: _banks.where((bank) => bank.isDefault).map((bank) => bank.id).firstOrNull,
  );

  InvoiceTotals? get _totals {
    try {
      return computeTotals(
        lines: [
          for (final line in _lines)
            (
              quantityMilli: parseQuantityMilli(line.quantity.text),
              unitPriceMinor: line.price.text.trim().isEmpty ? 0 : parseMoneyToMinor(line.price.text),
            ),
        ],
        discountMinor: _discount.text.trim().isEmpty ? 0 : parseMoneyToMinor(_discount.text),
        taxRateBps: parsePercentToBps(_tax.text),
        chargesMinor: _charges.text.trim().isEmpty ? 0 : parseMoneyToMinor(_charges.text),
      );
    } on InvoxaException {
      return null;
    }
  }

  Future<void> _searchCustomers(String query) async {
    final matches = await ref.read(storeProvider).searchCustomers(query);
    if (mounted) setState(() => _matches = matches.take(6).toList());
  }

  void _addService(ServiceItem service) {
    if (_lines.isNotEmpty && service.currency != _currency) {
      showNotice(context, 'This invoice is in $_currency. Add a line in that currency.');
      return;
    }
    _currency = service.currency;
    setState(() {
      _lines.add(
        _LineDraft(
          serviceId: service.id,
          name: service.name,
          description: service.description,
          price: minorInput(service.defaultPriceMinor),
          unit: service.unit,
          customUnit: service.customUnit,
          brandingMode: service.brandingMode,
          bankAccountId: service.bankAccountId,
        ),
      );
      _bankId ??= _bankSelection.suggestedId;
    });
  }

  void _addCustom() {
    setState(() {
      _lines.add(_LineDraft());
    });
  }

  Future<void> _pickDate({required bool due}) async {
    final initial = due ? _dueDate : _issueDate;
    final picked = await showDatePicker(context: context, initialDate: initial, firstDate: DateTime(2020), lastDate: DateTime(2100));
    if (picked == null) return;
    setState(() {
      if (due) {
        _dueDate = dateOnly(picked);
        _terms = TermsPreset.custom;
      } else {
        _issueDate = dateOnly(picked);
        if (_terms != TermsPreset.custom) _dueDate = dueDateFor(_issueDate, _terms);
      }
    });
  }

  Future<void> _save({required bool issue}) async {
    if (_saving) return;
    final totals = _totals;
    if (totals == null) {
      showNotice(context, 'Check the quantities, prices, discount, and tax.');
      return;
    }
    if (_bankSelection.needsChoice && (_bankId == null || _bankId!.isEmpty)) {
      showNotice(context, 'These services use different accounts. Choose where the customer should pay.');
      return;
    }
    setState(() => _saving = true);
    final detail = await guard(context, () {
      return ref.read(storeProvider).saveInvoice(
        InvoiceWrite(
          id: widget.invoiceId,
          issue: issue,
          customerId: _customerId,
          saveCustomer: _saveCustomer,
          customerName: _customerName.text,
          customerPhone: _customerPhone.text,
          customerWhatsapp: _customerWhatsapp.text,
          customerEmail: _customerEmail.text,
          customerAddress: _customerAddress.text,
          lines: [
            for (final line in _lines)
              InvoiceLineInput(
                serviceId: line.serviceId,
                name: line.name.text,
                description: line.description.text,
                quantityMilli: parseQuantityMilli(line.quantity.text),
                unit: line.unit,
                customUnit: line.unit == 'custom' && line.customUnit.text.trim().isNotEmpty ? line.customUnit.text.trim() : null,
                unitPriceMinor: line.price.text.trim().isEmpty ? 0 : parseMoneyToMinor(line.price.text),
                brandingMode: line.brandingMode,
                bankAccountId: line.bankAccountId,
              ),
          ],
          discountMinor: totals.discountMinor,
          taxRateBps: parsePercentToBps(_tax.text),
          chargesMinor: totals.chargesMinor,
          currency: _currency,
          bankAccountId: _bankId ?? _bankSelection.suggestedId,
          issueDate: _issueDate,
          dueDate: _dueDate,
          terms: _terms,
          notes: _notes.text,
          paymentInstructions: _instructions.text,
        ),
      );
    });
    if (!mounted) return;
    setState(() => _saving = false);
    if (detail == null) return;
    refresh(ref);
    context.go('/invoices/${detail.id}');
  }

  Future<void> _saveNoteDefault() async {
    final settings = await ref.read(storeProvider).loadSettings();
    await ref.read(storeProvider).saveSettings(settings.copyWith(defaultNotes: _notes.text));
    if (mounted) showNotice(context, 'This note will be used on the next invoice.');
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: LoadingView());
    return PageScaffold(
      title: widget.invoiceId == null ? 'New invoice' : 'Edit invoice',
      bottom: Row(
        children: [
          if (_step > 0)
            Expanded(
              child: OutlinedButton(onPressed: () => setState(() => _step -= 1), child: const Text('Back')),
            ),
          if (_step > 0) const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: _saving
                  ? null
                  : () {
                      if (_step == 0) {
                        if (_customerName.text.trim().isEmpty) {
                          showNotice(context, 'Enter the customer name.');
                          return;
                        }
                        setState(() => _step = 1);
                      } else if (_step == 1) {
                        if (_lines.isEmpty) {
                          showNotice(context, 'Add a service or a line.');
                          return;
                        }
                        setState(() => _step = 2);
                      } else {
                        _save(issue: true);
                      }
                    },
              child: Text(_step < 2 ? 'Continue' : 'Generate and share'),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
        children: [
          Text(['Customer', 'Items', 'Review'][_step], style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          if (_step == 0) ..._customerStep(),
          if (_step == 1) ..._itemStep(),
          if (_step == 2) ..._reviewStep(),
        ],
      ),
    );
  }

  List<Widget> _customerStep() {
    return [
      TextField(
        controller: _search,
        decoration: const InputDecoration(labelText: 'Search saved customers', hintText: 'Name or phone'),
        onChanged: _searchCustomers,
      ),
      const SizedBox(height: 8),
      for (final customer in _matches)
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(customer.name),
          subtitle: Text(customer.phone),
          onTap: () => setState(() => _applyCustomer(customer, save: false)),
        ),
      const SizedBox(height: 8),
      InvoxaField(label: 'Customer or company', controller: _customerName, onChanged: (_) {
        _customerId = null;
        setState(() {});
      }),
      InvoxaField(label: 'Phone', controller: _customerPhone, keyboardType: TextInputType.phone),
      InvoxaField(label: 'WhatsApp', controller: _customerWhatsapp, keyboardType: TextInputType.phone),
      InvoxaField(label: 'Email (optional)', controller: _customerEmail),
      InvoxaField(label: 'Address (optional)', controller: _customerAddress, maxLines: 2),
      SwitchListTile(
        contentPadding: EdgeInsets.zero,
        title: Text(_customerId == null ? 'Save this customer' : 'Update the saved customer'),
        subtitle: Text(_saveCustomer ? 'They will be in your customer list.' : 'This invoice only. The customer list stays as it is.'),
        value: _saveCustomer,
        onChanged: (value) => setState(() => _saveCustomer = value),
      ),
    ];
  }

  List<Widget> _itemStep() {
    return [
      if (_services.isEmpty)
        const InvoxaCard(child: Text('No services yet. Add a custom line, or create a service from the dashboard.'))
      else
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final service in _services)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ActionChip(
                    label: Text(service.name),
                    onPressed: () => _addService(service),
                  ),
                ),
            ],
          ),
        ),
      const SizedBox(height: 8),
      OutlinedButton(onPressed: _addCustom, child: const Text('Add a custom line')),
      const SizedBox(height: 12),
      for (var index = 0; index < _lines.length; index++) _lineCard(index),
    ];
  }

  Widget _lineCard(int index) {
    final line = _lines[index];
    int? total;
    try {
      total = lineTotalMinor(
        parseQuantityMilli(line.quantity.text),
        line.price.text.trim().isEmpty ? 0 : parseMoneyToMinor(line.price.text),
      );
    } on InvoxaException {
      total = null;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InvoxaCard(
        child: Column(
          children: [
            InvoxaField(label: 'Name', controller: line.name),
            InvoxaField(label: 'Description', controller: line.description, maxLines: 2),
            InvoxaField(label: 'Quantity', controller: line.quantity, keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: (_) => setState(() {})),
            DropdownButtonFormField<String>(
              initialValue: UnitType.values.any((unit) => unit.storage == line.unit) ? line.unit : 'item',
              decoration: const InputDecoration(labelText: 'Unit'),
              items: [
                for (final unit in UnitType.values) DropdownMenuItem(value: unit.storage, child: Text(unit.label)),
              ],
              onChanged: (value) => setState(() => line.unit = value ?? 'item'),
            ),
            if (line.unit == 'custom') ...[
              const SizedBox(height: 12),
              InvoxaField(label: 'Custom unit', controller: line.customUnit),
            ],
            const SizedBox(height: 12),
            InvoxaField(
              label: 'Unit price',
              controller: line.price,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) => setState(() {}),
            ),
            Row(
              children: [
                Expanded(child: Text(total == null ? 'Check this line' : formatMoney(total, _currency), style: const TextStyle(fontWeight: FontWeight.w700))),
                IconButton(
                  tooltip: 'Remove line',
                  onPressed: () => setState(() {
                    line.dispose();
                    _lines.removeAt(index);
                  }),
                  icon: const Icon(Icons.delete_outline),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _reviewStep() {
    final totals = _totals;
    final selection = _bankSelection;
    final banks = selection.needsChoice
        ? _banks.where((bank) => selection.accountIds.contains(bank.id)).toList()
        : _banks;
    return [
      if (_paidMinor > 0)
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Text('Payments of ${formatMoney(_paidMinor, _currency)} are already recorded. The total cannot go below that.'),
        ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Issue date'),
        subtitle: Text(formatLongDate(_issueDate)),
        onTap: () => _pickDate(due: false),
      ),
      const SectionTitle('Payment terms'),
      Wrap(
        spacing: 8,
        children: [
          for (final preset in TermsPreset.values)
            ChoiceChip(
              label: Text(preset.label),
              selected: _terms == preset,
              onSelected: (_) => setState(() {
                _terms = preset;
                if (preset != TermsPreset.custom) _dueDate = dueDateFor(_issueDate, preset);
              }),
            ),
        ],
      ),
      ListTile(
        contentPadding: EdgeInsets.zero,
        title: const Text('Due date'),
        subtitle: Text(formatLongDate(_dueDate)),
        onTap: () => _pickDate(due: true),
      ),
      InvoxaField(label: 'Discount', controller: _discount, keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: (_) => setState(() {})),
      InvoxaField(label: 'Tax percent', controller: _tax, keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: (_) => setState(() {})),
      InvoxaField(label: 'Additional charges', controller: _charges, keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: (_) => setState(() {})),
      if (selection.needsChoice)
        const Text('These services use different accounts. Choose where the customer should pay.'),
      if (banks.isNotEmpty)
        DropdownButtonFormField<String>(
          initialValue: banks.any((bank) => bank.id == _bankId) ? _bankId : selection.suggestedId,
          decoration: const InputDecoration(labelText: 'Payment account'),
          items: [
            for (final bank in banks) DropdownMenuItem(value: bank.id, child: Text(bank.displayLabel)),
          ],
          onChanged: (value) => setState(() => _bankId = value),
        ),
      const SizedBox(height: 12),
      InvoxaCard(
        child: totals == null
            ? const Text('Totals will appear when every line has a quantity and price.')
            : Column(
                children: [
                  _total('Subtotal', totals.subtotalMinor),
                  _total('Discount', totals.discountMinor),
                  _total('Tax', totals.taxMinor),
                  _total('Charges', totals.chargesMinor),
                  const Divider(),
                  _total('Grand total', totals.grandMinor, strong: true),
                  _total('Outstanding', outstandingMinor(totals.grandMinor, _paidMinor)),
                ],
              ),
      ),
      const SizedBox(height: 12),
      InvoxaField(label: 'Notes', controller: _notes, maxLines: 3),
      Align(
        alignment: Alignment.centerLeft,
        child: TextButton(onPressed: _notes.text == _savedNotes ? null : _saveNoteDefault, child: const Text('Save this note for next time')),
      ),
      InvoxaField(label: 'Payment instructions', controller: _instructions, maxLines: 3),
      const SizedBox(height: 8),
      OutlinedButton(onPressed: _saving ? null : () => _save(issue: false), child: const Text('Save draft')),
    ];
  }

  Widget _total(String label, int minor, {bool strong = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontWeight: strong ? FontWeight.w700 : FontWeight.w500))),
          Text(formatMoney(minor, _currency), style: TextStyle(fontWeight: strong ? FontWeight.w700 : FontWeight.w500)),
        ],
      ),
    );
  }
}
