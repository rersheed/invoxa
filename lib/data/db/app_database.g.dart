// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $BusinessesTable extends Businesses
    with TableInfo<$BusinessesTable, BusinessRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BusinessesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _legalNameMeta = const VerificationMeta(
    'legalName',
  );
  @override
  late final GeneratedColumn<String> legalName = GeneratedColumn<String>(
    'legal_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tradingNameMeta = const VerificationMeta(
    'tradingName',
  );
  @override
  late final GeneratedColumn<String> tradingName = GeneratedColumn<String>(
    'trading_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _whatsappMeta = const VerificationMeta(
    'whatsapp',
  );
  @override
  late final GeneratedColumn<String> whatsapp = GeneratedColumn<String>(
    'whatsapp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _websiteMeta = const VerificationMeta(
    'website',
  );
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
    'website',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _registrationNumberMeta =
      const VerificationMeta('registrationNumber');
  @override
  late final GeneratedColumn<String> registrationNumber =
      GeneratedColumn<String>(
        'registration_number',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _tinMeta = const VerificationMeta('tin');
  @override
  late final GeneratedColumn<String> tin = GeneratedColumn<String>(
    'tin',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NGN'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    legalName,
    tradingName,
    phone,
    whatsapp,
    email,
    address,
    website,
    registrationNumber,
    tin,
    description,
    defaultCurrency,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'businesses';
  @override
  VerificationContext validateIntegrity(
    Insertable<BusinessRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('legal_name')) {
      context.handle(
        _legalNameMeta,
        legalName.isAcceptableOrUnknown(data['legal_name']!, _legalNameMeta),
      );
    } else if (isInserting) {
      context.missing(_legalNameMeta);
    }
    if (data.containsKey('trading_name')) {
      context.handle(
        _tradingNameMeta,
        tradingName.isAcceptableOrUnknown(
          data['trading_name']!,
          _tradingNameMeta,
        ),
      );
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    } else if (isInserting) {
      context.missing(_phoneMeta);
    }
    if (data.containsKey('whatsapp')) {
      context.handle(
        _whatsappMeta,
        whatsapp.isAcceptableOrUnknown(data['whatsapp']!, _whatsappMeta),
      );
    } else if (isInserting) {
      context.missing(_whatsappMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    } else if (isInserting) {
      context.missing(_addressMeta);
    }
    if (data.containsKey('website')) {
      context.handle(
        _websiteMeta,
        website.isAcceptableOrUnknown(data['website']!, _websiteMeta),
      );
    }
    if (data.containsKey('registration_number')) {
      context.handle(
        _registrationNumberMeta,
        registrationNumber.isAcceptableOrUnknown(
          data['registration_number']!,
          _registrationNumberMeta,
        ),
      );
    }
    if (data.containsKey('tin')) {
      context.handle(
        _tinMeta,
        tin.isAcceptableOrUnknown(data['tin']!, _tinMeta),
      );
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BusinessRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BusinessRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      legalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}legal_name'],
      )!,
      tradingName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trading_name'],
      ),
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      whatsapp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}whatsapp'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      website: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}website'],
      ),
      registrationNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}registration_number'],
      ),
      tin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tin'],
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BusinessesTable createAlias(String alias) {
    return $BusinessesTable(attachedDatabase, alias);
  }
}

class BusinessRow extends DataClass implements Insertable<BusinessRow> {
  final String id;
  final String legalName;
  final String? tradingName;
  final String phone;
  final String whatsapp;
  final String email;
  final String address;
  final String? website;
  final String? registrationNumber;
  final String? tin;
  final String? description;
  final String defaultCurrency;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BusinessRow({
    required this.id,
    required this.legalName,
    this.tradingName,
    required this.phone,
    required this.whatsapp,
    required this.email,
    required this.address,
    this.website,
    this.registrationNumber,
    this.tin,
    this.description,
    required this.defaultCurrency,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['legal_name'] = Variable<String>(legalName);
    if (!nullToAbsent || tradingName != null) {
      map['trading_name'] = Variable<String>(tradingName);
    }
    map['phone'] = Variable<String>(phone);
    map['whatsapp'] = Variable<String>(whatsapp);
    map['email'] = Variable<String>(email);
    map['address'] = Variable<String>(address);
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    if (!nullToAbsent || registrationNumber != null) {
      map['registration_number'] = Variable<String>(registrationNumber);
    }
    if (!nullToAbsent || tin != null) {
      map['tin'] = Variable<String>(tin);
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BusinessesCompanion toCompanion(bool nullToAbsent) {
    return BusinessesCompanion(
      id: Value(id),
      legalName: Value(legalName),
      tradingName: tradingName == null && nullToAbsent
          ? const Value.absent()
          : Value(tradingName),
      phone: Value(phone),
      whatsapp: Value(whatsapp),
      email: Value(email),
      address: Value(address),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      registrationNumber: registrationNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(registrationNumber),
      tin: tin == null && nullToAbsent ? const Value.absent() : Value(tin),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      defaultCurrency: Value(defaultCurrency),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BusinessRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BusinessRow(
      id: serializer.fromJson<String>(json['id']),
      legalName: serializer.fromJson<String>(json['legalName']),
      tradingName: serializer.fromJson<String?>(json['tradingName']),
      phone: serializer.fromJson<String>(json['phone']),
      whatsapp: serializer.fromJson<String>(json['whatsapp']),
      email: serializer.fromJson<String>(json['email']),
      address: serializer.fromJson<String>(json['address']),
      website: serializer.fromJson<String?>(json['website']),
      registrationNumber: serializer.fromJson<String?>(
        json['registrationNumber'],
      ),
      tin: serializer.fromJson<String?>(json['tin']),
      description: serializer.fromJson<String?>(json['description']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'legalName': serializer.toJson<String>(legalName),
      'tradingName': serializer.toJson<String?>(tradingName),
      'phone': serializer.toJson<String>(phone),
      'whatsapp': serializer.toJson<String>(whatsapp),
      'email': serializer.toJson<String>(email),
      'address': serializer.toJson<String>(address),
      'website': serializer.toJson<String?>(website),
      'registrationNumber': serializer.toJson<String?>(registrationNumber),
      'tin': serializer.toJson<String?>(tin),
      'description': serializer.toJson<String?>(description),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BusinessRow copyWith({
    String? id,
    String? legalName,
    Value<String?> tradingName = const Value.absent(),
    String? phone,
    String? whatsapp,
    String? email,
    String? address,
    Value<String?> website = const Value.absent(),
    Value<String?> registrationNumber = const Value.absent(),
    Value<String?> tin = const Value.absent(),
    Value<String?> description = const Value.absent(),
    String? defaultCurrency,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BusinessRow(
    id: id ?? this.id,
    legalName: legalName ?? this.legalName,
    tradingName: tradingName.present ? tradingName.value : this.tradingName,
    phone: phone ?? this.phone,
    whatsapp: whatsapp ?? this.whatsapp,
    email: email ?? this.email,
    address: address ?? this.address,
    website: website.present ? website.value : this.website,
    registrationNumber: registrationNumber.present
        ? registrationNumber.value
        : this.registrationNumber,
    tin: tin.present ? tin.value : this.tin,
    description: description.present ? description.value : this.description,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BusinessRow copyWithCompanion(BusinessesCompanion data) {
    return BusinessRow(
      id: data.id.present ? data.id.value : this.id,
      legalName: data.legalName.present ? data.legalName.value : this.legalName,
      tradingName: data.tradingName.present
          ? data.tradingName.value
          : this.tradingName,
      phone: data.phone.present ? data.phone.value : this.phone,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      website: data.website.present ? data.website.value : this.website,
      registrationNumber: data.registrationNumber.present
          ? data.registrationNumber.value
          : this.registrationNumber,
      tin: data.tin.present ? data.tin.value : this.tin,
      description: data.description.present
          ? data.description.value
          : this.description,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BusinessRow(')
          ..write('id: $id, ')
          ..write('legalName: $legalName, ')
          ..write('tradingName: $tradingName, ')
          ..write('phone: $phone, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('tin: $tin, ')
          ..write('description: $description, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    legalName,
    tradingName,
    phone,
    whatsapp,
    email,
    address,
    website,
    registrationNumber,
    tin,
    description,
    defaultCurrency,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BusinessRow &&
          other.id == this.id &&
          other.legalName == this.legalName &&
          other.tradingName == this.tradingName &&
          other.phone == this.phone &&
          other.whatsapp == this.whatsapp &&
          other.email == this.email &&
          other.address == this.address &&
          other.website == this.website &&
          other.registrationNumber == this.registrationNumber &&
          other.tin == this.tin &&
          other.description == this.description &&
          other.defaultCurrency == this.defaultCurrency &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BusinessesCompanion extends UpdateCompanion<BusinessRow> {
  final Value<String> id;
  final Value<String> legalName;
  final Value<String?> tradingName;
  final Value<String> phone;
  final Value<String> whatsapp;
  final Value<String> email;
  final Value<String> address;
  final Value<String?> website;
  final Value<String?> registrationNumber;
  final Value<String?> tin;
  final Value<String?> description;
  final Value<String> defaultCurrency;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BusinessesCompanion({
    this.id = const Value.absent(),
    this.legalName = const Value.absent(),
    this.tradingName = const Value.absent(),
    this.phone = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.website = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.tin = const Value.absent(),
    this.description = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BusinessesCompanion.insert({
    required String id,
    required String legalName,
    this.tradingName = const Value.absent(),
    required String phone,
    required String whatsapp,
    required String email,
    required String address,
    this.website = const Value.absent(),
    this.registrationNumber = const Value.absent(),
    this.tin = const Value.absent(),
    this.description = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       legalName = Value(legalName),
       phone = Value(phone),
       whatsapp = Value(whatsapp),
       email = Value(email),
       address = Value(address),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BusinessRow> custom({
    Expression<String>? id,
    Expression<String>? legalName,
    Expression<String>? tradingName,
    Expression<String>? phone,
    Expression<String>? whatsapp,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? website,
    Expression<String>? registrationNumber,
    Expression<String>? tin,
    Expression<String>? description,
    Expression<String>? defaultCurrency,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (legalName != null) 'legal_name': legalName,
      if (tradingName != null) 'trading_name': tradingName,
      if (phone != null) 'phone': phone,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (website != null) 'website': website,
      if (registrationNumber != null) 'registration_number': registrationNumber,
      if (tin != null) 'tin': tin,
      if (description != null) 'description': description,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BusinessesCompanion copyWith({
    Value<String>? id,
    Value<String>? legalName,
    Value<String?>? tradingName,
    Value<String>? phone,
    Value<String>? whatsapp,
    Value<String>? email,
    Value<String>? address,
    Value<String?>? website,
    Value<String?>? registrationNumber,
    Value<String?>? tin,
    Value<String?>? description,
    Value<String>? defaultCurrency,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BusinessesCompanion(
      id: id ?? this.id,
      legalName: legalName ?? this.legalName,
      tradingName: tradingName ?? this.tradingName,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      address: address ?? this.address,
      website: website ?? this.website,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      tin: tin ?? this.tin,
      description: description ?? this.description,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (legalName.present) {
      map['legal_name'] = Variable<String>(legalName.value);
    }
    if (tradingName.present) {
      map['trading_name'] = Variable<String>(tradingName.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (whatsapp.present) {
      map['whatsapp'] = Variable<String>(whatsapp.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (registrationNumber.present) {
      map['registration_number'] = Variable<String>(registrationNumber.value);
    }
    if (tin.present) {
      map['tin'] = Variable<String>(tin.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BusinessesCompanion(')
          ..write('id: $id, ')
          ..write('legalName: $legalName, ')
          ..write('tradingName: $tradingName, ')
          ..write('phone: $phone, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('website: $website, ')
          ..write('registrationNumber: $registrationNumber, ')
          ..write('tin: $tin, ')
          ..write('description: $description, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrandProfilesTable extends BrandProfiles
    with TableInfo<$BrandProfilesTable, BrandProfileRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrandProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerTypeMeta = const VerificationMeta(
    'ownerType',
  );
  @override
  late final GeneratedColumn<String> ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoBytesMeta = const VerificationMeta(
    'logoBytes',
  );
  @override
  late final GeneratedColumn<Uint8List> logoBytes = GeneratedColumn<Uint8List>(
    'logo_bytes',
    aliasedName,
    true,
    type: DriftSqlType.blob,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _signatureBytesMeta = const VerificationMeta(
    'signatureBytes',
  );
  @override
  late final GeneratedColumn<Uint8List> signatureBytes =
      GeneratedColumn<Uint8List>(
        'signature_bytes',
        aliasedName,
        true,
        type: DriftSqlType.blob,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _primaryColorMeta = const VerificationMeta(
    'primaryColor',
  );
  @override
  late final GeneratedColumn<String> primaryColor = GeneratedColumn<String>(
    'primary_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#1B2A4A'),
  );
  static const VerificationMeta _secondaryColorMeta = const VerificationMeta(
    'secondaryColor',
  );
  @override
  late final GeneratedColumn<String> secondaryColor = GeneratedColumn<String>(
    'secondary_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#243B67'),
  );
  static const VerificationMeta _accentColorMeta = const VerificationMeta(
    'accentColor',
  );
  @override
  late final GeneratedColumn<String> accentColor = GeneratedColumn<String>(
    'accent_color',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('#0E8F62'),
  );
  static const VerificationMeta _taglineMeta = const VerificationMeta(
    'tagline',
  );
  @override
  late final GeneratedColumn<String> tagline = GeneratedColumn<String>(
    'tagline',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _footerMeta = const VerificationMeta('footer');
  @override
  late final GeneratedColumn<String> footer = GeneratedColumn<String>(
    'footer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateMeta = const VerificationMeta(
    'template',
  );
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
    'template',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('corporate'),
  );
  static const VerificationMeta _tradingNameMeta = const VerificationMeta(
    'tradingName',
  );
  @override
  late final GeneratedColumn<String> tradingName = GeneratedColumn<String>(
    'trading_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactPhoneMeta = const VerificationMeta(
    'contactPhone',
  );
  @override
  late final GeneratedColumn<String> contactPhone = GeneratedColumn<String>(
    'contact_phone',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactWhatsappMeta = const VerificationMeta(
    'contactWhatsapp',
  );
  @override
  late final GeneratedColumn<String> contactWhatsapp = GeneratedColumn<String>(
    'contact_whatsapp',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactEmailMeta = const VerificationMeta(
    'contactEmail',
  );
  @override
  late final GeneratedColumn<String> contactEmail = GeneratedColumn<String>(
    'contact_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _contactAddressMeta = const VerificationMeta(
    'contactAddress',
  );
  @override
  late final GeneratedColumn<String> contactAddress = GeneratedColumn<String>(
    'contact_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerType,
    ownerId,
    logoBytes,
    signatureBytes,
    primaryColor,
    secondaryColor,
    accentColor,
    tagline,
    footer,
    template,
    tradingName,
    contactPhone,
    contactWhatsapp,
    contactEmail,
    contactAddress,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brand_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrandProfileRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_type')) {
      context.handle(
        _ownerTypeMeta,
        ownerType.isAcceptableOrUnknown(data['owner_type']!, _ownerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerTypeMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('logo_bytes')) {
      context.handle(
        _logoBytesMeta,
        logoBytes.isAcceptableOrUnknown(data['logo_bytes']!, _logoBytesMeta),
      );
    }
    if (data.containsKey('signature_bytes')) {
      context.handle(
        _signatureBytesMeta,
        signatureBytes.isAcceptableOrUnknown(
          data['signature_bytes']!,
          _signatureBytesMeta,
        ),
      );
    }
    if (data.containsKey('primary_color')) {
      context.handle(
        _primaryColorMeta,
        primaryColor.isAcceptableOrUnknown(
          data['primary_color']!,
          _primaryColorMeta,
        ),
      );
    }
    if (data.containsKey('secondary_color')) {
      context.handle(
        _secondaryColorMeta,
        secondaryColor.isAcceptableOrUnknown(
          data['secondary_color']!,
          _secondaryColorMeta,
        ),
      );
    }
    if (data.containsKey('accent_color')) {
      context.handle(
        _accentColorMeta,
        accentColor.isAcceptableOrUnknown(
          data['accent_color']!,
          _accentColorMeta,
        ),
      );
    }
    if (data.containsKey('tagline')) {
      context.handle(
        _taglineMeta,
        tagline.isAcceptableOrUnknown(data['tagline']!, _taglineMeta),
      );
    }
    if (data.containsKey('footer')) {
      context.handle(
        _footerMeta,
        footer.isAcceptableOrUnknown(data['footer']!, _footerMeta),
      );
    }
    if (data.containsKey('template')) {
      context.handle(
        _templateMeta,
        template.isAcceptableOrUnknown(data['template']!, _templateMeta),
      );
    }
    if (data.containsKey('trading_name')) {
      context.handle(
        _tradingNameMeta,
        tradingName.isAcceptableOrUnknown(
          data['trading_name']!,
          _tradingNameMeta,
        ),
      );
    }
    if (data.containsKey('contact_phone')) {
      context.handle(
        _contactPhoneMeta,
        contactPhone.isAcceptableOrUnknown(
          data['contact_phone']!,
          _contactPhoneMeta,
        ),
      );
    }
    if (data.containsKey('contact_whatsapp')) {
      context.handle(
        _contactWhatsappMeta,
        contactWhatsapp.isAcceptableOrUnknown(
          data['contact_whatsapp']!,
          _contactWhatsappMeta,
        ),
      );
    }
    if (data.containsKey('contact_email')) {
      context.handle(
        _contactEmailMeta,
        contactEmail.isAcceptableOrUnknown(
          data['contact_email']!,
          _contactEmailMeta,
        ),
      );
    }
    if (data.containsKey('contact_address')) {
      context.handle(
        _contactAddressMeta,
        contactAddress.isAcceptableOrUnknown(
          data['contact_address']!,
          _contactAddressMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {ownerType, ownerId},
  ];
  @override
  BrandProfileRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrandProfileRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_type'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      logoBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}logo_bytes'],
      ),
      signatureBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}signature_bytes'],
      ),
      primaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}primary_color'],
      )!,
      secondaryColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}secondary_color'],
      )!,
      accentColor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accent_color'],
      )!,
      tagline: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tagline'],
      ),
      footer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}footer'],
      ),
      template: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template'],
      )!,
      tradingName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}trading_name'],
      ),
      contactPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_phone'],
      ),
      contactWhatsapp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_whatsapp'],
      ),
      contactEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_email'],
      ),
      contactAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_address'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BrandProfilesTable createAlias(String alias) {
    return $BrandProfilesTable(attachedDatabase, alias);
  }
}

class BrandProfileRow extends DataClass implements Insertable<BrandProfileRow> {
  final String id;
  final String ownerType;
  final String ownerId;
  final Uint8List? logoBytes;
  final Uint8List? signatureBytes;
  final String primaryColor;
  final String secondaryColor;
  final String accentColor;
  final String? tagline;
  final String? footer;
  final String template;
  final String? tradingName;
  final String? contactPhone;
  final String? contactWhatsapp;
  final String? contactEmail;
  final String? contactAddress;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BrandProfileRow({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    this.logoBytes,
    this.signatureBytes,
    required this.primaryColor,
    required this.secondaryColor,
    required this.accentColor,
    this.tagline,
    this.footer,
    required this.template,
    this.tradingName,
    this.contactPhone,
    this.contactWhatsapp,
    this.contactEmail,
    this.contactAddress,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_type'] = Variable<String>(ownerType);
    map['owner_id'] = Variable<String>(ownerId);
    if (!nullToAbsent || logoBytes != null) {
      map['logo_bytes'] = Variable<Uint8List>(logoBytes);
    }
    if (!nullToAbsent || signatureBytes != null) {
      map['signature_bytes'] = Variable<Uint8List>(signatureBytes);
    }
    map['primary_color'] = Variable<String>(primaryColor);
    map['secondary_color'] = Variable<String>(secondaryColor);
    map['accent_color'] = Variable<String>(accentColor);
    if (!nullToAbsent || tagline != null) {
      map['tagline'] = Variable<String>(tagline);
    }
    if (!nullToAbsent || footer != null) {
      map['footer'] = Variable<String>(footer);
    }
    map['template'] = Variable<String>(template);
    if (!nullToAbsent || tradingName != null) {
      map['trading_name'] = Variable<String>(tradingName);
    }
    if (!nullToAbsent || contactPhone != null) {
      map['contact_phone'] = Variable<String>(contactPhone);
    }
    if (!nullToAbsent || contactWhatsapp != null) {
      map['contact_whatsapp'] = Variable<String>(contactWhatsapp);
    }
    if (!nullToAbsent || contactEmail != null) {
      map['contact_email'] = Variable<String>(contactEmail);
    }
    if (!nullToAbsent || contactAddress != null) {
      map['contact_address'] = Variable<String>(contactAddress);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BrandProfilesCompanion toCompanion(bool nullToAbsent) {
    return BrandProfilesCompanion(
      id: Value(id),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      logoBytes: logoBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(logoBytes),
      signatureBytes: signatureBytes == null && nullToAbsent
          ? const Value.absent()
          : Value(signatureBytes),
      primaryColor: Value(primaryColor),
      secondaryColor: Value(secondaryColor),
      accentColor: Value(accentColor),
      tagline: tagline == null && nullToAbsent
          ? const Value.absent()
          : Value(tagline),
      footer: footer == null && nullToAbsent
          ? const Value.absent()
          : Value(footer),
      template: Value(template),
      tradingName: tradingName == null && nullToAbsent
          ? const Value.absent()
          : Value(tradingName),
      contactPhone: contactPhone == null && nullToAbsent
          ? const Value.absent()
          : Value(contactPhone),
      contactWhatsapp: contactWhatsapp == null && nullToAbsent
          ? const Value.absent()
          : Value(contactWhatsapp),
      contactEmail: contactEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(contactEmail),
      contactAddress: contactAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(contactAddress),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BrandProfileRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrandProfileRow(
      id: serializer.fromJson<String>(json['id']),
      ownerType: serializer.fromJson<String>(json['ownerType']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      logoBytes: serializer.fromJson<Uint8List?>(json['logoBytes']),
      signatureBytes: serializer.fromJson<Uint8List?>(json['signatureBytes']),
      primaryColor: serializer.fromJson<String>(json['primaryColor']),
      secondaryColor: serializer.fromJson<String>(json['secondaryColor']),
      accentColor: serializer.fromJson<String>(json['accentColor']),
      tagline: serializer.fromJson<String?>(json['tagline']),
      footer: serializer.fromJson<String?>(json['footer']),
      template: serializer.fromJson<String>(json['template']),
      tradingName: serializer.fromJson<String?>(json['tradingName']),
      contactPhone: serializer.fromJson<String?>(json['contactPhone']),
      contactWhatsapp: serializer.fromJson<String?>(json['contactWhatsapp']),
      contactEmail: serializer.fromJson<String?>(json['contactEmail']),
      contactAddress: serializer.fromJson<String?>(json['contactAddress']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerType': serializer.toJson<String>(ownerType),
      'ownerId': serializer.toJson<String>(ownerId),
      'logoBytes': serializer.toJson<Uint8List?>(logoBytes),
      'signatureBytes': serializer.toJson<Uint8List?>(signatureBytes),
      'primaryColor': serializer.toJson<String>(primaryColor),
      'secondaryColor': serializer.toJson<String>(secondaryColor),
      'accentColor': serializer.toJson<String>(accentColor),
      'tagline': serializer.toJson<String?>(tagline),
      'footer': serializer.toJson<String?>(footer),
      'template': serializer.toJson<String>(template),
      'tradingName': serializer.toJson<String?>(tradingName),
      'contactPhone': serializer.toJson<String?>(contactPhone),
      'contactWhatsapp': serializer.toJson<String?>(contactWhatsapp),
      'contactEmail': serializer.toJson<String?>(contactEmail),
      'contactAddress': serializer.toJson<String?>(contactAddress),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BrandProfileRow copyWith({
    String? id,
    String? ownerType,
    String? ownerId,
    Value<Uint8List?> logoBytes = const Value.absent(),
    Value<Uint8List?> signatureBytes = const Value.absent(),
    String? primaryColor,
    String? secondaryColor,
    String? accentColor,
    Value<String?> tagline = const Value.absent(),
    Value<String?> footer = const Value.absent(),
    String? template,
    Value<String?> tradingName = const Value.absent(),
    Value<String?> contactPhone = const Value.absent(),
    Value<String?> contactWhatsapp = const Value.absent(),
    Value<String?> contactEmail = const Value.absent(),
    Value<String?> contactAddress = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BrandProfileRow(
    id: id ?? this.id,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    logoBytes: logoBytes.present ? logoBytes.value : this.logoBytes,
    signatureBytes: signatureBytes.present
        ? signatureBytes.value
        : this.signatureBytes,
    primaryColor: primaryColor ?? this.primaryColor,
    secondaryColor: secondaryColor ?? this.secondaryColor,
    accentColor: accentColor ?? this.accentColor,
    tagline: tagline.present ? tagline.value : this.tagline,
    footer: footer.present ? footer.value : this.footer,
    template: template ?? this.template,
    tradingName: tradingName.present ? tradingName.value : this.tradingName,
    contactPhone: contactPhone.present ? contactPhone.value : this.contactPhone,
    contactWhatsapp: contactWhatsapp.present
        ? contactWhatsapp.value
        : this.contactWhatsapp,
    contactEmail: contactEmail.present ? contactEmail.value : this.contactEmail,
    contactAddress: contactAddress.present
        ? contactAddress.value
        : this.contactAddress,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BrandProfileRow copyWithCompanion(BrandProfilesCompanion data) {
    return BrandProfileRow(
      id: data.id.present ? data.id.value : this.id,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      logoBytes: data.logoBytes.present ? data.logoBytes.value : this.logoBytes,
      signatureBytes: data.signatureBytes.present
          ? data.signatureBytes.value
          : this.signatureBytes,
      primaryColor: data.primaryColor.present
          ? data.primaryColor.value
          : this.primaryColor,
      secondaryColor: data.secondaryColor.present
          ? data.secondaryColor.value
          : this.secondaryColor,
      accentColor: data.accentColor.present
          ? data.accentColor.value
          : this.accentColor,
      tagline: data.tagline.present ? data.tagline.value : this.tagline,
      footer: data.footer.present ? data.footer.value : this.footer,
      template: data.template.present ? data.template.value : this.template,
      tradingName: data.tradingName.present
          ? data.tradingName.value
          : this.tradingName,
      contactPhone: data.contactPhone.present
          ? data.contactPhone.value
          : this.contactPhone,
      contactWhatsapp: data.contactWhatsapp.present
          ? data.contactWhatsapp.value
          : this.contactWhatsapp,
      contactEmail: data.contactEmail.present
          ? data.contactEmail.value
          : this.contactEmail,
      contactAddress: data.contactAddress.present
          ? data.contactAddress.value
          : this.contactAddress,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrandProfileRow(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('logoBytes: $logoBytes, ')
          ..write('signatureBytes: $signatureBytes, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('accentColor: $accentColor, ')
          ..write('tagline: $tagline, ')
          ..write('footer: $footer, ')
          ..write('template: $template, ')
          ..write('tradingName: $tradingName, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('contactWhatsapp: $contactWhatsapp, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('contactAddress: $contactAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ownerType,
    ownerId,
    $driftBlobEquality.hash(logoBytes),
    $driftBlobEquality.hash(signatureBytes),
    primaryColor,
    secondaryColor,
    accentColor,
    tagline,
    footer,
    template,
    tradingName,
    contactPhone,
    contactWhatsapp,
    contactEmail,
    contactAddress,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrandProfileRow &&
          other.id == this.id &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          $driftBlobEquality.equals(other.logoBytes, this.logoBytes) &&
          $driftBlobEquality.equals(
            other.signatureBytes,
            this.signatureBytes,
          ) &&
          other.primaryColor == this.primaryColor &&
          other.secondaryColor == this.secondaryColor &&
          other.accentColor == this.accentColor &&
          other.tagline == this.tagline &&
          other.footer == this.footer &&
          other.template == this.template &&
          other.tradingName == this.tradingName &&
          other.contactPhone == this.contactPhone &&
          other.contactWhatsapp == this.contactWhatsapp &&
          other.contactEmail == this.contactEmail &&
          other.contactAddress == this.contactAddress &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BrandProfilesCompanion extends UpdateCompanion<BrandProfileRow> {
  final Value<String> id;
  final Value<String> ownerType;
  final Value<String> ownerId;
  final Value<Uint8List?> logoBytes;
  final Value<Uint8List?> signatureBytes;
  final Value<String> primaryColor;
  final Value<String> secondaryColor;
  final Value<String> accentColor;
  final Value<String?> tagline;
  final Value<String?> footer;
  final Value<String> template;
  final Value<String?> tradingName;
  final Value<String?> contactPhone;
  final Value<String?> contactWhatsapp;
  final Value<String?> contactEmail;
  final Value<String?> contactAddress;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BrandProfilesCompanion({
    this.id = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.logoBytes = const Value.absent(),
    this.signatureBytes = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.secondaryColor = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.tagline = const Value.absent(),
    this.footer = const Value.absent(),
    this.template = const Value.absent(),
    this.tradingName = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.contactWhatsapp = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.contactAddress = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrandProfilesCompanion.insert({
    required String id,
    required String ownerType,
    required String ownerId,
    this.logoBytes = const Value.absent(),
    this.signatureBytes = const Value.absent(),
    this.primaryColor = const Value.absent(),
    this.secondaryColor = const Value.absent(),
    this.accentColor = const Value.absent(),
    this.tagline = const Value.absent(),
    this.footer = const Value.absent(),
    this.template = const Value.absent(),
    this.tradingName = const Value.absent(),
    this.contactPhone = const Value.absent(),
    this.contactWhatsapp = const Value.absent(),
    this.contactEmail = const Value.absent(),
    this.contactAddress = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BrandProfileRow> custom({
    Expression<String>? id,
    Expression<String>? ownerType,
    Expression<String>? ownerId,
    Expression<Uint8List>? logoBytes,
    Expression<Uint8List>? signatureBytes,
    Expression<String>? primaryColor,
    Expression<String>? secondaryColor,
    Expression<String>? accentColor,
    Expression<String>? tagline,
    Expression<String>? footer,
    Expression<String>? template,
    Expression<String>? tradingName,
    Expression<String>? contactPhone,
    Expression<String>? contactWhatsapp,
    Expression<String>? contactEmail,
    Expression<String>? contactAddress,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (logoBytes != null) 'logo_bytes': logoBytes,
      if (signatureBytes != null) 'signature_bytes': signatureBytes,
      if (primaryColor != null) 'primary_color': primaryColor,
      if (secondaryColor != null) 'secondary_color': secondaryColor,
      if (accentColor != null) 'accent_color': accentColor,
      if (tagline != null) 'tagline': tagline,
      if (footer != null) 'footer': footer,
      if (template != null) 'template': template,
      if (tradingName != null) 'trading_name': tradingName,
      if (contactPhone != null) 'contact_phone': contactPhone,
      if (contactWhatsapp != null) 'contact_whatsapp': contactWhatsapp,
      if (contactEmail != null) 'contact_email': contactEmail,
      if (contactAddress != null) 'contact_address': contactAddress,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrandProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerType,
    Value<String>? ownerId,
    Value<Uint8List?>? logoBytes,
    Value<Uint8List?>? signatureBytes,
    Value<String>? primaryColor,
    Value<String>? secondaryColor,
    Value<String>? accentColor,
    Value<String?>? tagline,
    Value<String?>? footer,
    Value<String>? template,
    Value<String?>? tradingName,
    Value<String?>? contactPhone,
    Value<String?>? contactWhatsapp,
    Value<String?>? contactEmail,
    Value<String?>? contactAddress,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BrandProfilesCompanion(
      id: id ?? this.id,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      logoBytes: logoBytes ?? this.logoBytes,
      signatureBytes: signatureBytes ?? this.signatureBytes,
      primaryColor: primaryColor ?? this.primaryColor,
      secondaryColor: secondaryColor ?? this.secondaryColor,
      accentColor: accentColor ?? this.accentColor,
      tagline: tagline ?? this.tagline,
      footer: footer ?? this.footer,
      template: template ?? this.template,
      tradingName: tradingName ?? this.tradingName,
      contactPhone: contactPhone ?? this.contactPhone,
      contactWhatsapp: contactWhatsapp ?? this.contactWhatsapp,
      contactEmail: contactEmail ?? this.contactEmail,
      contactAddress: contactAddress ?? this.contactAddress,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(ownerType.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (logoBytes.present) {
      map['logo_bytes'] = Variable<Uint8List>(logoBytes.value);
    }
    if (signatureBytes.present) {
      map['signature_bytes'] = Variable<Uint8List>(signatureBytes.value);
    }
    if (primaryColor.present) {
      map['primary_color'] = Variable<String>(primaryColor.value);
    }
    if (secondaryColor.present) {
      map['secondary_color'] = Variable<String>(secondaryColor.value);
    }
    if (accentColor.present) {
      map['accent_color'] = Variable<String>(accentColor.value);
    }
    if (tagline.present) {
      map['tagline'] = Variable<String>(tagline.value);
    }
    if (footer.present) {
      map['footer'] = Variable<String>(footer.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (tradingName.present) {
      map['trading_name'] = Variable<String>(tradingName.value);
    }
    if (contactPhone.present) {
      map['contact_phone'] = Variable<String>(contactPhone.value);
    }
    if (contactWhatsapp.present) {
      map['contact_whatsapp'] = Variable<String>(contactWhatsapp.value);
    }
    if (contactEmail.present) {
      map['contact_email'] = Variable<String>(contactEmail.value);
    }
    if (contactAddress.present) {
      map['contact_address'] = Variable<String>(contactAddress.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrandProfilesCompanion(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('logoBytes: $logoBytes, ')
          ..write('signatureBytes: $signatureBytes, ')
          ..write('primaryColor: $primaryColor, ')
          ..write('secondaryColor: $secondaryColor, ')
          ..write('accentColor: $accentColor, ')
          ..write('tagline: $tagline, ')
          ..write('footer: $footer, ')
          ..write('template: $template, ')
          ..write('tradingName: $tradingName, ')
          ..write('contactPhone: $contactPhone, ')
          ..write('contactWhatsapp: $contactWhatsapp, ')
          ..write('contactEmail: $contactEmail, ')
          ..write('contactAddress: $contactAddress, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BankAccountsTable extends BankAccounts
    with TableInfo<$BankAccountsTable, BankAccountRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BankAccountsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES businesses (id)',
    ),
  );
  static const VerificationMeta _bankNameMeta = const VerificationMeta(
    'bankName',
  );
  @override
  late final GeneratedColumn<String> bankName = GeneratedColumn<String>(
    'bank_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountNameMeta = const VerificationMeta(
    'accountName',
  );
  @override
  late final GeneratedColumn<String> accountName = GeneratedColumn<String>(
    'account_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _accountNumberMeta = const VerificationMeta(
    'accountNumber',
  );
  @override
  late final GeneratedColumn<String> accountNumber = GeneratedColumn<String>(
    'account_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessId,
    bankName,
    accountName,
    accountNumber,
    label,
    isDefault,
    isActive,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'bank_accounts';
  @override
  VerificationContext validateIntegrity(
    Insertable<BankAccountRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('bank_name')) {
      context.handle(
        _bankNameMeta,
        bankName.isAcceptableOrUnknown(data['bank_name']!, _bankNameMeta),
      );
    } else if (isInserting) {
      context.missing(_bankNameMeta);
    }
    if (data.containsKey('account_name')) {
      context.handle(
        _accountNameMeta,
        accountName.isAcceptableOrUnknown(
          data['account_name']!,
          _accountNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountNameMeta);
    }
    if (data.containsKey('account_number')) {
      context.handle(
        _accountNumberMeta,
        accountNumber.isAcceptableOrUnknown(
          data['account_number']!,
          _accountNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_accountNumberMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BankAccountRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BankAccountRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      bankName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_name'],
      )!,
      accountName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_name'],
      )!,
      accountNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_number'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $BankAccountsTable createAlias(String alias) {
    return $BankAccountsTable(attachedDatabase, alias);
  }
}

class BankAccountRow extends DataClass implements Insertable<BankAccountRow> {
  final String id;
  final String businessId;
  final String bankName;
  final String accountName;
  final String accountNumber;
  final String? label;
  final bool isDefault;
  final bool isActive;
  final DateTime createdAt;
  const BankAccountRow({
    required this.id,
    required this.businessId,
    required this.bankName,
    required this.accountName,
    required this.accountNumber,
    this.label,
    required this.isDefault,
    required this.isActive,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_id'] = Variable<String>(businessId);
    map['bank_name'] = Variable<String>(bankName);
    map['account_name'] = Variable<String>(accountName);
    map['account_number'] = Variable<String>(accountNumber);
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  BankAccountsCompanion toCompanion(bool nullToAbsent) {
    return BankAccountsCompanion(
      id: Value(id),
      businessId: Value(businessId),
      bankName: Value(bankName),
      accountName: Value(accountName),
      accountNumber: Value(accountNumber),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      isDefault: Value(isDefault),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
    );
  }

  factory BankAccountRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BankAccountRow(
      id: serializer.fromJson<String>(json['id']),
      businessId: serializer.fromJson<String>(json['businessId']),
      bankName: serializer.fromJson<String>(json['bankName']),
      accountName: serializer.fromJson<String>(json['accountName']),
      accountNumber: serializer.fromJson<String>(json['accountNumber']),
      label: serializer.fromJson<String?>(json['label']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessId': serializer.toJson<String>(businessId),
      'bankName': serializer.toJson<String>(bankName),
      'accountName': serializer.toJson<String>(accountName),
      'accountNumber': serializer.toJson<String>(accountNumber),
      'label': serializer.toJson<String?>(label),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  BankAccountRow copyWith({
    String? id,
    String? businessId,
    String? bankName,
    String? accountName,
    String? accountNumber,
    Value<String?> label = const Value.absent(),
    bool? isDefault,
    bool? isActive,
    DateTime? createdAt,
  }) => BankAccountRow(
    id: id ?? this.id,
    businessId: businessId ?? this.businessId,
    bankName: bankName ?? this.bankName,
    accountName: accountName ?? this.accountName,
    accountNumber: accountNumber ?? this.accountNumber,
    label: label.present ? label.value : this.label,
    isDefault: isDefault ?? this.isDefault,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
  );
  BankAccountRow copyWithCompanion(BankAccountsCompanion data) {
    return BankAccountRow(
      id: data.id.present ? data.id.value : this.id,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      bankName: data.bankName.present ? data.bankName.value : this.bankName,
      accountName: data.accountName.present
          ? data.accountName.value
          : this.accountName,
      accountNumber: data.accountNumber.present
          ? data.accountNumber.value
          : this.accountNumber,
      label: data.label.present ? data.label.value : this.label,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountRow(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('bankName: $bankName, ')
          ..write('accountName: $accountName, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('label: $label, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    businessId,
    bankName,
    accountName,
    accountNumber,
    label,
    isDefault,
    isActive,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BankAccountRow &&
          other.id == this.id &&
          other.businessId == this.businessId &&
          other.bankName == this.bankName &&
          other.accountName == this.accountName &&
          other.accountNumber == this.accountNumber &&
          other.label == this.label &&
          other.isDefault == this.isDefault &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt);
}

class BankAccountsCompanion extends UpdateCompanion<BankAccountRow> {
  final Value<String> id;
  final Value<String> businessId;
  final Value<String> bankName;
  final Value<String> accountName;
  final Value<String> accountNumber;
  final Value<String?> label;
  final Value<bool> isDefault;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const BankAccountsCompanion({
    this.id = const Value.absent(),
    this.businessId = const Value.absent(),
    this.bankName = const Value.absent(),
    this.accountName = const Value.absent(),
    this.accountNumber = const Value.absent(),
    this.label = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BankAccountsCompanion.insert({
    required String id,
    required String businessId,
    required String bankName,
    required String accountName,
    required String accountNumber,
    this.label = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       businessId = Value(businessId),
       bankName = Value(bankName),
       accountName = Value(accountName),
       accountNumber = Value(accountNumber),
       createdAt = Value(createdAt);
  static Insertable<BankAccountRow> custom({
    Expression<String>? id,
    Expression<String>? businessId,
    Expression<String>? bankName,
    Expression<String>? accountName,
    Expression<String>? accountNumber,
    Expression<String>? label,
    Expression<bool>? isDefault,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessId != null) 'business_id': businessId,
      if (bankName != null) 'bank_name': bankName,
      if (accountName != null) 'account_name': accountName,
      if (accountNumber != null) 'account_number': accountNumber,
      if (label != null) 'label': label,
      if (isDefault != null) 'is_default': isDefault,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BankAccountsCompanion copyWith({
    Value<String>? id,
    Value<String>? businessId,
    Value<String>? bankName,
    Value<String>? accountName,
    Value<String>? accountNumber,
    Value<String?>? label,
    Value<bool>? isDefault,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return BankAccountsCompanion(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      bankName: bankName ?? this.bankName,
      accountName: accountName ?? this.accountName,
      accountNumber: accountNumber ?? this.accountNumber,
      label: label ?? this.label,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (bankName.present) {
      map['bank_name'] = Variable<String>(bankName.value);
    }
    if (accountName.present) {
      map['account_name'] = Variable<String>(accountName.value);
    }
    if (accountNumber.present) {
      map['account_number'] = Variable<String>(accountNumber.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BankAccountsCompanion(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('bankName: $bankName, ')
          ..write('accountName: $accountName, ')
          ..write('accountNumber: $accountNumber, ')
          ..write('label: $label, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ServicesTable extends Services
    with TableInfo<$ServicesTable, ServiceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ServicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES businesses (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _defaultPriceMinorMeta = const VerificationMeta(
    'defaultPriceMinor',
  );
  @override
  late final GeneratedColumn<int> defaultPriceMinor = GeneratedColumn<int>(
    'default_price_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('item'),
  );
  static const VerificationMeta _customUnitMeta = const VerificationMeta(
    'customUnit',
  );
  @override
  late final GeneratedColumn<String> customUnit = GeneratedColumn<String>(
    'custom_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NGN'),
  );
  static const VerificationMeta _bankAccountIdMeta = const VerificationMeta(
    'bankAccountId',
  );
  @override
  late final GeneratedColumn<String> bankAccountId = GeneratedColumn<String>(
    'bank_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bank_accounts (id)',
    ),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _brandingModeMeta = const VerificationMeta(
    'brandingMode',
  );
  @override
  late final GeneratedColumn<String> brandingMode = GeneratedColumn<String>(
    'branding_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('business'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessId,
    name,
    description,
    category,
    defaultPriceMinor,
    unit,
    customUnit,
    currency,
    bankAccountId,
    isActive,
    brandingMode,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'services';
  @override
  VerificationContext validateIntegrity(
    Insertable<ServiceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    }
    if (data.containsKey('default_price_minor')) {
      context.handle(
        _defaultPriceMinorMeta,
        defaultPriceMinor.isAcceptableOrUnknown(
          data['default_price_minor']!,
          _defaultPriceMinorMeta,
        ),
      );
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('custom_unit')) {
      context.handle(
        _customUnitMeta,
        customUnit.isAcceptableOrUnknown(data['custom_unit']!, _customUnitMeta),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('bank_account_id')) {
      context.handle(
        _bankAccountIdMeta,
        bankAccountId.isAcceptableOrUnknown(
          data['bank_account_id']!,
          _bankAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('branding_mode')) {
      context.handle(
        _brandingModeMeta,
        brandingMode.isAcceptableOrUnknown(
          data['branding_mode']!,
          _brandingModeMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ServiceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ServiceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      defaultPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_price_minor'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      customUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_unit'],
      ),
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      bankAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_id'],
      ),
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      brandingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branding_mode'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ServicesTable createAlias(String alias) {
    return $ServicesTable(attachedDatabase, alias);
  }
}

class ServiceRow extends DataClass implements Insertable<ServiceRow> {
  final String id;
  final String businessId;
  final String name;
  final String description;
  final String category;
  final int defaultPriceMinor;
  final String unit;
  final String? customUnit;
  final String currency;
  final String? bankAccountId;
  final bool isActive;
  final String brandingMode;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ServiceRow({
    required this.id,
    required this.businessId,
    required this.name,
    required this.description,
    required this.category,
    required this.defaultPriceMinor,
    required this.unit,
    this.customUnit,
    required this.currency,
    this.bankAccountId,
    required this.isActive,
    required this.brandingMode,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_id'] = Variable<String>(businessId);
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['category'] = Variable<String>(category);
    map['default_price_minor'] = Variable<int>(defaultPriceMinor);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || customUnit != null) {
      map['custom_unit'] = Variable<String>(customUnit);
    }
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || bankAccountId != null) {
      map['bank_account_id'] = Variable<String>(bankAccountId);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['branding_mode'] = Variable<String>(brandingMode);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ServicesCompanion toCompanion(bool nullToAbsent) {
    return ServicesCompanion(
      id: Value(id),
      businessId: Value(businessId),
      name: Value(name),
      description: Value(description),
      category: Value(category),
      defaultPriceMinor: Value(defaultPriceMinor),
      unit: Value(unit),
      customUnit: customUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(customUnit),
      currency: Value(currency),
      bankAccountId: bankAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(bankAccountId),
      isActive: Value(isActive),
      brandingMode: Value(brandingMode),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ServiceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ServiceRow(
      id: serializer.fromJson<String>(json['id']),
      businessId: serializer.fromJson<String>(json['businessId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      category: serializer.fromJson<String>(json['category']),
      defaultPriceMinor: serializer.fromJson<int>(json['defaultPriceMinor']),
      unit: serializer.fromJson<String>(json['unit']),
      customUnit: serializer.fromJson<String?>(json['customUnit']),
      currency: serializer.fromJson<String>(json['currency']),
      bankAccountId: serializer.fromJson<String?>(json['bankAccountId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      brandingMode: serializer.fromJson<String>(json['brandingMode']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessId': serializer.toJson<String>(businessId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'category': serializer.toJson<String>(category),
      'defaultPriceMinor': serializer.toJson<int>(defaultPriceMinor),
      'unit': serializer.toJson<String>(unit),
      'customUnit': serializer.toJson<String?>(customUnit),
      'currency': serializer.toJson<String>(currency),
      'bankAccountId': serializer.toJson<String?>(bankAccountId),
      'isActive': serializer.toJson<bool>(isActive),
      'brandingMode': serializer.toJson<String>(brandingMode),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ServiceRow copyWith({
    String? id,
    String? businessId,
    String? name,
    String? description,
    String? category,
    int? defaultPriceMinor,
    String? unit,
    Value<String?> customUnit = const Value.absent(),
    String? currency,
    Value<String?> bankAccountId = const Value.absent(),
    bool? isActive,
    String? brandingMode,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ServiceRow(
    id: id ?? this.id,
    businessId: businessId ?? this.businessId,
    name: name ?? this.name,
    description: description ?? this.description,
    category: category ?? this.category,
    defaultPriceMinor: defaultPriceMinor ?? this.defaultPriceMinor,
    unit: unit ?? this.unit,
    customUnit: customUnit.present ? customUnit.value : this.customUnit,
    currency: currency ?? this.currency,
    bankAccountId: bankAccountId.present
        ? bankAccountId.value
        : this.bankAccountId,
    isActive: isActive ?? this.isActive,
    brandingMode: brandingMode ?? this.brandingMode,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ServiceRow copyWithCompanion(ServicesCompanion data) {
    return ServiceRow(
      id: data.id.present ? data.id.value : this.id,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      category: data.category.present ? data.category.value : this.category,
      defaultPriceMinor: data.defaultPriceMinor.present
          ? data.defaultPriceMinor.value
          : this.defaultPriceMinor,
      unit: data.unit.present ? data.unit.value : this.unit,
      customUnit: data.customUnit.present
          ? data.customUnit.value
          : this.customUnit,
      currency: data.currency.present ? data.currency.value : this.currency,
      bankAccountId: data.bankAccountId.present
          ? data.bankAccountId.value
          : this.bankAccountId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      brandingMode: data.brandingMode.present
          ? data.brandingMode.value
          : this.brandingMode,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ServiceRow(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('defaultPriceMinor: $defaultPriceMinor, ')
          ..write('unit: $unit, ')
          ..write('customUnit: $customUnit, ')
          ..write('currency: $currency, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('isActive: $isActive, ')
          ..write('brandingMode: $brandingMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    businessId,
    name,
    description,
    category,
    defaultPriceMinor,
    unit,
    customUnit,
    currency,
    bankAccountId,
    isActive,
    brandingMode,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ServiceRow &&
          other.id == this.id &&
          other.businessId == this.businessId &&
          other.name == this.name &&
          other.description == this.description &&
          other.category == this.category &&
          other.defaultPriceMinor == this.defaultPriceMinor &&
          other.unit == this.unit &&
          other.customUnit == this.customUnit &&
          other.currency == this.currency &&
          other.bankAccountId == this.bankAccountId &&
          other.isActive == this.isActive &&
          other.brandingMode == this.brandingMode &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ServicesCompanion extends UpdateCompanion<ServiceRow> {
  final Value<String> id;
  final Value<String> businessId;
  final Value<String> name;
  final Value<String> description;
  final Value<String> category;
  final Value<int> defaultPriceMinor;
  final Value<String> unit;
  final Value<String?> customUnit;
  final Value<String> currency;
  final Value<String?> bankAccountId;
  final Value<bool> isActive;
  final Value<String> brandingMode;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ServicesCompanion({
    this.id = const Value.absent(),
    this.businessId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultPriceMinor = const Value.absent(),
    this.unit = const Value.absent(),
    this.customUnit = const Value.absent(),
    this.currency = const Value.absent(),
    this.bankAccountId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.brandingMode = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ServicesCompanion.insert({
    required String id,
    required String businessId,
    required String name,
    this.description = const Value.absent(),
    this.category = const Value.absent(),
    this.defaultPriceMinor = const Value.absent(),
    this.unit = const Value.absent(),
    this.customUnit = const Value.absent(),
    this.currency = const Value.absent(),
    this.bankAccountId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.brandingMode = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       businessId = Value(businessId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<ServiceRow> custom({
    Expression<String>? id,
    Expression<String>? businessId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? category,
    Expression<int>? defaultPriceMinor,
    Expression<String>? unit,
    Expression<String>? customUnit,
    Expression<String>? currency,
    Expression<String>? bankAccountId,
    Expression<bool>? isActive,
    Expression<String>? brandingMode,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessId != null) 'business_id': businessId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (category != null) 'category': category,
      if (defaultPriceMinor != null) 'default_price_minor': defaultPriceMinor,
      if (unit != null) 'unit': unit,
      if (customUnit != null) 'custom_unit': customUnit,
      if (currency != null) 'currency': currency,
      if (bankAccountId != null) 'bank_account_id': bankAccountId,
      if (isActive != null) 'is_active': isActive,
      if (brandingMode != null) 'branding_mode': brandingMode,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ServicesCompanion copyWith({
    Value<String>? id,
    Value<String>? businessId,
    Value<String>? name,
    Value<String>? description,
    Value<String>? category,
    Value<int>? defaultPriceMinor,
    Value<String>? unit,
    Value<String?>? customUnit,
    Value<String>? currency,
    Value<String?>? bankAccountId,
    Value<bool>? isActive,
    Value<String>? brandingMode,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ServicesCompanion(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      defaultPriceMinor: defaultPriceMinor ?? this.defaultPriceMinor,
      unit: unit ?? this.unit,
      customUnit: customUnit ?? this.customUnit,
      currency: currency ?? this.currency,
      bankAccountId: bankAccountId ?? this.bankAccountId,
      isActive: isActive ?? this.isActive,
      brandingMode: brandingMode ?? this.brandingMode,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (defaultPriceMinor.present) {
      map['default_price_minor'] = Variable<int>(defaultPriceMinor.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (customUnit.present) {
      map['custom_unit'] = Variable<String>(customUnit.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (bankAccountId.present) {
      map['bank_account_id'] = Variable<String>(bankAccountId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (brandingMode.present) {
      map['branding_mode'] = Variable<String>(brandingMode.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ServicesCompanion(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('category: $category, ')
          ..write('defaultPriceMinor: $defaultPriceMinor, ')
          ..write('unit: $unit, ')
          ..write('customUnit: $customUnit, ')
          ..write('currency: $currency, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('isActive: $isActive, ')
          ..write('brandingMode: $brandingMode, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CustomersTable extends Customers
    with TableInfo<$CustomersTable, CustomerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES businesses (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
    'phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _whatsappMeta = const VerificationMeta(
    'whatsapp',
  );
  @override
  late final GeneratedColumn<String> whatsapp = GeneratedColumn<String>(
    'whatsapp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessId,
    name,
    phone,
    whatsapp,
    email,
    address,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<CustomerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('phone')) {
      context.handle(
        _phoneMeta,
        phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta),
      );
    }
    if (data.containsKey('whatsapp')) {
      context.handle(
        _whatsappMeta,
        whatsapp.isAcceptableOrUnknown(data['whatsapp']!, _whatsappMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CustomerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CustomerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      phone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone'],
      )!,
      whatsapp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}whatsapp'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CustomersTable createAlias(String alias) {
    return $CustomersTable(attachedDatabase, alias);
  }
}

class CustomerRow extends DataClass implements Insertable<CustomerRow> {
  final String id;
  final String businessId;
  final String name;
  final String phone;
  final String whatsapp;
  final String? email;
  final String? address;
  final String? notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CustomerRow({
    required this.id,
    required this.businessId,
    required this.name,
    required this.phone,
    required this.whatsapp,
    this.email,
    this.address,
    this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_id'] = Variable<String>(businessId);
    map['name'] = Variable<String>(name);
    map['phone'] = Variable<String>(phone);
    map['whatsapp'] = Variable<String>(whatsapp);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CustomersCompanion toCompanion(bool nullToAbsent) {
    return CustomersCompanion(
      id: Value(id),
      businessId: Value(businessId),
      name: Value(name),
      phone: Value(phone),
      whatsapp: Value(whatsapp),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CustomerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CustomerRow(
      id: serializer.fromJson<String>(json['id']),
      businessId: serializer.fromJson<String>(json['businessId']),
      name: serializer.fromJson<String>(json['name']),
      phone: serializer.fromJson<String>(json['phone']),
      whatsapp: serializer.fromJson<String>(json['whatsapp']),
      email: serializer.fromJson<String?>(json['email']),
      address: serializer.fromJson<String?>(json['address']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessId': serializer.toJson<String>(businessId),
      'name': serializer.toJson<String>(name),
      'phone': serializer.toJson<String>(phone),
      'whatsapp': serializer.toJson<String>(whatsapp),
      'email': serializer.toJson<String?>(email),
      'address': serializer.toJson<String?>(address),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CustomerRow copyWith({
    String? id,
    String? businessId,
    String? name,
    String? phone,
    String? whatsapp,
    Value<String?> email = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CustomerRow(
    id: id ?? this.id,
    businessId: businessId ?? this.businessId,
    name: name ?? this.name,
    phone: phone ?? this.phone,
    whatsapp: whatsapp ?? this.whatsapp,
    email: email.present ? email.value : this.email,
    address: address.present ? address.value : this.address,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CustomerRow copyWithCompanion(CustomersCompanion data) {
    return CustomerRow(
      id: data.id.present ? data.id.value : this.id,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      name: data.name.present ? data.name.value : this.name,
      phone: data.phone.present ? data.phone.value : this.phone,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      email: data.email.present ? data.email.value : this.email,
      address: data.address.present ? data.address.value : this.address,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CustomerRow(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    businessId,
    name,
    phone,
    whatsapp,
    email,
    address,
    notes,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CustomerRow &&
          other.id == this.id &&
          other.businessId == this.businessId &&
          other.name == this.name &&
          other.phone == this.phone &&
          other.whatsapp == this.whatsapp &&
          other.email == this.email &&
          other.address == this.address &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CustomersCompanion extends UpdateCompanion<CustomerRow> {
  final Value<String> id;
  final Value<String> businessId;
  final Value<String> name;
  final Value<String> phone;
  final Value<String> whatsapp;
  final Value<String?> email;
  final Value<String?> address;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CustomersCompanion({
    this.id = const Value.absent(),
    this.businessId = const Value.absent(),
    this.name = const Value.absent(),
    this.phone = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CustomersCompanion.insert({
    required String id,
    required String businessId,
    required String name,
    this.phone = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.email = const Value.absent(),
    this.address = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       businessId = Value(businessId),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CustomerRow> custom({
    Expression<String>? id,
    Expression<String>? businessId,
    Expression<String>? name,
    Expression<String>? phone,
    Expression<String>? whatsapp,
    Expression<String>? email,
    Expression<String>? address,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessId != null) 'business_id': businessId,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (email != null) 'email': email,
      if (address != null) 'address': address,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? businessId,
    Value<String>? name,
    Value<String>? phone,
    Value<String>? whatsapp,
    Value<String?>? email,
    Value<String?>? address,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CustomersCompanion(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      whatsapp: whatsapp ?? this.whatsapp,
      email: email ?? this.email,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (whatsapp.present) {
      map['whatsapp'] = Variable<String>(whatsapp.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CustomersCompanion(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('name: $name, ')
          ..write('phone: $phone, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('email: $email, ')
          ..write('address: $address, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoicesTable extends Invoices
    with TableInfo<$InvoicesTable, InvoiceRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoicesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _businessIdMeta = const VerificationMeta(
    'businessId',
  );
  @override
  late final GeneratedColumn<String> businessId = GeneratedColumn<String>(
    'business_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES businesses (id)',
    ),
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issueDateMeta = const VerificationMeta(
    'issueDate',
  );
  @override
  late final GeneratedColumn<DateTime> issueDate = GeneratedColumn<DateTime>(
    'issue_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dueDateMeta = const VerificationMeta(
    'dueDate',
  );
  @override
  late final GeneratedColumn<DateTime> dueDate = GeneratedColumn<DateTime>(
    'due_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES customers (id)',
    ),
  );
  static const VerificationMeta _customerNameMeta = const VerificationMeta(
    'customerName',
  );
  @override
  late final GeneratedColumn<String> customerName = GeneratedColumn<String>(
    'customer_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customerPhoneMeta = const VerificationMeta(
    'customerPhone',
  );
  @override
  late final GeneratedColumn<String> customerPhone = GeneratedColumn<String>(
    'customer_phone',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _customerWhatsappMeta = const VerificationMeta(
    'customerWhatsapp',
  );
  @override
  late final GeneratedColumn<String> customerWhatsapp = GeneratedColumn<String>(
    'customer_whatsapp',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _customerEmailMeta = const VerificationMeta(
    'customerEmail',
  );
  @override
  late final GeneratedColumn<String> customerEmail = GeneratedColumn<String>(
    'customer_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerAddressMeta = const VerificationMeta(
    'customerAddress',
  );
  @override
  late final GeneratedColumn<String> customerAddress = GeneratedColumn<String>(
    'customer_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerSavedMeta = const VerificationMeta(
    'customerSaved',
  );
  @override
  late final GeneratedColumn<bool> customerSaved = GeneratedColumn<bool>(
    'customer_saved',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("customer_saved" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _discountMinorMeta = const VerificationMeta(
    'discountMinor',
  );
  @override
  late final GeneratedColumn<int> discountMinor = GeneratedColumn<int>(
    'discount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxRateBpsMeta = const VerificationMeta(
    'taxRateBps',
  );
  @override
  late final GeneratedColumn<int> taxRateBps = GeneratedColumn<int>(
    'tax_rate_bps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxMinorMeta = const VerificationMeta(
    'taxMinor',
  );
  @override
  late final GeneratedColumn<int> taxMinor = GeneratedColumn<int>(
    'tax_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _chargesMinorMeta = const VerificationMeta(
    'chargesMinor',
  );
  @override
  late final GeneratedColumn<int> chargesMinor = GeneratedColumn<int>(
    'charges_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _subtotalMinorMeta = const VerificationMeta(
    'subtotalMinor',
  );
  @override
  late final GeneratedColumn<int> subtotalMinor = GeneratedColumn<int>(
    'subtotal_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _grandTotalMinorMeta = const VerificationMeta(
    'grandTotalMinor',
  );
  @override
  late final GeneratedColumn<int> grandTotalMinor = GeneratedColumn<int>(
    'grand_total_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _currencyMeta = const VerificationMeta(
    'currency',
  );
  @override
  late final GeneratedColumn<String> currency = GeneratedColumn<String>(
    'currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NGN'),
  );
  static const VerificationMeta _bankAccountIdMeta = const VerificationMeta(
    'bankAccountId',
  );
  @override
  late final GeneratedColumn<String> bankAccountId = GeneratedColumn<String>(
    'bank_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bank_accounts (id)',
    ),
  );
  static const VerificationMeta _bankSnapshotMeta = const VerificationMeta(
    'bankSnapshot',
  );
  @override
  late final GeneratedColumn<String> bankSnapshot = GeneratedColumn<String>(
    'bank_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandingSnapshotMeta = const VerificationMeta(
    'brandingSnapshot',
  );
  @override
  late final GeneratedColumn<String> brandingSnapshot = GeneratedColumn<String>(
    'branding_snapshot',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _paymentInstructionsMeta =
      const VerificationMeta('paymentInstructions');
  @override
  late final GeneratedColumn<String> paymentInstructions =
      GeneratedColumn<String>(
        'payment_instructions',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termsMeta = const VerificationMeta('terms');
  @override
  late final GeneratedColumn<String> terms = GeneratedColumn<String>(
    'terms',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _termsPresetMeta = const VerificationMeta(
    'termsPreset',
  );
  @override
  late final GeneratedColumn<String> termsPreset = GeneratedColumn<String>(
    'terms_preset',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('days7'),
  );
  static const VerificationMeta _templateMeta = const VerificationMeta(
    'template',
  );
  @override
  late final GeneratedColumn<String> template = GeneratedColumn<String>(
    'template',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('corporate'),
  );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _settledAtMeta = const VerificationMeta(
    'settledAt',
  );
  @override
  late final GeneratedColumn<DateTime> settledAt = GeneratedColumn<DateTime>(
    'settled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cancelledAtMeta = const VerificationMeta(
    'cancelledAt',
  );
  @override
  late final GeneratedColumn<DateTime> cancelledAt = GeneratedColumn<DateTime>(
    'cancelled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    businessId,
    number,
    status,
    issueDate,
    dueDate,
    customerId,
    customerName,
    customerPhone,
    customerWhatsapp,
    customerEmail,
    customerAddress,
    customerSaved,
    discountMinor,
    taxRateBps,
    taxMinor,
    chargesMinor,
    subtotalMinor,
    grandTotalMinor,
    currency,
    bankAccountId,
    bankSnapshot,
    brandingSnapshot,
    paymentInstructions,
    notes,
    terms,
    termsPreset,
    template,
    issuedAt,
    settledAt,
    cancelledAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoices';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('business_id')) {
      context.handle(
        _businessIdMeta,
        businessId.isAcceptableOrUnknown(data['business_id']!, _businessIdMeta),
      );
    } else if (isInserting) {
      context.missing(_businessIdMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('issue_date')) {
      context.handle(
        _issueDateMeta,
        issueDate.isAcceptableOrUnknown(data['issue_date']!, _issueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_issueDateMeta);
    }
    if (data.containsKey('due_date')) {
      context.handle(
        _dueDateMeta,
        dueDate.isAcceptableOrUnknown(data['due_date']!, _dueDateMeta),
      );
    } else if (isInserting) {
      context.missing(_dueDateMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('customer_name')) {
      context.handle(
        _customerNameMeta,
        customerName.isAcceptableOrUnknown(
          data['customer_name']!,
          _customerNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_customerNameMeta);
    }
    if (data.containsKey('customer_phone')) {
      context.handle(
        _customerPhoneMeta,
        customerPhone.isAcceptableOrUnknown(
          data['customer_phone']!,
          _customerPhoneMeta,
        ),
      );
    }
    if (data.containsKey('customer_whatsapp')) {
      context.handle(
        _customerWhatsappMeta,
        customerWhatsapp.isAcceptableOrUnknown(
          data['customer_whatsapp']!,
          _customerWhatsappMeta,
        ),
      );
    }
    if (data.containsKey('customer_email')) {
      context.handle(
        _customerEmailMeta,
        customerEmail.isAcceptableOrUnknown(
          data['customer_email']!,
          _customerEmailMeta,
        ),
      );
    }
    if (data.containsKey('customer_address')) {
      context.handle(
        _customerAddressMeta,
        customerAddress.isAcceptableOrUnknown(
          data['customer_address']!,
          _customerAddressMeta,
        ),
      );
    }
    if (data.containsKey('customer_saved')) {
      context.handle(
        _customerSavedMeta,
        customerSaved.isAcceptableOrUnknown(
          data['customer_saved']!,
          _customerSavedMeta,
        ),
      );
    }
    if (data.containsKey('discount_minor')) {
      context.handle(
        _discountMinorMeta,
        discountMinor.isAcceptableOrUnknown(
          data['discount_minor']!,
          _discountMinorMeta,
        ),
      );
    }
    if (data.containsKey('tax_rate_bps')) {
      context.handle(
        _taxRateBpsMeta,
        taxRateBps.isAcceptableOrUnknown(
          data['tax_rate_bps']!,
          _taxRateBpsMeta,
        ),
      );
    }
    if (data.containsKey('tax_minor')) {
      context.handle(
        _taxMinorMeta,
        taxMinor.isAcceptableOrUnknown(data['tax_minor']!, _taxMinorMeta),
      );
    }
    if (data.containsKey('charges_minor')) {
      context.handle(
        _chargesMinorMeta,
        chargesMinor.isAcceptableOrUnknown(
          data['charges_minor']!,
          _chargesMinorMeta,
        ),
      );
    }
    if (data.containsKey('subtotal_minor')) {
      context.handle(
        _subtotalMinorMeta,
        subtotalMinor.isAcceptableOrUnknown(
          data['subtotal_minor']!,
          _subtotalMinorMeta,
        ),
      );
    }
    if (data.containsKey('grand_total_minor')) {
      context.handle(
        _grandTotalMinorMeta,
        grandTotalMinor.isAcceptableOrUnknown(
          data['grand_total_minor']!,
          _grandTotalMinorMeta,
        ),
      );
    }
    if (data.containsKey('currency')) {
      context.handle(
        _currencyMeta,
        currency.isAcceptableOrUnknown(data['currency']!, _currencyMeta),
      );
    }
    if (data.containsKey('bank_account_id')) {
      context.handle(
        _bankAccountIdMeta,
        bankAccountId.isAcceptableOrUnknown(
          data['bank_account_id']!,
          _bankAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('bank_snapshot')) {
      context.handle(
        _bankSnapshotMeta,
        bankSnapshot.isAcceptableOrUnknown(
          data['bank_snapshot']!,
          _bankSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('branding_snapshot')) {
      context.handle(
        _brandingSnapshotMeta,
        brandingSnapshot.isAcceptableOrUnknown(
          data['branding_snapshot']!,
          _brandingSnapshotMeta,
        ),
      );
    }
    if (data.containsKey('payment_instructions')) {
      context.handle(
        _paymentInstructionsMeta,
        paymentInstructions.isAcceptableOrUnknown(
          data['payment_instructions']!,
          _paymentInstructionsMeta,
        ),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('terms')) {
      context.handle(
        _termsMeta,
        terms.isAcceptableOrUnknown(data['terms']!, _termsMeta),
      );
    }
    if (data.containsKey('terms_preset')) {
      context.handle(
        _termsPresetMeta,
        termsPreset.isAcceptableOrUnknown(
          data['terms_preset']!,
          _termsPresetMeta,
        ),
      );
    }
    if (data.containsKey('template')) {
      context.handle(
        _templateMeta,
        template.isAcceptableOrUnknown(data['template']!, _templateMeta),
      );
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    }
    if (data.containsKey('settled_at')) {
      context.handle(
        _settledAtMeta,
        settledAt.isAcceptableOrUnknown(data['settled_at']!, _settledAtMeta),
      );
    }
    if (data.containsKey('cancelled_at')) {
      context.handle(
        _cancelledAtMeta,
        cancelledAt.isAcceptableOrUnknown(
          data['cancelled_at']!,
          _cancelledAtMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      businessId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}business_id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      ),
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      issueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issue_date'],
      )!,
      dueDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}due_date'],
      )!,
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      customerName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_name'],
      )!,
      customerPhone: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_phone'],
      )!,
      customerWhatsapp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_whatsapp'],
      )!,
      customerEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_email'],
      ),
      customerAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_address'],
      ),
      customerSaved: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}customer_saved'],
      )!,
      discountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}discount_minor'],
      )!,
      taxRateBps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_rate_bps'],
      )!,
      taxMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tax_minor'],
      )!,
      chargesMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}charges_minor'],
      )!,
      subtotalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_minor'],
      )!,
      grandTotalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}grand_total_minor'],
      )!,
      currency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency'],
      )!,
      bankAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_id'],
      ),
      bankSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_snapshot'],
      ),
      brandingSnapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branding_snapshot'],
      ),
      paymentInstructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_instructions'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      terms: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms'],
      ),
      termsPreset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}terms_preset'],
      )!,
      template: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template'],
      )!,
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      ),
      settledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}settled_at'],
      ),
      cancelledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cancelled_at'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $InvoicesTable createAlias(String alias) {
    return $InvoicesTable(attachedDatabase, alias);
  }
}

class InvoiceRow extends DataClass implements Insertable<InvoiceRow> {
  final String id;
  final String businessId;
  final String? number;
  final String status;
  final DateTime issueDate;
  final DateTime dueDate;
  final String? customerId;
  final String customerName;
  final String customerPhone;
  final String customerWhatsapp;
  final String? customerEmail;
  final String? customerAddress;
  final bool customerSaved;
  final int discountMinor;
  final int taxRateBps;
  final int taxMinor;
  final int chargesMinor;
  final int subtotalMinor;
  final int grandTotalMinor;
  final String currency;
  final String? bankAccountId;
  final String? bankSnapshot;
  final String? brandingSnapshot;
  final String paymentInstructions;
  final String? notes;
  final String? terms;
  final String termsPreset;
  final String template;
  final DateTime? issuedAt;
  final DateTime? settledAt;
  final DateTime? cancelledAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const InvoiceRow({
    required this.id,
    required this.businessId,
    this.number,
    required this.status,
    required this.issueDate,
    required this.dueDate,
    this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.customerWhatsapp,
    this.customerEmail,
    this.customerAddress,
    required this.customerSaved,
    required this.discountMinor,
    required this.taxRateBps,
    required this.taxMinor,
    required this.chargesMinor,
    required this.subtotalMinor,
    required this.grandTotalMinor,
    required this.currency,
    this.bankAccountId,
    this.bankSnapshot,
    this.brandingSnapshot,
    required this.paymentInstructions,
    this.notes,
    this.terms,
    required this.termsPreset,
    required this.template,
    this.issuedAt,
    this.settledAt,
    this.cancelledAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['business_id'] = Variable<String>(businessId);
    if (!nullToAbsent || number != null) {
      map['number'] = Variable<String>(number);
    }
    map['status'] = Variable<String>(status);
    map['issue_date'] = Variable<DateTime>(issueDate);
    map['due_date'] = Variable<DateTime>(dueDate);
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['customer_name'] = Variable<String>(customerName);
    map['customer_phone'] = Variable<String>(customerPhone);
    map['customer_whatsapp'] = Variable<String>(customerWhatsapp);
    if (!nullToAbsent || customerEmail != null) {
      map['customer_email'] = Variable<String>(customerEmail);
    }
    if (!nullToAbsent || customerAddress != null) {
      map['customer_address'] = Variable<String>(customerAddress);
    }
    map['customer_saved'] = Variable<bool>(customerSaved);
    map['discount_minor'] = Variable<int>(discountMinor);
    map['tax_rate_bps'] = Variable<int>(taxRateBps);
    map['tax_minor'] = Variable<int>(taxMinor);
    map['charges_minor'] = Variable<int>(chargesMinor);
    map['subtotal_minor'] = Variable<int>(subtotalMinor);
    map['grand_total_minor'] = Variable<int>(grandTotalMinor);
    map['currency'] = Variable<String>(currency);
    if (!nullToAbsent || bankAccountId != null) {
      map['bank_account_id'] = Variable<String>(bankAccountId);
    }
    if (!nullToAbsent || bankSnapshot != null) {
      map['bank_snapshot'] = Variable<String>(bankSnapshot);
    }
    if (!nullToAbsent || brandingSnapshot != null) {
      map['branding_snapshot'] = Variable<String>(brandingSnapshot);
    }
    map['payment_instructions'] = Variable<String>(paymentInstructions);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || terms != null) {
      map['terms'] = Variable<String>(terms);
    }
    map['terms_preset'] = Variable<String>(termsPreset);
    map['template'] = Variable<String>(template);
    if (!nullToAbsent || issuedAt != null) {
      map['issued_at'] = Variable<DateTime>(issuedAt);
    }
    if (!nullToAbsent || settledAt != null) {
      map['settled_at'] = Variable<DateTime>(settledAt);
    }
    if (!nullToAbsent || cancelledAt != null) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  InvoicesCompanion toCompanion(bool nullToAbsent) {
    return InvoicesCompanion(
      id: Value(id),
      businessId: Value(businessId),
      number: number == null && nullToAbsent
          ? const Value.absent()
          : Value(number),
      status: Value(status),
      issueDate: Value(issueDate),
      dueDate: Value(dueDate),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      customerName: Value(customerName),
      customerPhone: Value(customerPhone),
      customerWhatsapp: Value(customerWhatsapp),
      customerEmail: customerEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(customerEmail),
      customerAddress: customerAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(customerAddress),
      customerSaved: Value(customerSaved),
      discountMinor: Value(discountMinor),
      taxRateBps: Value(taxRateBps),
      taxMinor: Value(taxMinor),
      chargesMinor: Value(chargesMinor),
      subtotalMinor: Value(subtotalMinor),
      grandTotalMinor: Value(grandTotalMinor),
      currency: Value(currency),
      bankAccountId: bankAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(bankAccountId),
      bankSnapshot: bankSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(bankSnapshot),
      brandingSnapshot: brandingSnapshot == null && nullToAbsent
          ? const Value.absent()
          : Value(brandingSnapshot),
      paymentInstructions: Value(paymentInstructions),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      terms: terms == null && nullToAbsent
          ? const Value.absent()
          : Value(terms),
      termsPreset: Value(termsPreset),
      template: Value(template),
      issuedAt: issuedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(issuedAt),
      settledAt: settledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(settledAt),
      cancelledAt: cancelledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(cancelledAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory InvoiceRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceRow(
      id: serializer.fromJson<String>(json['id']),
      businessId: serializer.fromJson<String>(json['businessId']),
      number: serializer.fromJson<String?>(json['number']),
      status: serializer.fromJson<String>(json['status']),
      issueDate: serializer.fromJson<DateTime>(json['issueDate']),
      dueDate: serializer.fromJson<DateTime>(json['dueDate']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      customerName: serializer.fromJson<String>(json['customerName']),
      customerPhone: serializer.fromJson<String>(json['customerPhone']),
      customerWhatsapp: serializer.fromJson<String>(json['customerWhatsapp']),
      customerEmail: serializer.fromJson<String?>(json['customerEmail']),
      customerAddress: serializer.fromJson<String?>(json['customerAddress']),
      customerSaved: serializer.fromJson<bool>(json['customerSaved']),
      discountMinor: serializer.fromJson<int>(json['discountMinor']),
      taxRateBps: serializer.fromJson<int>(json['taxRateBps']),
      taxMinor: serializer.fromJson<int>(json['taxMinor']),
      chargesMinor: serializer.fromJson<int>(json['chargesMinor']),
      subtotalMinor: serializer.fromJson<int>(json['subtotalMinor']),
      grandTotalMinor: serializer.fromJson<int>(json['grandTotalMinor']),
      currency: serializer.fromJson<String>(json['currency']),
      bankAccountId: serializer.fromJson<String?>(json['bankAccountId']),
      bankSnapshot: serializer.fromJson<String?>(json['bankSnapshot']),
      brandingSnapshot: serializer.fromJson<String?>(json['brandingSnapshot']),
      paymentInstructions: serializer.fromJson<String>(
        json['paymentInstructions'],
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      terms: serializer.fromJson<String?>(json['terms']),
      termsPreset: serializer.fromJson<String>(json['termsPreset']),
      template: serializer.fromJson<String>(json['template']),
      issuedAt: serializer.fromJson<DateTime?>(json['issuedAt']),
      settledAt: serializer.fromJson<DateTime?>(json['settledAt']),
      cancelledAt: serializer.fromJson<DateTime?>(json['cancelledAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'businessId': serializer.toJson<String>(businessId),
      'number': serializer.toJson<String?>(number),
      'status': serializer.toJson<String>(status),
      'issueDate': serializer.toJson<DateTime>(issueDate),
      'dueDate': serializer.toJson<DateTime>(dueDate),
      'customerId': serializer.toJson<String?>(customerId),
      'customerName': serializer.toJson<String>(customerName),
      'customerPhone': serializer.toJson<String>(customerPhone),
      'customerWhatsapp': serializer.toJson<String>(customerWhatsapp),
      'customerEmail': serializer.toJson<String?>(customerEmail),
      'customerAddress': serializer.toJson<String?>(customerAddress),
      'customerSaved': serializer.toJson<bool>(customerSaved),
      'discountMinor': serializer.toJson<int>(discountMinor),
      'taxRateBps': serializer.toJson<int>(taxRateBps),
      'taxMinor': serializer.toJson<int>(taxMinor),
      'chargesMinor': serializer.toJson<int>(chargesMinor),
      'subtotalMinor': serializer.toJson<int>(subtotalMinor),
      'grandTotalMinor': serializer.toJson<int>(grandTotalMinor),
      'currency': serializer.toJson<String>(currency),
      'bankAccountId': serializer.toJson<String?>(bankAccountId),
      'bankSnapshot': serializer.toJson<String?>(bankSnapshot),
      'brandingSnapshot': serializer.toJson<String?>(brandingSnapshot),
      'paymentInstructions': serializer.toJson<String>(paymentInstructions),
      'notes': serializer.toJson<String?>(notes),
      'terms': serializer.toJson<String?>(terms),
      'termsPreset': serializer.toJson<String>(termsPreset),
      'template': serializer.toJson<String>(template),
      'issuedAt': serializer.toJson<DateTime?>(issuedAt),
      'settledAt': serializer.toJson<DateTime?>(settledAt),
      'cancelledAt': serializer.toJson<DateTime?>(cancelledAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  InvoiceRow copyWith({
    String? id,
    String? businessId,
    Value<String?> number = const Value.absent(),
    String? status,
    DateTime? issueDate,
    DateTime? dueDate,
    Value<String?> customerId = const Value.absent(),
    String? customerName,
    String? customerPhone,
    String? customerWhatsapp,
    Value<String?> customerEmail = const Value.absent(),
    Value<String?> customerAddress = const Value.absent(),
    bool? customerSaved,
    int? discountMinor,
    int? taxRateBps,
    int? taxMinor,
    int? chargesMinor,
    int? subtotalMinor,
    int? grandTotalMinor,
    String? currency,
    Value<String?> bankAccountId = const Value.absent(),
    Value<String?> bankSnapshot = const Value.absent(),
    Value<String?> brandingSnapshot = const Value.absent(),
    String? paymentInstructions,
    Value<String?> notes = const Value.absent(),
    Value<String?> terms = const Value.absent(),
    String? termsPreset,
    String? template,
    Value<DateTime?> issuedAt = const Value.absent(),
    Value<DateTime?> settledAt = const Value.absent(),
    Value<DateTime?> cancelledAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => InvoiceRow(
    id: id ?? this.id,
    businessId: businessId ?? this.businessId,
    number: number.present ? number.value : this.number,
    status: status ?? this.status,
    issueDate: issueDate ?? this.issueDate,
    dueDate: dueDate ?? this.dueDate,
    customerId: customerId.present ? customerId.value : this.customerId,
    customerName: customerName ?? this.customerName,
    customerPhone: customerPhone ?? this.customerPhone,
    customerWhatsapp: customerWhatsapp ?? this.customerWhatsapp,
    customerEmail: customerEmail.present
        ? customerEmail.value
        : this.customerEmail,
    customerAddress: customerAddress.present
        ? customerAddress.value
        : this.customerAddress,
    customerSaved: customerSaved ?? this.customerSaved,
    discountMinor: discountMinor ?? this.discountMinor,
    taxRateBps: taxRateBps ?? this.taxRateBps,
    taxMinor: taxMinor ?? this.taxMinor,
    chargesMinor: chargesMinor ?? this.chargesMinor,
    subtotalMinor: subtotalMinor ?? this.subtotalMinor,
    grandTotalMinor: grandTotalMinor ?? this.grandTotalMinor,
    currency: currency ?? this.currency,
    bankAccountId: bankAccountId.present
        ? bankAccountId.value
        : this.bankAccountId,
    bankSnapshot: bankSnapshot.present ? bankSnapshot.value : this.bankSnapshot,
    brandingSnapshot: brandingSnapshot.present
        ? brandingSnapshot.value
        : this.brandingSnapshot,
    paymentInstructions: paymentInstructions ?? this.paymentInstructions,
    notes: notes.present ? notes.value : this.notes,
    terms: terms.present ? terms.value : this.terms,
    termsPreset: termsPreset ?? this.termsPreset,
    template: template ?? this.template,
    issuedAt: issuedAt.present ? issuedAt.value : this.issuedAt,
    settledAt: settledAt.present ? settledAt.value : this.settledAt,
    cancelledAt: cancelledAt.present ? cancelledAt.value : this.cancelledAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  InvoiceRow copyWithCompanion(InvoicesCompanion data) {
    return InvoiceRow(
      id: data.id.present ? data.id.value : this.id,
      businessId: data.businessId.present
          ? data.businessId.value
          : this.businessId,
      number: data.number.present ? data.number.value : this.number,
      status: data.status.present ? data.status.value : this.status,
      issueDate: data.issueDate.present ? data.issueDate.value : this.issueDate,
      dueDate: data.dueDate.present ? data.dueDate.value : this.dueDate,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      customerName: data.customerName.present
          ? data.customerName.value
          : this.customerName,
      customerPhone: data.customerPhone.present
          ? data.customerPhone.value
          : this.customerPhone,
      customerWhatsapp: data.customerWhatsapp.present
          ? data.customerWhatsapp.value
          : this.customerWhatsapp,
      customerEmail: data.customerEmail.present
          ? data.customerEmail.value
          : this.customerEmail,
      customerAddress: data.customerAddress.present
          ? data.customerAddress.value
          : this.customerAddress,
      customerSaved: data.customerSaved.present
          ? data.customerSaved.value
          : this.customerSaved,
      discountMinor: data.discountMinor.present
          ? data.discountMinor.value
          : this.discountMinor,
      taxRateBps: data.taxRateBps.present
          ? data.taxRateBps.value
          : this.taxRateBps,
      taxMinor: data.taxMinor.present ? data.taxMinor.value : this.taxMinor,
      chargesMinor: data.chargesMinor.present
          ? data.chargesMinor.value
          : this.chargesMinor,
      subtotalMinor: data.subtotalMinor.present
          ? data.subtotalMinor.value
          : this.subtotalMinor,
      grandTotalMinor: data.grandTotalMinor.present
          ? data.grandTotalMinor.value
          : this.grandTotalMinor,
      currency: data.currency.present ? data.currency.value : this.currency,
      bankAccountId: data.bankAccountId.present
          ? data.bankAccountId.value
          : this.bankAccountId,
      bankSnapshot: data.bankSnapshot.present
          ? data.bankSnapshot.value
          : this.bankSnapshot,
      brandingSnapshot: data.brandingSnapshot.present
          ? data.brandingSnapshot.value
          : this.brandingSnapshot,
      paymentInstructions: data.paymentInstructions.present
          ? data.paymentInstructions.value
          : this.paymentInstructions,
      notes: data.notes.present ? data.notes.value : this.notes,
      terms: data.terms.present ? data.terms.value : this.terms,
      termsPreset: data.termsPreset.present
          ? data.termsPreset.value
          : this.termsPreset,
      template: data.template.present ? data.template.value : this.template,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      settledAt: data.settledAt.present ? data.settledAt.value : this.settledAt,
      cancelledAt: data.cancelledAt.present
          ? data.cancelledAt.value
          : this.cancelledAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceRow(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('number: $number, ')
          ..write('status: $status, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('customerWhatsapp: $customerWhatsapp, ')
          ..write('customerEmail: $customerEmail, ')
          ..write('customerAddress: $customerAddress, ')
          ..write('customerSaved: $customerSaved, ')
          ..write('discountMinor: $discountMinor, ')
          ..write('taxRateBps: $taxRateBps, ')
          ..write('taxMinor: $taxMinor, ')
          ..write('chargesMinor: $chargesMinor, ')
          ..write('subtotalMinor: $subtotalMinor, ')
          ..write('grandTotalMinor: $grandTotalMinor, ')
          ..write('currency: $currency, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('bankSnapshot: $bankSnapshot, ')
          ..write('brandingSnapshot: $brandingSnapshot, ')
          ..write('paymentInstructions: $paymentInstructions, ')
          ..write('notes: $notes, ')
          ..write('terms: $terms, ')
          ..write('termsPreset: $termsPreset, ')
          ..write('template: $template, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('settledAt: $settledAt, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    businessId,
    number,
    status,
    issueDate,
    dueDate,
    customerId,
    customerName,
    customerPhone,
    customerWhatsapp,
    customerEmail,
    customerAddress,
    customerSaved,
    discountMinor,
    taxRateBps,
    taxMinor,
    chargesMinor,
    subtotalMinor,
    grandTotalMinor,
    currency,
    bankAccountId,
    bankSnapshot,
    brandingSnapshot,
    paymentInstructions,
    notes,
    terms,
    termsPreset,
    template,
    issuedAt,
    settledAt,
    cancelledAt,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceRow &&
          other.id == this.id &&
          other.businessId == this.businessId &&
          other.number == this.number &&
          other.status == this.status &&
          other.issueDate == this.issueDate &&
          other.dueDate == this.dueDate &&
          other.customerId == this.customerId &&
          other.customerName == this.customerName &&
          other.customerPhone == this.customerPhone &&
          other.customerWhatsapp == this.customerWhatsapp &&
          other.customerEmail == this.customerEmail &&
          other.customerAddress == this.customerAddress &&
          other.customerSaved == this.customerSaved &&
          other.discountMinor == this.discountMinor &&
          other.taxRateBps == this.taxRateBps &&
          other.taxMinor == this.taxMinor &&
          other.chargesMinor == this.chargesMinor &&
          other.subtotalMinor == this.subtotalMinor &&
          other.grandTotalMinor == this.grandTotalMinor &&
          other.currency == this.currency &&
          other.bankAccountId == this.bankAccountId &&
          other.bankSnapshot == this.bankSnapshot &&
          other.brandingSnapshot == this.brandingSnapshot &&
          other.paymentInstructions == this.paymentInstructions &&
          other.notes == this.notes &&
          other.terms == this.terms &&
          other.termsPreset == this.termsPreset &&
          other.template == this.template &&
          other.issuedAt == this.issuedAt &&
          other.settledAt == this.settledAt &&
          other.cancelledAt == this.cancelledAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class InvoicesCompanion extends UpdateCompanion<InvoiceRow> {
  final Value<String> id;
  final Value<String> businessId;
  final Value<String?> number;
  final Value<String> status;
  final Value<DateTime> issueDate;
  final Value<DateTime> dueDate;
  final Value<String?> customerId;
  final Value<String> customerName;
  final Value<String> customerPhone;
  final Value<String> customerWhatsapp;
  final Value<String?> customerEmail;
  final Value<String?> customerAddress;
  final Value<bool> customerSaved;
  final Value<int> discountMinor;
  final Value<int> taxRateBps;
  final Value<int> taxMinor;
  final Value<int> chargesMinor;
  final Value<int> subtotalMinor;
  final Value<int> grandTotalMinor;
  final Value<String> currency;
  final Value<String?> bankAccountId;
  final Value<String?> bankSnapshot;
  final Value<String?> brandingSnapshot;
  final Value<String> paymentInstructions;
  final Value<String?> notes;
  final Value<String?> terms;
  final Value<String> termsPreset;
  final Value<String> template;
  final Value<DateTime?> issuedAt;
  final Value<DateTime?> settledAt;
  final Value<DateTime?> cancelledAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const InvoicesCompanion({
    this.id = const Value.absent(),
    this.businessId = const Value.absent(),
    this.number = const Value.absent(),
    this.status = const Value.absent(),
    this.issueDate = const Value.absent(),
    this.dueDate = const Value.absent(),
    this.customerId = const Value.absent(),
    this.customerName = const Value.absent(),
    this.customerPhone = const Value.absent(),
    this.customerWhatsapp = const Value.absent(),
    this.customerEmail = const Value.absent(),
    this.customerAddress = const Value.absent(),
    this.customerSaved = const Value.absent(),
    this.discountMinor = const Value.absent(),
    this.taxRateBps = const Value.absent(),
    this.taxMinor = const Value.absent(),
    this.chargesMinor = const Value.absent(),
    this.subtotalMinor = const Value.absent(),
    this.grandTotalMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.bankAccountId = const Value.absent(),
    this.bankSnapshot = const Value.absent(),
    this.brandingSnapshot = const Value.absent(),
    this.paymentInstructions = const Value.absent(),
    this.notes = const Value.absent(),
    this.terms = const Value.absent(),
    this.termsPreset = const Value.absent(),
    this.template = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.settledAt = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoicesCompanion.insert({
    required String id,
    required String businessId,
    this.number = const Value.absent(),
    required String status,
    required DateTime issueDate,
    required DateTime dueDate,
    this.customerId = const Value.absent(),
    required String customerName,
    this.customerPhone = const Value.absent(),
    this.customerWhatsapp = const Value.absent(),
    this.customerEmail = const Value.absent(),
    this.customerAddress = const Value.absent(),
    this.customerSaved = const Value.absent(),
    this.discountMinor = const Value.absent(),
    this.taxRateBps = const Value.absent(),
    this.taxMinor = const Value.absent(),
    this.chargesMinor = const Value.absent(),
    this.subtotalMinor = const Value.absent(),
    this.grandTotalMinor = const Value.absent(),
    this.currency = const Value.absent(),
    this.bankAccountId = const Value.absent(),
    this.bankSnapshot = const Value.absent(),
    this.brandingSnapshot = const Value.absent(),
    this.paymentInstructions = const Value.absent(),
    this.notes = const Value.absent(),
    this.terms = const Value.absent(),
    this.termsPreset = const Value.absent(),
    this.template = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.settledAt = const Value.absent(),
    this.cancelledAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       businessId = Value(businessId),
       status = Value(status),
       issueDate = Value(issueDate),
       dueDate = Value(dueDate),
       customerName = Value(customerName),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<InvoiceRow> custom({
    Expression<String>? id,
    Expression<String>? businessId,
    Expression<String>? number,
    Expression<String>? status,
    Expression<DateTime>? issueDate,
    Expression<DateTime>? dueDate,
    Expression<String>? customerId,
    Expression<String>? customerName,
    Expression<String>? customerPhone,
    Expression<String>? customerWhatsapp,
    Expression<String>? customerEmail,
    Expression<String>? customerAddress,
    Expression<bool>? customerSaved,
    Expression<int>? discountMinor,
    Expression<int>? taxRateBps,
    Expression<int>? taxMinor,
    Expression<int>? chargesMinor,
    Expression<int>? subtotalMinor,
    Expression<int>? grandTotalMinor,
    Expression<String>? currency,
    Expression<String>? bankAccountId,
    Expression<String>? bankSnapshot,
    Expression<String>? brandingSnapshot,
    Expression<String>? paymentInstructions,
    Expression<String>? notes,
    Expression<String>? terms,
    Expression<String>? termsPreset,
    Expression<String>? template,
    Expression<DateTime>? issuedAt,
    Expression<DateTime>? settledAt,
    Expression<DateTime>? cancelledAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (businessId != null) 'business_id': businessId,
      if (number != null) 'number': number,
      if (status != null) 'status': status,
      if (issueDate != null) 'issue_date': issueDate,
      if (dueDate != null) 'due_date': dueDate,
      if (customerId != null) 'customer_id': customerId,
      if (customerName != null) 'customer_name': customerName,
      if (customerPhone != null) 'customer_phone': customerPhone,
      if (customerWhatsapp != null) 'customer_whatsapp': customerWhatsapp,
      if (customerEmail != null) 'customer_email': customerEmail,
      if (customerAddress != null) 'customer_address': customerAddress,
      if (customerSaved != null) 'customer_saved': customerSaved,
      if (discountMinor != null) 'discount_minor': discountMinor,
      if (taxRateBps != null) 'tax_rate_bps': taxRateBps,
      if (taxMinor != null) 'tax_minor': taxMinor,
      if (chargesMinor != null) 'charges_minor': chargesMinor,
      if (subtotalMinor != null) 'subtotal_minor': subtotalMinor,
      if (grandTotalMinor != null) 'grand_total_minor': grandTotalMinor,
      if (currency != null) 'currency': currency,
      if (bankAccountId != null) 'bank_account_id': bankAccountId,
      if (bankSnapshot != null) 'bank_snapshot': bankSnapshot,
      if (brandingSnapshot != null) 'branding_snapshot': brandingSnapshot,
      if (paymentInstructions != null)
        'payment_instructions': paymentInstructions,
      if (notes != null) 'notes': notes,
      if (terms != null) 'terms': terms,
      if (termsPreset != null) 'terms_preset': termsPreset,
      if (template != null) 'template': template,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (settledAt != null) 'settled_at': settledAt,
      if (cancelledAt != null) 'cancelled_at': cancelledAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoicesCompanion copyWith({
    Value<String>? id,
    Value<String>? businessId,
    Value<String?>? number,
    Value<String>? status,
    Value<DateTime>? issueDate,
    Value<DateTime>? dueDate,
    Value<String?>? customerId,
    Value<String>? customerName,
    Value<String>? customerPhone,
    Value<String>? customerWhatsapp,
    Value<String?>? customerEmail,
    Value<String?>? customerAddress,
    Value<bool>? customerSaved,
    Value<int>? discountMinor,
    Value<int>? taxRateBps,
    Value<int>? taxMinor,
    Value<int>? chargesMinor,
    Value<int>? subtotalMinor,
    Value<int>? grandTotalMinor,
    Value<String>? currency,
    Value<String?>? bankAccountId,
    Value<String?>? bankSnapshot,
    Value<String?>? brandingSnapshot,
    Value<String>? paymentInstructions,
    Value<String?>? notes,
    Value<String?>? terms,
    Value<String>? termsPreset,
    Value<String>? template,
    Value<DateTime?>? issuedAt,
    Value<DateTime?>? settledAt,
    Value<DateTime?>? cancelledAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return InvoicesCompanion(
      id: id ?? this.id,
      businessId: businessId ?? this.businessId,
      number: number ?? this.number,
      status: status ?? this.status,
      issueDate: issueDate ?? this.issueDate,
      dueDate: dueDate ?? this.dueDate,
      customerId: customerId ?? this.customerId,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
      customerWhatsapp: customerWhatsapp ?? this.customerWhatsapp,
      customerEmail: customerEmail ?? this.customerEmail,
      customerAddress: customerAddress ?? this.customerAddress,
      customerSaved: customerSaved ?? this.customerSaved,
      discountMinor: discountMinor ?? this.discountMinor,
      taxRateBps: taxRateBps ?? this.taxRateBps,
      taxMinor: taxMinor ?? this.taxMinor,
      chargesMinor: chargesMinor ?? this.chargesMinor,
      subtotalMinor: subtotalMinor ?? this.subtotalMinor,
      grandTotalMinor: grandTotalMinor ?? this.grandTotalMinor,
      currency: currency ?? this.currency,
      bankAccountId: bankAccountId ?? this.bankAccountId,
      bankSnapshot: bankSnapshot ?? this.bankSnapshot,
      brandingSnapshot: brandingSnapshot ?? this.brandingSnapshot,
      paymentInstructions: paymentInstructions ?? this.paymentInstructions,
      notes: notes ?? this.notes,
      terms: terms ?? this.terms,
      termsPreset: termsPreset ?? this.termsPreset,
      template: template ?? this.template,
      issuedAt: issuedAt ?? this.issuedAt,
      settledAt: settledAt ?? this.settledAt,
      cancelledAt: cancelledAt ?? this.cancelledAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (businessId.present) {
      map['business_id'] = Variable<String>(businessId.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (issueDate.present) {
      map['issue_date'] = Variable<DateTime>(issueDate.value);
    }
    if (dueDate.present) {
      map['due_date'] = Variable<DateTime>(dueDate.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (customerName.present) {
      map['customer_name'] = Variable<String>(customerName.value);
    }
    if (customerPhone.present) {
      map['customer_phone'] = Variable<String>(customerPhone.value);
    }
    if (customerWhatsapp.present) {
      map['customer_whatsapp'] = Variable<String>(customerWhatsapp.value);
    }
    if (customerEmail.present) {
      map['customer_email'] = Variable<String>(customerEmail.value);
    }
    if (customerAddress.present) {
      map['customer_address'] = Variable<String>(customerAddress.value);
    }
    if (customerSaved.present) {
      map['customer_saved'] = Variable<bool>(customerSaved.value);
    }
    if (discountMinor.present) {
      map['discount_minor'] = Variable<int>(discountMinor.value);
    }
    if (taxRateBps.present) {
      map['tax_rate_bps'] = Variable<int>(taxRateBps.value);
    }
    if (taxMinor.present) {
      map['tax_minor'] = Variable<int>(taxMinor.value);
    }
    if (chargesMinor.present) {
      map['charges_minor'] = Variable<int>(chargesMinor.value);
    }
    if (subtotalMinor.present) {
      map['subtotal_minor'] = Variable<int>(subtotalMinor.value);
    }
    if (grandTotalMinor.present) {
      map['grand_total_minor'] = Variable<int>(grandTotalMinor.value);
    }
    if (currency.present) {
      map['currency'] = Variable<String>(currency.value);
    }
    if (bankAccountId.present) {
      map['bank_account_id'] = Variable<String>(bankAccountId.value);
    }
    if (bankSnapshot.present) {
      map['bank_snapshot'] = Variable<String>(bankSnapshot.value);
    }
    if (brandingSnapshot.present) {
      map['branding_snapshot'] = Variable<String>(brandingSnapshot.value);
    }
    if (paymentInstructions.present) {
      map['payment_instructions'] = Variable<String>(paymentInstructions.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (terms.present) {
      map['terms'] = Variable<String>(terms.value);
    }
    if (termsPreset.present) {
      map['terms_preset'] = Variable<String>(termsPreset.value);
    }
    if (template.present) {
      map['template'] = Variable<String>(template.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (settledAt.present) {
      map['settled_at'] = Variable<DateTime>(settledAt.value);
    }
    if (cancelledAt.present) {
      map['cancelled_at'] = Variable<DateTime>(cancelledAt.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoicesCompanion(')
          ..write('id: $id, ')
          ..write('businessId: $businessId, ')
          ..write('number: $number, ')
          ..write('status: $status, ')
          ..write('issueDate: $issueDate, ')
          ..write('dueDate: $dueDate, ')
          ..write('customerId: $customerId, ')
          ..write('customerName: $customerName, ')
          ..write('customerPhone: $customerPhone, ')
          ..write('customerWhatsapp: $customerWhatsapp, ')
          ..write('customerEmail: $customerEmail, ')
          ..write('customerAddress: $customerAddress, ')
          ..write('customerSaved: $customerSaved, ')
          ..write('discountMinor: $discountMinor, ')
          ..write('taxRateBps: $taxRateBps, ')
          ..write('taxMinor: $taxMinor, ')
          ..write('chargesMinor: $chargesMinor, ')
          ..write('subtotalMinor: $subtotalMinor, ')
          ..write('grandTotalMinor: $grandTotalMinor, ')
          ..write('currency: $currency, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('bankSnapshot: $bankSnapshot, ')
          ..write('brandingSnapshot: $brandingSnapshot, ')
          ..write('paymentInstructions: $paymentInstructions, ')
          ..write('notes: $notes, ')
          ..write('terms: $terms, ')
          ..write('termsPreset: $termsPreset, ')
          ..write('template: $template, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('settledAt: $settledAt, ')
          ..write('cancelledAt: $cancelledAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InvoiceItemsTable extends InvoiceItems
    with TableInfo<$InvoiceItemsTable, InvoiceItemRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InvoiceItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _serviceIdMeta = const VerificationMeta(
    'serviceId',
  );
  @override
  late final GeneratedColumn<String> serviceId = GeneratedColumn<String>(
    'service_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES services (id)',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _quantityMilliMeta = const VerificationMeta(
    'quantityMilli',
  );
  @override
  late final GeneratedColumn<int> quantityMilli = GeneratedColumn<int>(
    'quantity_milli',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _customUnitMeta = const VerificationMeta(
    'customUnit',
  );
  @override
  late final GeneratedColumn<String> customUnit = GeneratedColumn<String>(
    'custom_unit',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitPriceMinorMeta = const VerificationMeta(
    'unitPriceMinor',
  );
  @override
  late final GeneratedColumn<int> unitPriceMinor = GeneratedColumn<int>(
    'unit_price_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lineTotalMinorMeta = const VerificationMeta(
    'lineTotalMinor',
  );
  @override
  late final GeneratedColumn<int> lineTotalMinor = GeneratedColumn<int>(
    'line_total_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<int> position = GeneratedColumn<int>(
    'position',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    serviceId,
    name,
    description,
    quantityMilli,
    unit,
    customUnit,
    unitPriceMinor,
    lineTotalMinor,
    position,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'invoice_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InvoiceItemRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('service_id')) {
      context.handle(
        _serviceIdMeta,
        serviceId.isAcceptableOrUnknown(data['service_id']!, _serviceIdMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('quantity_milli')) {
      context.handle(
        _quantityMilliMeta,
        quantityMilli.isAcceptableOrUnknown(
          data['quantity_milli']!,
          _quantityMilliMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_quantityMilliMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('custom_unit')) {
      context.handle(
        _customUnitMeta,
        customUnit.isAcceptableOrUnknown(data['custom_unit']!, _customUnitMeta),
      );
    }
    if (data.containsKey('unit_price_minor')) {
      context.handle(
        _unitPriceMinorMeta,
        unitPriceMinor.isAcceptableOrUnknown(
          data['unit_price_minor']!,
          _unitPriceMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMinorMeta);
    }
    if (data.containsKey('line_total_minor')) {
      context.handle(
        _lineTotalMinorMeta,
        lineTotalMinor.isAcceptableOrUnknown(
          data['line_total_minor']!,
          _lineTotalMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lineTotalMinorMeta);
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  InvoiceItemRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InvoiceItemRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      serviceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}service_id'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      quantityMilli: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity_milli'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      customUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}custom_unit'],
      ),
      unitPriceMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}unit_price_minor'],
      )!,
      lineTotalMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}line_total_minor'],
      )!,
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}position'],
      )!,
    );
  }

  @override
  $InvoiceItemsTable createAlias(String alias) {
    return $InvoiceItemsTable(attachedDatabase, alias);
  }
}

class InvoiceItemRow extends DataClass implements Insertable<InvoiceItemRow> {
  final String id;
  final String invoiceId;
  final String? serviceId;
  final String name;
  final String description;
  final int quantityMilli;
  final String unit;
  final String? customUnit;
  final int unitPriceMinor;
  final int lineTotalMinor;
  final int position;
  const InvoiceItemRow({
    required this.id,
    required this.invoiceId,
    this.serviceId,
    required this.name,
    required this.description,
    required this.quantityMilli,
    required this.unit,
    this.customUnit,
    required this.unitPriceMinor,
    required this.lineTotalMinor,
    required this.position,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    if (!nullToAbsent || serviceId != null) {
      map['service_id'] = Variable<String>(serviceId);
    }
    map['name'] = Variable<String>(name);
    map['description'] = Variable<String>(description);
    map['quantity_milli'] = Variable<int>(quantityMilli);
    map['unit'] = Variable<String>(unit);
    if (!nullToAbsent || customUnit != null) {
      map['custom_unit'] = Variable<String>(customUnit);
    }
    map['unit_price_minor'] = Variable<int>(unitPriceMinor);
    map['line_total_minor'] = Variable<int>(lineTotalMinor);
    map['position'] = Variable<int>(position);
    return map;
  }

  InvoiceItemsCompanion toCompanion(bool nullToAbsent) {
    return InvoiceItemsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      serviceId: serviceId == null && nullToAbsent
          ? const Value.absent()
          : Value(serviceId),
      name: Value(name),
      description: Value(description),
      quantityMilli: Value(quantityMilli),
      unit: Value(unit),
      customUnit: customUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(customUnit),
      unitPriceMinor: Value(unitPriceMinor),
      lineTotalMinor: Value(lineTotalMinor),
      position: Value(position),
    );
  }

  factory InvoiceItemRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InvoiceItemRow(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      serviceId: serializer.fromJson<String?>(json['serviceId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String>(json['description']),
      quantityMilli: serializer.fromJson<int>(json['quantityMilli']),
      unit: serializer.fromJson<String>(json['unit']),
      customUnit: serializer.fromJson<String?>(json['customUnit']),
      unitPriceMinor: serializer.fromJson<int>(json['unitPriceMinor']),
      lineTotalMinor: serializer.fromJson<int>(json['lineTotalMinor']),
      position: serializer.fromJson<int>(json['position']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'serviceId': serializer.toJson<String?>(serviceId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String>(description),
      'quantityMilli': serializer.toJson<int>(quantityMilli),
      'unit': serializer.toJson<String>(unit),
      'customUnit': serializer.toJson<String?>(customUnit),
      'unitPriceMinor': serializer.toJson<int>(unitPriceMinor),
      'lineTotalMinor': serializer.toJson<int>(lineTotalMinor),
      'position': serializer.toJson<int>(position),
    };
  }

  InvoiceItemRow copyWith({
    String? id,
    String? invoiceId,
    Value<String?> serviceId = const Value.absent(),
    String? name,
    String? description,
    int? quantityMilli,
    String? unit,
    Value<String?> customUnit = const Value.absent(),
    int? unitPriceMinor,
    int? lineTotalMinor,
    int? position,
  }) => InvoiceItemRow(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    serviceId: serviceId.present ? serviceId.value : this.serviceId,
    name: name ?? this.name,
    description: description ?? this.description,
    quantityMilli: quantityMilli ?? this.quantityMilli,
    unit: unit ?? this.unit,
    customUnit: customUnit.present ? customUnit.value : this.customUnit,
    unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
    lineTotalMinor: lineTotalMinor ?? this.lineTotalMinor,
    position: position ?? this.position,
  );
  InvoiceItemRow copyWithCompanion(InvoiceItemsCompanion data) {
    return InvoiceItemRow(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      serviceId: data.serviceId.present ? data.serviceId.value : this.serviceId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      quantityMilli: data.quantityMilli.present
          ? data.quantityMilli.value
          : this.quantityMilli,
      unit: data.unit.present ? data.unit.value : this.unit,
      customUnit: data.customUnit.present
          ? data.customUnit.value
          : this.customUnit,
      unitPriceMinor: data.unitPriceMinor.present
          ? data.unitPriceMinor.value
          : this.unitPriceMinor,
      lineTotalMinor: data.lineTotalMinor.present
          ? data.lineTotalMinor.value
          : this.lineTotalMinor,
      position: data.position.present ? data.position.value : this.position,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemRow(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('serviceId: $serviceId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('quantityMilli: $quantityMilli, ')
          ..write('unit: $unit, ')
          ..write('customUnit: $customUnit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('lineTotalMinor: $lineTotalMinor, ')
          ..write('position: $position')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    serviceId,
    name,
    description,
    quantityMilli,
    unit,
    customUnit,
    unitPriceMinor,
    lineTotalMinor,
    position,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvoiceItemRow &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.serviceId == this.serviceId &&
          other.name == this.name &&
          other.description == this.description &&
          other.quantityMilli == this.quantityMilli &&
          other.unit == this.unit &&
          other.customUnit == this.customUnit &&
          other.unitPriceMinor == this.unitPriceMinor &&
          other.lineTotalMinor == this.lineTotalMinor &&
          other.position == this.position);
}

class InvoiceItemsCompanion extends UpdateCompanion<InvoiceItemRow> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String?> serviceId;
  final Value<String> name;
  final Value<String> description;
  final Value<int> quantityMilli;
  final Value<String> unit;
  final Value<String?> customUnit;
  final Value<int> unitPriceMinor;
  final Value<int> lineTotalMinor;
  final Value<int> position;
  final Value<int> rowid;
  const InvoiceItemsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.serviceId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.quantityMilli = const Value.absent(),
    this.unit = const Value.absent(),
    this.customUnit = const Value.absent(),
    this.unitPriceMinor = const Value.absent(),
    this.lineTotalMinor = const Value.absent(),
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InvoiceItemsCompanion.insert({
    required String id,
    required String invoiceId,
    this.serviceId = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    required int quantityMilli,
    required String unit,
    this.customUnit = const Value.absent(),
    required int unitPriceMinor,
    required int lineTotalMinor,
    this.position = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       name = Value(name),
       quantityMilli = Value(quantityMilli),
       unit = Value(unit),
       unitPriceMinor = Value(unitPriceMinor),
       lineTotalMinor = Value(lineTotalMinor);
  static Insertable<InvoiceItemRow> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? serviceId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<int>? quantityMilli,
    Expression<String>? unit,
    Expression<String>? customUnit,
    Expression<int>? unitPriceMinor,
    Expression<int>? lineTotalMinor,
    Expression<int>? position,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (serviceId != null) 'service_id': serviceId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (quantityMilli != null) 'quantity_milli': quantityMilli,
      if (unit != null) 'unit': unit,
      if (customUnit != null) 'custom_unit': customUnit,
      if (unitPriceMinor != null) 'unit_price_minor': unitPriceMinor,
      if (lineTotalMinor != null) 'line_total_minor': lineTotalMinor,
      if (position != null) 'position': position,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InvoiceItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String?>? serviceId,
    Value<String>? name,
    Value<String>? description,
    Value<int>? quantityMilli,
    Value<String>? unit,
    Value<String?>? customUnit,
    Value<int>? unitPriceMinor,
    Value<int>? lineTotalMinor,
    Value<int>? position,
    Value<int>? rowid,
  }) {
    return InvoiceItemsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      serviceId: serviceId ?? this.serviceId,
      name: name ?? this.name,
      description: description ?? this.description,
      quantityMilli: quantityMilli ?? this.quantityMilli,
      unit: unit ?? this.unit,
      customUnit: customUnit ?? this.customUnit,
      unitPriceMinor: unitPriceMinor ?? this.unitPriceMinor,
      lineTotalMinor: lineTotalMinor ?? this.lineTotalMinor,
      position: position ?? this.position,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (serviceId.present) {
      map['service_id'] = Variable<String>(serviceId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (quantityMilli.present) {
      map['quantity_milli'] = Variable<int>(quantityMilli.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (customUnit.present) {
      map['custom_unit'] = Variable<String>(customUnit.value);
    }
    if (unitPriceMinor.present) {
      map['unit_price_minor'] = Variable<int>(unitPriceMinor.value);
    }
    if (lineTotalMinor.present) {
      map['line_total_minor'] = Variable<int>(lineTotalMinor.value);
    }
    if (position.present) {
      map['position'] = Variable<int>(position.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InvoiceItemsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('serviceId: $serviceId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('quantityMilli: $quantityMilli, ')
          ..write('unit: $unit, ')
          ..write('customUnit: $customUnit, ')
          ..write('unitPriceMinor: $unitPriceMinor, ')
          ..write('lineTotalMinor: $lineTotalMinor, ')
          ..write('position: $position, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PaymentsTable extends Payments
    with TableInfo<$PaymentsTable, PaymentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _idempotencyKeyMeta = const VerificationMeta(
    'idempotencyKey',
  );
  @override
  late final GeneratedColumn<String> idempotencyKey = GeneratedColumn<String>(
    'idempotency_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paidAtMeta = const VerificationMeta('paidAt');
  @override
  late final GeneratedColumn<DateTime> paidAt = GeneratedColumn<DateTime>(
    'paid_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _methodMeta = const VerificationMeta('method');
  @override
  late final GeneratedColumn<String> method = GeneratedColumn<String>(
    'method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bankAccountIdMeta = const VerificationMeta(
    'bankAccountId',
  );
  @override
  late final GeneratedColumn<String> bankAccountId = GeneratedColumn<String>(
    'bank_account_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES bank_accounts (id)',
    ),
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    idempotencyKey,
    amountMinor,
    paidAt,
    method,
    bankAccountId,
    reference,
    notes,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<PaymentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('idempotency_key')) {
      context.handle(
        _idempotencyKeyMeta,
        idempotencyKey.isAcceptableOrUnknown(
          data['idempotency_key']!,
          _idempotencyKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotencyKeyMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('paid_at')) {
      context.handle(
        _paidAtMeta,
        paidAt.isAcceptableOrUnknown(data['paid_at']!, _paidAtMeta),
      );
    } else if (isInserting) {
      context.missing(_paidAtMeta);
    }
    if (data.containsKey('method')) {
      context.handle(
        _methodMeta,
        method.isAcceptableOrUnknown(data['method']!, _methodMeta),
      );
    } else if (isInserting) {
      context.missing(_methodMeta);
    }
    if (data.containsKey('bank_account_id')) {
      context.handle(
        _bankAccountIdMeta,
        bankAccountId.isAcceptableOrUnknown(
          data['bank_account_id']!,
          _bankAccountIdMeta,
        ),
      );
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PaymentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PaymentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      idempotencyKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotency_key'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      paidAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}paid_at'],
      )!,
      method: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}method'],
      )!,
      bankAccountId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}bank_account_id'],
      ),
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PaymentsTable createAlias(String alias) {
    return $PaymentsTable(attachedDatabase, alias);
  }
}

class PaymentRow extends DataClass implements Insertable<PaymentRow> {
  final String id;
  final String invoiceId;
  final String idempotencyKey;
  final int amountMinor;
  final DateTime paidAt;
  final String method;
  final String? bankAccountId;
  final String? reference;
  final String? notes;
  final DateTime createdAt;
  const PaymentRow({
    required this.id,
    required this.invoiceId,
    required this.idempotencyKey,
    required this.amountMinor,
    required this.paidAt,
    required this.method,
    this.bankAccountId,
    this.reference,
    this.notes,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['idempotency_key'] = Variable<String>(idempotencyKey);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['paid_at'] = Variable<DateTime>(paidAt);
    map['method'] = Variable<String>(method);
    if (!nullToAbsent || bankAccountId != null) {
      map['bank_account_id'] = Variable<String>(bankAccountId);
    }
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PaymentsCompanion toCompanion(bool nullToAbsent) {
    return PaymentsCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      idempotencyKey: Value(idempotencyKey),
      amountMinor: Value(amountMinor),
      paidAt: Value(paidAt),
      method: Value(method),
      bankAccountId: bankAccountId == null && nullToAbsent
          ? const Value.absent()
          : Value(bankAccountId),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      createdAt: Value(createdAt),
    );
  }

  factory PaymentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PaymentRow(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      idempotencyKey: serializer.fromJson<String>(json['idempotencyKey']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      paidAt: serializer.fromJson<DateTime>(json['paidAt']),
      method: serializer.fromJson<String>(json['method']),
      bankAccountId: serializer.fromJson<String?>(json['bankAccountId']),
      reference: serializer.fromJson<String?>(json['reference']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'idempotencyKey': serializer.toJson<String>(idempotencyKey),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'paidAt': serializer.toJson<DateTime>(paidAt),
      'method': serializer.toJson<String>(method),
      'bankAccountId': serializer.toJson<String?>(bankAccountId),
      'reference': serializer.toJson<String?>(reference),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PaymentRow copyWith({
    String? id,
    String? invoiceId,
    String? idempotencyKey,
    int? amountMinor,
    DateTime? paidAt,
    String? method,
    Value<String?> bankAccountId = const Value.absent(),
    Value<String?> reference = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    DateTime? createdAt,
  }) => PaymentRow(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    amountMinor: amountMinor ?? this.amountMinor,
    paidAt: paidAt ?? this.paidAt,
    method: method ?? this.method,
    bankAccountId: bankAccountId.present
        ? bankAccountId.value
        : this.bankAccountId,
    reference: reference.present ? reference.value : this.reference,
    notes: notes.present ? notes.value : this.notes,
    createdAt: createdAt ?? this.createdAt,
  );
  PaymentRow copyWithCompanion(PaymentsCompanion data) {
    return PaymentRow(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      idempotencyKey: data.idempotencyKey.present
          ? data.idempotencyKey.value
          : this.idempotencyKey,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      paidAt: data.paidAt.present ? data.paidAt.value : this.paidAt,
      method: data.method.present ? data.method.value : this.method,
      bankAccountId: data.bankAccountId.present
          ? data.bankAccountId.value
          : this.bankAccountId,
      reference: data.reference.present ? data.reference.value : this.reference,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PaymentRow(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('paidAt: $paidAt, ')
          ..write('method: $method, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    idempotencyKey,
    amountMinor,
    paidAt,
    method,
    bankAccountId,
    reference,
    notes,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PaymentRow &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.idempotencyKey == this.idempotencyKey &&
          other.amountMinor == this.amountMinor &&
          other.paidAt == this.paidAt &&
          other.method == this.method &&
          other.bankAccountId == this.bankAccountId &&
          other.reference == this.reference &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt);
}

class PaymentsCompanion extends UpdateCompanion<PaymentRow> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String> idempotencyKey;
  final Value<int> amountMinor;
  final Value<DateTime> paidAt;
  final Value<String> method;
  final Value<String?> bankAccountId;
  final Value<String?> reference;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const PaymentsCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.idempotencyKey = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.paidAt = const Value.absent(),
    this.method = const Value.absent(),
    this.bankAccountId = const Value.absent(),
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PaymentsCompanion.insert({
    required String id,
    required String invoiceId,
    required String idempotencyKey,
    required int amountMinor,
    required DateTime paidAt,
    required String method,
    this.bankAccountId = const Value.absent(),
    this.reference = const Value.absent(),
    this.notes = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       idempotencyKey = Value(idempotencyKey),
       amountMinor = Value(amountMinor),
       paidAt = Value(paidAt),
       method = Value(method),
       createdAt = Value(createdAt);
  static Insertable<PaymentRow> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? idempotencyKey,
    Expression<int>? amountMinor,
    Expression<DateTime>? paidAt,
    Expression<String>? method,
    Expression<String>? bankAccountId,
    Expression<String>? reference,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (idempotencyKey != null) 'idempotency_key': idempotencyKey,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (paidAt != null) 'paid_at': paidAt,
      if (method != null) 'method': method,
      if (bankAccountId != null) 'bank_account_id': bankAccountId,
      if (reference != null) 'reference': reference,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String>? idempotencyKey,
    Value<int>? amountMinor,
    Value<DateTime>? paidAt,
    Value<String>? method,
    Value<String?>? bankAccountId,
    Value<String?>? reference,
    Value<String?>? notes,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PaymentsCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      amountMinor: amountMinor ?? this.amountMinor,
      paidAt: paidAt ?? this.paidAt,
      method: method ?? this.method,
      bankAccountId: bankAccountId ?? this.bankAccountId,
      reference: reference ?? this.reference,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (idempotencyKey.present) {
      map['idempotency_key'] = Variable<String>(idempotencyKey.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (paidAt.present) {
      map['paid_at'] = Variable<DateTime>(paidAt.value);
    }
    if (method.present) {
      map['method'] = Variable<String>(method.value);
    }
    if (bankAccountId.present) {
      map['bank_account_id'] = Variable<String>(bankAccountId.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PaymentsCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('idempotencyKey: $idempotencyKey, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('paidAt: $paidAt, ')
          ..write('method: $method, ')
          ..write('bankAccountId: $bankAccountId, ')
          ..write('reference: $reference, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReceiptsTable extends Receipts
    with TableInfo<$ReceiptsTable, ReceiptRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReceiptsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numberMeta = const VerificationMeta('number');
  @override
  late final GeneratedColumn<String> number = GeneratedColumn<String>(
    'number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _paymentIdMeta = const VerificationMeta(
    'paymentId',
  );
  @override
  late final GeneratedColumn<String> paymentId = GeneratedColumn<String>(
    'payment_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'UNIQUE REFERENCES payments (id)',
    ),
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id)',
    ),
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _remainingMinorMeta = const VerificationMeta(
    'remainingMinor',
  );
  @override
  late final GeneratedColumn<int> remainingMinor = GeneratedColumn<int>(
    'remaining_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _markerMeta = const VerificationMeta('marker');
  @override
  late final GeneratedColumn<String> marker = GeneratedColumn<String>(
    'marker',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _snapshotMeta = const VerificationMeta(
    'snapshot',
  );
  @override
  late final GeneratedColumn<String> snapshot = GeneratedColumn<String>(
    'snapshot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAt = GeneratedColumn<DateTime>(
    'issued_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    number,
    paymentId,
    invoiceId,
    amountMinor,
    remainingMinor,
    marker,
    snapshot,
    issuedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'receipts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReceiptRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('number')) {
      context.handle(
        _numberMeta,
        number.isAcceptableOrUnknown(data['number']!, _numberMeta),
      );
    } else if (isInserting) {
      context.missing(_numberMeta);
    }
    if (data.containsKey('payment_id')) {
      context.handle(
        _paymentIdMeta,
        paymentId.isAcceptableOrUnknown(data['payment_id']!, _paymentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_paymentIdMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('remaining_minor')) {
      context.handle(
        _remainingMinorMeta,
        remainingMinor.isAcceptableOrUnknown(
          data['remaining_minor']!,
          _remainingMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_remainingMinorMeta);
    }
    if (data.containsKey('marker')) {
      context.handle(
        _markerMeta,
        marker.isAcceptableOrUnknown(data['marker']!, _markerMeta),
      );
    } else if (isInserting) {
      context.missing(_markerMeta);
    }
    if (data.containsKey('snapshot')) {
      context.handle(
        _snapshotMeta,
        snapshot.isAcceptableOrUnknown(data['snapshot']!, _snapshotMeta),
      );
    } else if (isInserting) {
      context.missing(_snapshotMeta);
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_issuedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReceiptRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReceiptRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      number: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}number'],
      )!,
      paymentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      remainingMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remaining_minor'],
      )!,
      marker: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marker'],
      )!,
      snapshot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}snapshot'],
      )!,
      issuedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at'],
      )!,
    );
  }

  @override
  $ReceiptsTable createAlias(String alias) {
    return $ReceiptsTable(attachedDatabase, alias);
  }
}

class ReceiptRow extends DataClass implements Insertable<ReceiptRow> {
  final String id;
  final String number;
  final String paymentId;
  final String invoiceId;
  final int amountMinor;
  final int remainingMinor;
  final String marker;
  final String snapshot;
  final DateTime issuedAt;
  const ReceiptRow({
    required this.id,
    required this.number,
    required this.paymentId,
    required this.invoiceId,
    required this.amountMinor,
    required this.remainingMinor,
    required this.marker,
    required this.snapshot,
    required this.issuedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['number'] = Variable<String>(number);
    map['payment_id'] = Variable<String>(paymentId);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['amount_minor'] = Variable<int>(amountMinor);
    map['remaining_minor'] = Variable<int>(remainingMinor);
    map['marker'] = Variable<String>(marker);
    map['snapshot'] = Variable<String>(snapshot);
    map['issued_at'] = Variable<DateTime>(issuedAt);
    return map;
  }

  ReceiptsCompanion toCompanion(bool nullToAbsent) {
    return ReceiptsCompanion(
      id: Value(id),
      number: Value(number),
      paymentId: Value(paymentId),
      invoiceId: Value(invoiceId),
      amountMinor: Value(amountMinor),
      remainingMinor: Value(remainingMinor),
      marker: Value(marker),
      snapshot: Value(snapshot),
      issuedAt: Value(issuedAt),
    );
  }

  factory ReceiptRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReceiptRow(
      id: serializer.fromJson<String>(json['id']),
      number: serializer.fromJson<String>(json['number']),
      paymentId: serializer.fromJson<String>(json['paymentId']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      remainingMinor: serializer.fromJson<int>(json['remainingMinor']),
      marker: serializer.fromJson<String>(json['marker']),
      snapshot: serializer.fromJson<String>(json['snapshot']),
      issuedAt: serializer.fromJson<DateTime>(json['issuedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'number': serializer.toJson<String>(number),
      'paymentId': serializer.toJson<String>(paymentId),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'remainingMinor': serializer.toJson<int>(remainingMinor),
      'marker': serializer.toJson<String>(marker),
      'snapshot': serializer.toJson<String>(snapshot),
      'issuedAt': serializer.toJson<DateTime>(issuedAt),
    };
  }

  ReceiptRow copyWith({
    String? id,
    String? number,
    String? paymentId,
    String? invoiceId,
    int? amountMinor,
    int? remainingMinor,
    String? marker,
    String? snapshot,
    DateTime? issuedAt,
  }) => ReceiptRow(
    id: id ?? this.id,
    number: number ?? this.number,
    paymentId: paymentId ?? this.paymentId,
    invoiceId: invoiceId ?? this.invoiceId,
    amountMinor: amountMinor ?? this.amountMinor,
    remainingMinor: remainingMinor ?? this.remainingMinor,
    marker: marker ?? this.marker,
    snapshot: snapshot ?? this.snapshot,
    issuedAt: issuedAt ?? this.issuedAt,
  );
  ReceiptRow copyWithCompanion(ReceiptsCompanion data) {
    return ReceiptRow(
      id: data.id.present ? data.id.value : this.id,
      number: data.number.present ? data.number.value : this.number,
      paymentId: data.paymentId.present ? data.paymentId.value : this.paymentId,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      remainingMinor: data.remainingMinor.present
          ? data.remainingMinor.value
          : this.remainingMinor,
      marker: data.marker.present ? data.marker.value : this.marker,
      snapshot: data.snapshot.present ? data.snapshot.value : this.snapshot,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptRow(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('remainingMinor: $remainingMinor, ')
          ..write('marker: $marker, ')
          ..write('snapshot: $snapshot, ')
          ..write('issuedAt: $issuedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    number,
    paymentId,
    invoiceId,
    amountMinor,
    remainingMinor,
    marker,
    snapshot,
    issuedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReceiptRow &&
          other.id == this.id &&
          other.number == this.number &&
          other.paymentId == this.paymentId &&
          other.invoiceId == this.invoiceId &&
          other.amountMinor == this.amountMinor &&
          other.remainingMinor == this.remainingMinor &&
          other.marker == this.marker &&
          other.snapshot == this.snapshot &&
          other.issuedAt == this.issuedAt);
}

class ReceiptsCompanion extends UpdateCompanion<ReceiptRow> {
  final Value<String> id;
  final Value<String> number;
  final Value<String> paymentId;
  final Value<String> invoiceId;
  final Value<int> amountMinor;
  final Value<int> remainingMinor;
  final Value<String> marker;
  final Value<String> snapshot;
  final Value<DateTime> issuedAt;
  final Value<int> rowid;
  const ReceiptsCompanion({
    this.id = const Value.absent(),
    this.number = const Value.absent(),
    this.paymentId = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.remainingMinor = const Value.absent(),
    this.marker = const Value.absent(),
    this.snapshot = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ReceiptsCompanion.insert({
    required String id,
    required String number,
    required String paymentId,
    required String invoiceId,
    required int amountMinor,
    required int remainingMinor,
    required String marker,
    required String snapshot,
    required DateTime issuedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       number = Value(number),
       paymentId = Value(paymentId),
       invoiceId = Value(invoiceId),
       amountMinor = Value(amountMinor),
       remainingMinor = Value(remainingMinor),
       marker = Value(marker),
       snapshot = Value(snapshot),
       issuedAt = Value(issuedAt);
  static Insertable<ReceiptRow> custom({
    Expression<String>? id,
    Expression<String>? number,
    Expression<String>? paymentId,
    Expression<String>? invoiceId,
    Expression<int>? amountMinor,
    Expression<int>? remainingMinor,
    Expression<String>? marker,
    Expression<String>? snapshot,
    Expression<DateTime>? issuedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (number != null) 'number': number,
      if (paymentId != null) 'payment_id': paymentId,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (remainingMinor != null) 'remaining_minor': remainingMinor,
      if (marker != null) 'marker': marker,
      if (snapshot != null) 'snapshot': snapshot,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ReceiptsCompanion copyWith({
    Value<String>? id,
    Value<String>? number,
    Value<String>? paymentId,
    Value<String>? invoiceId,
    Value<int>? amountMinor,
    Value<int>? remainingMinor,
    Value<String>? marker,
    Value<String>? snapshot,
    Value<DateTime>? issuedAt,
    Value<int>? rowid,
  }) {
    return ReceiptsCompanion(
      id: id ?? this.id,
      number: number ?? this.number,
      paymentId: paymentId ?? this.paymentId,
      invoiceId: invoiceId ?? this.invoiceId,
      amountMinor: amountMinor ?? this.amountMinor,
      remainingMinor: remainingMinor ?? this.remainingMinor,
      marker: marker ?? this.marker,
      snapshot: snapshot ?? this.snapshot,
      issuedAt: issuedAt ?? this.issuedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (number.present) {
      map['number'] = Variable<String>(number.value);
    }
    if (paymentId.present) {
      map['payment_id'] = Variable<String>(paymentId.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (remainingMinor.present) {
      map['remaining_minor'] = Variable<int>(remainingMinor.value);
    }
    if (marker.present) {
      map['marker'] = Variable<String>(marker.value);
    }
    if (snapshot.present) {
      map['snapshot'] = Variable<String>(snapshot.value);
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<DateTime>(issuedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReceiptsCompanion(')
          ..write('id: $id, ')
          ..write('number: $number, ')
          ..write('paymentId: $paymentId, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('remainingMinor: $remainingMinor, ')
          ..write('marker: $marker, ')
          ..write('snapshot: $snapshot, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, ReminderRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _invoiceIdMeta = const VerificationMeta(
    'invoiceId',
  );
  @override
  late final GeneratedColumn<String> invoiceId = GeneratedColumn<String>(
    'invoice_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES invoices (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _kindMeta = const VerificationMeta('kind');
  @override
  late final GeneratedColumn<String> kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notificationIdMeta = const VerificationMeta(
    'notificationId',
  );
  @override
  late final GeneratedColumn<int> notificationId = GeneratedColumn<int>(
    'notification_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sentAtMeta = const VerificationMeta('sentAt');
  @override
  late final GeneratedColumn<DateTime> sentAt = GeneratedColumn<DateTime>(
    'sent_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _messageMeta = const VerificationMeta(
    'message',
  );
  @override
  late final GeneratedColumn<String> message = GeneratedColumn<String>(
    'message',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    invoiceId,
    kind,
    scheduledAt,
    notificationId,
    status,
    sentAt,
    message,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReminderRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('invoice_id')) {
      context.handle(
        _invoiceIdMeta,
        invoiceId.isAcceptableOrUnknown(data['invoice_id']!, _invoiceIdMeta),
      );
    } else if (isInserting) {
      context.missing(_invoiceIdMeta);
    }
    if (data.containsKey('kind')) {
      context.handle(
        _kindMeta,
        kind.isAcceptableOrUnknown(data['kind']!, _kindMeta),
      );
    } else if (isInserting) {
      context.missing(_kindMeta);
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_scheduledAtMeta);
    }
    if (data.containsKey('notification_id')) {
      context.handle(
        _notificationIdMeta,
        notificationId.isAcceptableOrUnknown(
          data['notification_id']!,
          _notificationIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_notificationIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('sent_at')) {
      context.handle(
        _sentAtMeta,
        sentAt.isAcceptableOrUnknown(data['sent_at']!, _sentAtMeta),
      );
    }
    if (data.containsKey('message')) {
      context.handle(
        _messageMeta,
        message.isAcceptableOrUnknown(data['message']!, _messageMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReminderRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReminderRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      invoiceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_id'],
      )!,
      kind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kind'],
      )!,
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      )!,
      notificationId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}notification_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      sentAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sent_at'],
      ),
      message: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}message'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }
}

class ReminderRow extends DataClass implements Insertable<ReminderRow> {
  final String id;
  final String invoiceId;
  final String kind;
  final DateTime scheduledAt;
  final int notificationId;
  final String status;
  final DateTime? sentAt;
  final String? message;
  final DateTime createdAt;
  const ReminderRow({
    required this.id,
    required this.invoiceId,
    required this.kind,
    required this.scheduledAt,
    required this.notificationId,
    required this.status,
    this.sentAt,
    this.message,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['invoice_id'] = Variable<String>(invoiceId);
    map['kind'] = Variable<String>(kind);
    map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    map['notification_id'] = Variable<int>(notificationId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || sentAt != null) {
      map['sent_at'] = Variable<DateTime>(sentAt);
    }
    if (!nullToAbsent || message != null) {
      map['message'] = Variable<String>(message);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      invoiceId: Value(invoiceId),
      kind: Value(kind),
      scheduledAt: Value(scheduledAt),
      notificationId: Value(notificationId),
      status: Value(status),
      sentAt: sentAt == null && nullToAbsent
          ? const Value.absent()
          : Value(sentAt),
      message: message == null && nullToAbsent
          ? const Value.absent()
          : Value(message),
      createdAt: Value(createdAt),
    );
  }

  factory ReminderRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReminderRow(
      id: serializer.fromJson<String>(json['id']),
      invoiceId: serializer.fromJson<String>(json['invoiceId']),
      kind: serializer.fromJson<String>(json['kind']),
      scheduledAt: serializer.fromJson<DateTime>(json['scheduledAt']),
      notificationId: serializer.fromJson<int>(json['notificationId']),
      status: serializer.fromJson<String>(json['status']),
      sentAt: serializer.fromJson<DateTime?>(json['sentAt']),
      message: serializer.fromJson<String?>(json['message']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'invoiceId': serializer.toJson<String>(invoiceId),
      'kind': serializer.toJson<String>(kind),
      'scheduledAt': serializer.toJson<DateTime>(scheduledAt),
      'notificationId': serializer.toJson<int>(notificationId),
      'status': serializer.toJson<String>(status),
      'sentAt': serializer.toJson<DateTime?>(sentAt),
      'message': serializer.toJson<String?>(message),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  ReminderRow copyWith({
    String? id,
    String? invoiceId,
    String? kind,
    DateTime? scheduledAt,
    int? notificationId,
    String? status,
    Value<DateTime?> sentAt = const Value.absent(),
    Value<String?> message = const Value.absent(),
    DateTime? createdAt,
  }) => ReminderRow(
    id: id ?? this.id,
    invoiceId: invoiceId ?? this.invoiceId,
    kind: kind ?? this.kind,
    scheduledAt: scheduledAt ?? this.scheduledAt,
    notificationId: notificationId ?? this.notificationId,
    status: status ?? this.status,
    sentAt: sentAt.present ? sentAt.value : this.sentAt,
    message: message.present ? message.value : this.message,
    createdAt: createdAt ?? this.createdAt,
  );
  ReminderRow copyWithCompanion(RemindersCompanion data) {
    return ReminderRow(
      id: data.id.present ? data.id.value : this.id,
      invoiceId: data.invoiceId.present ? data.invoiceId.value : this.invoiceId,
      kind: data.kind.present ? data.kind.value : this.kind,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      notificationId: data.notificationId.present
          ? data.notificationId.value
          : this.notificationId,
      status: data.status.present ? data.status.value : this.status,
      sentAt: data.sentAt.present ? data.sentAt.value : this.sentAt,
      message: data.message.present ? data.message.value : this.message,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReminderRow(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('kind: $kind, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('notificationId: $notificationId, ')
          ..write('status: $status, ')
          ..write('sentAt: $sentAt, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    invoiceId,
    kind,
    scheduledAt,
    notificationId,
    status,
    sentAt,
    message,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReminderRow &&
          other.id == this.id &&
          other.invoiceId == this.invoiceId &&
          other.kind == this.kind &&
          other.scheduledAt == this.scheduledAt &&
          other.notificationId == this.notificationId &&
          other.status == this.status &&
          other.sentAt == this.sentAt &&
          other.message == this.message &&
          other.createdAt == this.createdAt);
}

class RemindersCompanion extends UpdateCompanion<ReminderRow> {
  final Value<String> id;
  final Value<String> invoiceId;
  final Value<String> kind;
  final Value<DateTime> scheduledAt;
  final Value<int> notificationId;
  final Value<String> status;
  final Value<DateTime?> sentAt;
  final Value<String?> message;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.invoiceId = const Value.absent(),
    this.kind = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.notificationId = const Value.absent(),
    this.status = const Value.absent(),
    this.sentAt = const Value.absent(),
    this.message = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required String invoiceId,
    required String kind,
    required DateTime scheduledAt,
    required int notificationId,
    required String status,
    this.sentAt = const Value.absent(),
    this.message = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       invoiceId = Value(invoiceId),
       kind = Value(kind),
       scheduledAt = Value(scheduledAt),
       notificationId = Value(notificationId),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<ReminderRow> custom({
    Expression<String>? id,
    Expression<String>? invoiceId,
    Expression<String>? kind,
    Expression<DateTime>? scheduledAt,
    Expression<int>? notificationId,
    Expression<String>? status,
    Expression<DateTime>? sentAt,
    Expression<String>? message,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (invoiceId != null) 'invoice_id': invoiceId,
      if (kind != null) 'kind': kind,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (notificationId != null) 'notification_id': notificationId,
      if (status != null) 'status': status,
      if (sentAt != null) 'sent_at': sentAt,
      if (message != null) 'message': message,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<String>? invoiceId,
    Value<String>? kind,
    Value<DateTime>? scheduledAt,
    Value<int>? notificationId,
    Value<String>? status,
    Value<DateTime?>? sentAt,
    Value<String?>? message,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      invoiceId: invoiceId ?? this.invoiceId,
      kind: kind ?? this.kind,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      notificationId: notificationId ?? this.notificationId,
      status: status ?? this.status,
      sentAt: sentAt ?? this.sentAt,
      message: message ?? this.message,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (invoiceId.present) {
      map['invoice_id'] = Variable<String>(invoiceId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(kind.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (notificationId.present) {
      map['notification_id'] = Variable<int>(notificationId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (sentAt.present) {
      map['sent_at'] = Variable<DateTime>(sentAt.value);
    }
    if (message.present) {
      map['message'] = Variable<String>(message.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('invoiceId: $invoiceId, ')
          ..write('kind: $kind, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('notificationId: $notificationId, ')
          ..write('status: $status, ')
          ..write('sentAt: $sentAt, ')
          ..write('message: $message, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MessageTemplatesTable extends MessageTemplates
    with TableInfo<$MessageTemplatesTable, MessageTemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MessageTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    name,
    body,
    isDefault,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'message_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<MessageTemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MessageTemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MessageTemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MessageTemplatesTable createAlias(String alias) {
    return $MessageTemplatesTable(attachedDatabase, alias);
  }
}

class MessageTemplateRow extends DataClass
    implements Insertable<MessageTemplateRow> {
  final String id;
  final String type;
  final String name;
  final String body;
  final bool isDefault;
  final DateTime updatedAt;
  const MessageTemplateRow({
    required this.id,
    required this.type,
    required this.name,
    required this.body,
    required this.isDefault,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['type'] = Variable<String>(type);
    map['name'] = Variable<String>(name);
    map['body'] = Variable<String>(body);
    map['is_default'] = Variable<bool>(isDefault);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MessageTemplatesCompanion toCompanion(bool nullToAbsent) {
    return MessageTemplatesCompanion(
      id: Value(id),
      type: Value(type),
      name: Value(name),
      body: Value(body),
      isDefault: Value(isDefault),
      updatedAt: Value(updatedAt),
    );
  }

  factory MessageTemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MessageTemplateRow(
      id: serializer.fromJson<String>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      name: serializer.fromJson<String>(json['name']),
      body: serializer.fromJson<String>(json['body']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(type),
      'name': serializer.toJson<String>(name),
      'body': serializer.toJson<String>(body),
      'isDefault': serializer.toJson<bool>(isDefault),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MessageTemplateRow copyWith({
    String? id,
    String? type,
    String? name,
    String? body,
    bool? isDefault,
    DateTime? updatedAt,
  }) => MessageTemplateRow(
    id: id ?? this.id,
    type: type ?? this.type,
    name: name ?? this.name,
    body: body ?? this.body,
    isDefault: isDefault ?? this.isDefault,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MessageTemplateRow copyWithCompanion(MessageTemplatesCompanion data) {
    return MessageTemplateRow(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      name: data.name.present ? data.name.value : this.name,
      body: data.body.present ? data.body.value : this.body,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MessageTemplateRow(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('body: $body, ')
          ..write('isDefault: $isDefault, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, name, body, isDefault, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MessageTemplateRow &&
          other.id == this.id &&
          other.type == this.type &&
          other.name == this.name &&
          other.body == this.body &&
          other.isDefault == this.isDefault &&
          other.updatedAt == this.updatedAt);
}

class MessageTemplatesCompanion extends UpdateCompanion<MessageTemplateRow> {
  final Value<String> id;
  final Value<String> type;
  final Value<String> name;
  final Value<String> body;
  final Value<bool> isDefault;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MessageTemplatesCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.name = const Value.absent(),
    this.body = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MessageTemplatesCompanion.insert({
    required String id,
    required String type,
    required String name,
    required String body,
    this.isDefault = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       name = Value(name),
       body = Value(body),
       updatedAt = Value(updatedAt);
  static Insertable<MessageTemplateRow> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<String>? name,
    Expression<String>? body,
    Expression<bool>? isDefault,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (name != null) 'name': name,
      if (body != null) 'body': body,
      if (isDefault != null) 'is_default': isDefault,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MessageTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? type,
    Value<String>? name,
    Value<String>? body,
    Value<bool>? isDefault,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MessageTemplatesCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      body: body ?? this.body,
      isDefault: isDefault ?? this.isDefault,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MessageTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('name: $name, ')
          ..write('body: $body, ')
          ..write('isDefault: $isDefault, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSettingRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _onboardingCompleteMeta =
      const VerificationMeta('onboardingComplete');
  @override
  late final GeneratedColumn<bool> onboardingComplete = GeneratedColumn<bool>(
    'onboarding_complete',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("onboarding_complete" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _invoicePrefixMeta = const VerificationMeta(
    'invoicePrefix',
  );
  @override
  late final GeneratedColumn<String> invoicePrefix = GeneratedColumn<String>(
    'invoice_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('INV'),
  );
  static const VerificationMeta _nextInvoiceSequenceMeta =
      const VerificationMeta('nextInvoiceSequence');
  @override
  late final GeneratedColumn<int> nextInvoiceSequence = GeneratedColumn<int>(
    'next_invoice_sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _receiptPrefixMeta = const VerificationMeta(
    'receiptPrefix',
  );
  @override
  late final GeneratedColumn<String> receiptPrefix = GeneratedColumn<String>(
    'receipt_prefix',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('RCT'),
  );
  static const VerificationMeta _nextReceiptSequenceMeta =
      const VerificationMeta('nextReceiptSequence');
  @override
  late final GeneratedColumn<int> nextReceiptSequence = GeneratedColumn<int>(
    'next_receipt_sequence',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _numberPaddingMeta = const VerificationMeta(
    'numberPadding',
  );
  @override
  late final GeneratedColumn<int> numberPadding = GeneratedColumn<int>(
    'number_padding',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(4),
  );
  static const VerificationMeta _defaultCurrencyMeta = const VerificationMeta(
    'defaultCurrency',
  );
  @override
  late final GeneratedColumn<String> defaultCurrency = GeneratedColumn<String>(
    'default_currency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('NGN'),
  );
  static const VerificationMeta _taxEnabledMeta = const VerificationMeta(
    'taxEnabled',
  );
  @override
  late final GeneratedColumn<bool> taxEnabled = GeneratedColumn<bool>(
    'tax_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("tax_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _defaultTaxRateBpsMeta = const VerificationMeta(
    'defaultTaxRateBps',
  );
  @override
  late final GeneratedColumn<int> defaultTaxRateBps = GeneratedColumn<int>(
    'default_tax_rate_bps',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _defaultTermsPresetMeta =
      const VerificationMeta('defaultTermsPreset');
  @override
  late final GeneratedColumn<String> defaultTermsPreset =
      GeneratedColumn<String>(
        'default_terms_preset',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('days7'),
      );
  static const VerificationMeta _defaultDueDaysMeta = const VerificationMeta(
    'defaultDueDays',
  );
  @override
  late final GeneratedColumn<int> defaultDueDays = GeneratedColumn<int>(
    'default_due_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(7),
  );
  static const VerificationMeta _defaultNotesMeta = const VerificationMeta(
    'defaultNotes',
  );
  @override
  late final GeneratedColumn<String> defaultNotes = GeneratedColumn<String>(
    'default_notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _defaultPaymentInstructionsMeta =
      const VerificationMeta('defaultPaymentInstructions');
  @override
  late final GeneratedColumn<String> defaultPaymentInstructions =
      GeneratedColumn<String>(
        'default_payment_instructions',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _notificationsEnabledMeta =
      const VerificationMeta('notificationsEnabled');
  @override
  late final GeneratedColumn<bool> notificationsEnabled = GeneratedColumn<bool>(
    'notifications_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _remindBeforeDaysMeta = const VerificationMeta(
    'remindBeforeDays',
  );
  @override
  late final GeneratedColumn<int> remindBeforeDays = GeneratedColumn<int>(
    'remind_before_days',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _remindOnDueMeta = const VerificationMeta(
    'remindOnDue',
  );
  @override
  late final GeneratedColumn<bool> remindOnDue = GeneratedColumn<bool>(
    'remind_on_due',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remind_on_due" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _remindAfter3Meta = const VerificationMeta(
    'remindAfter3',
  );
  @override
  late final GeneratedColumn<bool> remindAfter3 = GeneratedColumn<bool>(
    'remind_after3',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remind_after3" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _remindAfter7Meta = const VerificationMeta(
    'remindAfter7',
  );
  @override
  late final GeneratedColumn<bool> remindAfter7 = GeneratedColumn<bool>(
    'remind_after7',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("remind_after7" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _pinEnabledMeta = const VerificationMeta(
    'pinEnabled',
  );
  @override
  late final GeneratedColumn<bool> pinEnabled = GeneratedColumn<bool>(
    'pin_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("pin_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _biometricEnabledMeta = const VerificationMeta(
    'biometricEnabled',
  );
  @override
  late final GeneratedColumn<bool> biometricEnabled = GeneratedColumn<bool>(
    'biometric_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("biometric_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _autoLockSecondsMeta = const VerificationMeta(
    'autoLockSeconds',
  );
  @override
  late final GeneratedColumn<int> autoLockSeconds = GeneratedColumn<int>(
    'auto_lock_seconds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(60),
  );
  static const VerificationMeta _protectSensitiveMeta = const VerificationMeta(
    'protectSensitive',
  );
  @override
  late final GeneratedColumn<bool> protectSensitive = GeneratedColumn<bool>(
    'protect_sensitive',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("protect_sensitive" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastBackupAtMeta = const VerificationMeta(
    'lastBackupAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastBackupAt = GeneratedColumn<DateTime>(
    'last_backup_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _paymentMethodsMeta = const VerificationMeta(
    'paymentMethods',
  );
  @override
  late final GeneratedColumn<String> paymentMethods = GeneratedColumn<String>(
    'payment_methods',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('bank_transfer,cash,pos,card,other'),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _insightEnabledMeta = const VerificationMeta(
    'insightEnabled',
  );
  @override
  late final GeneratedColumn<bool> insightEnabled = GeneratedColumn<bool>(
    'insight_enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("insight_enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    onboardingComplete,
    invoicePrefix,
    nextInvoiceSequence,
    receiptPrefix,
    nextReceiptSequence,
    numberPadding,
    defaultCurrency,
    taxEnabled,
    defaultTaxRateBps,
    defaultTermsPreset,
    defaultDueDays,
    defaultNotes,
    defaultPaymentInstructions,
    notificationsEnabled,
    remindBeforeDays,
    remindOnDue,
    remindAfter3,
    remindAfter7,
    pinEnabled,
    biometricEnabled,
    autoLockSeconds,
    protectSensitive,
    lastBackupAt,
    themeMode,
    paymentMethods,
    createdAt,
    updatedAt,
    insightEnabled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSettingRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('onboarding_complete')) {
      context.handle(
        _onboardingCompleteMeta,
        onboardingComplete.isAcceptableOrUnknown(
          data['onboarding_complete']!,
          _onboardingCompleteMeta,
        ),
      );
    }
    if (data.containsKey('invoice_prefix')) {
      context.handle(
        _invoicePrefixMeta,
        invoicePrefix.isAcceptableOrUnknown(
          data['invoice_prefix']!,
          _invoicePrefixMeta,
        ),
      );
    }
    if (data.containsKey('next_invoice_sequence')) {
      context.handle(
        _nextInvoiceSequenceMeta,
        nextInvoiceSequence.isAcceptableOrUnknown(
          data['next_invoice_sequence']!,
          _nextInvoiceSequenceMeta,
        ),
      );
    }
    if (data.containsKey('receipt_prefix')) {
      context.handle(
        _receiptPrefixMeta,
        receiptPrefix.isAcceptableOrUnknown(
          data['receipt_prefix']!,
          _receiptPrefixMeta,
        ),
      );
    }
    if (data.containsKey('next_receipt_sequence')) {
      context.handle(
        _nextReceiptSequenceMeta,
        nextReceiptSequence.isAcceptableOrUnknown(
          data['next_receipt_sequence']!,
          _nextReceiptSequenceMeta,
        ),
      );
    }
    if (data.containsKey('number_padding')) {
      context.handle(
        _numberPaddingMeta,
        numberPadding.isAcceptableOrUnknown(
          data['number_padding']!,
          _numberPaddingMeta,
        ),
      );
    }
    if (data.containsKey('default_currency')) {
      context.handle(
        _defaultCurrencyMeta,
        defaultCurrency.isAcceptableOrUnknown(
          data['default_currency']!,
          _defaultCurrencyMeta,
        ),
      );
    }
    if (data.containsKey('tax_enabled')) {
      context.handle(
        _taxEnabledMeta,
        taxEnabled.isAcceptableOrUnknown(data['tax_enabled']!, _taxEnabledMeta),
      );
    }
    if (data.containsKey('default_tax_rate_bps')) {
      context.handle(
        _defaultTaxRateBpsMeta,
        defaultTaxRateBps.isAcceptableOrUnknown(
          data['default_tax_rate_bps']!,
          _defaultTaxRateBpsMeta,
        ),
      );
    }
    if (data.containsKey('default_terms_preset')) {
      context.handle(
        _defaultTermsPresetMeta,
        defaultTermsPreset.isAcceptableOrUnknown(
          data['default_terms_preset']!,
          _defaultTermsPresetMeta,
        ),
      );
    }
    if (data.containsKey('default_due_days')) {
      context.handle(
        _defaultDueDaysMeta,
        defaultDueDays.isAcceptableOrUnknown(
          data['default_due_days']!,
          _defaultDueDaysMeta,
        ),
      );
    }
    if (data.containsKey('default_notes')) {
      context.handle(
        _defaultNotesMeta,
        defaultNotes.isAcceptableOrUnknown(
          data['default_notes']!,
          _defaultNotesMeta,
        ),
      );
    }
    if (data.containsKey('default_payment_instructions')) {
      context.handle(
        _defaultPaymentInstructionsMeta,
        defaultPaymentInstructions.isAcceptableOrUnknown(
          data['default_payment_instructions']!,
          _defaultPaymentInstructionsMeta,
        ),
      );
    }
    if (data.containsKey('notifications_enabled')) {
      context.handle(
        _notificationsEnabledMeta,
        notificationsEnabled.isAcceptableOrUnknown(
          data['notifications_enabled']!,
          _notificationsEnabledMeta,
        ),
      );
    }
    if (data.containsKey('remind_before_days')) {
      context.handle(
        _remindBeforeDaysMeta,
        remindBeforeDays.isAcceptableOrUnknown(
          data['remind_before_days']!,
          _remindBeforeDaysMeta,
        ),
      );
    }
    if (data.containsKey('remind_on_due')) {
      context.handle(
        _remindOnDueMeta,
        remindOnDue.isAcceptableOrUnknown(
          data['remind_on_due']!,
          _remindOnDueMeta,
        ),
      );
    }
    if (data.containsKey('remind_after3')) {
      context.handle(
        _remindAfter3Meta,
        remindAfter3.isAcceptableOrUnknown(
          data['remind_after3']!,
          _remindAfter3Meta,
        ),
      );
    }
    if (data.containsKey('remind_after7')) {
      context.handle(
        _remindAfter7Meta,
        remindAfter7.isAcceptableOrUnknown(
          data['remind_after7']!,
          _remindAfter7Meta,
        ),
      );
    }
    if (data.containsKey('pin_enabled')) {
      context.handle(
        _pinEnabledMeta,
        pinEnabled.isAcceptableOrUnknown(data['pin_enabled']!, _pinEnabledMeta),
      );
    }
    if (data.containsKey('biometric_enabled')) {
      context.handle(
        _biometricEnabledMeta,
        biometricEnabled.isAcceptableOrUnknown(
          data['biometric_enabled']!,
          _biometricEnabledMeta,
        ),
      );
    }
    if (data.containsKey('auto_lock_seconds')) {
      context.handle(
        _autoLockSecondsMeta,
        autoLockSeconds.isAcceptableOrUnknown(
          data['auto_lock_seconds']!,
          _autoLockSecondsMeta,
        ),
      );
    }
    if (data.containsKey('protect_sensitive')) {
      context.handle(
        _protectSensitiveMeta,
        protectSensitive.isAcceptableOrUnknown(
          data['protect_sensitive']!,
          _protectSensitiveMeta,
        ),
      );
    }
    if (data.containsKey('last_backup_at')) {
      context.handle(
        _lastBackupAtMeta,
        lastBackupAt.isAcceptableOrUnknown(
          data['last_backup_at']!,
          _lastBackupAtMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('payment_methods')) {
      context.handle(
        _paymentMethodsMeta,
        paymentMethods.isAcceptableOrUnknown(
          data['payment_methods']!,
          _paymentMethodsMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('insight_enabled')) {
      context.handle(
        _insightEnabledMeta,
        insightEnabled.isAcceptableOrUnknown(
          data['insight_enabled']!,
          _insightEnabledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AppSettingRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSettingRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      onboardingComplete: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}onboarding_complete'],
      )!,
      invoicePrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}invoice_prefix'],
      )!,
      nextInvoiceSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_invoice_sequence'],
      )!,
      receiptPrefix: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}receipt_prefix'],
      )!,
      nextReceiptSequence: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_receipt_sequence'],
      )!,
      numberPadding: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}number_padding'],
      )!,
      defaultCurrency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_currency'],
      )!,
      taxEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}tax_enabled'],
      )!,
      defaultTaxRateBps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_tax_rate_bps'],
      )!,
      defaultTermsPreset: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_terms_preset'],
      )!,
      defaultDueDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}default_due_days'],
      )!,
      defaultNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_notes'],
      )!,
      defaultPaymentInstructions: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}default_payment_instructions'],
      )!,
      notificationsEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_enabled'],
      )!,
      remindBeforeDays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}remind_before_days'],
      )!,
      remindOnDue: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remind_on_due'],
      )!,
      remindAfter3: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remind_after3'],
      )!,
      remindAfter7: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}remind_after7'],
      )!,
      pinEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}pin_enabled'],
      )!,
      biometricEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}biometric_enabled'],
      )!,
      autoLockSeconds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}auto_lock_seconds'],
      )!,
      protectSensitive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}protect_sensitive'],
      )!,
      lastBackupAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_backup_at'],
      ),
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      paymentMethods: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_methods'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      insightEnabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}insight_enabled'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSettingRow extends DataClass implements Insertable<AppSettingRow> {
  final String id;
  final bool onboardingComplete;
  final String invoicePrefix;
  final int nextInvoiceSequence;
  final String receiptPrefix;
  final int nextReceiptSequence;
  final int numberPadding;
  final String defaultCurrency;
  final bool taxEnabled;
  final int defaultTaxRateBps;
  final String defaultTermsPreset;
  final int defaultDueDays;
  final String defaultNotes;
  final String defaultPaymentInstructions;
  final bool notificationsEnabled;
  final int remindBeforeDays;
  final bool remindOnDue;
  final bool remindAfter3;
  final bool remindAfter7;
  final bool pinEnabled;
  final bool biometricEnabled;
  final int autoLockSeconds;
  final bool protectSensitive;
  final DateTime? lastBackupAt;
  final String themeMode;
  final String paymentMethods;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool insightEnabled;
  const AppSettingRow({
    required this.id,
    required this.onboardingComplete,
    required this.invoicePrefix,
    required this.nextInvoiceSequence,
    required this.receiptPrefix,
    required this.nextReceiptSequence,
    required this.numberPadding,
    required this.defaultCurrency,
    required this.taxEnabled,
    required this.defaultTaxRateBps,
    required this.defaultTermsPreset,
    required this.defaultDueDays,
    required this.defaultNotes,
    required this.defaultPaymentInstructions,
    required this.notificationsEnabled,
    required this.remindBeforeDays,
    required this.remindOnDue,
    required this.remindAfter3,
    required this.remindAfter7,
    required this.pinEnabled,
    required this.biometricEnabled,
    required this.autoLockSeconds,
    required this.protectSensitive,
    this.lastBackupAt,
    required this.themeMode,
    required this.paymentMethods,
    required this.createdAt,
    required this.updatedAt,
    required this.insightEnabled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['onboarding_complete'] = Variable<bool>(onboardingComplete);
    map['invoice_prefix'] = Variable<String>(invoicePrefix);
    map['next_invoice_sequence'] = Variable<int>(nextInvoiceSequence);
    map['receipt_prefix'] = Variable<String>(receiptPrefix);
    map['next_receipt_sequence'] = Variable<int>(nextReceiptSequence);
    map['number_padding'] = Variable<int>(numberPadding);
    map['default_currency'] = Variable<String>(defaultCurrency);
    map['tax_enabled'] = Variable<bool>(taxEnabled);
    map['default_tax_rate_bps'] = Variable<int>(defaultTaxRateBps);
    map['default_terms_preset'] = Variable<String>(defaultTermsPreset);
    map['default_due_days'] = Variable<int>(defaultDueDays);
    map['default_notes'] = Variable<String>(defaultNotes);
    map['default_payment_instructions'] = Variable<String>(
      defaultPaymentInstructions,
    );
    map['notifications_enabled'] = Variable<bool>(notificationsEnabled);
    map['remind_before_days'] = Variable<int>(remindBeforeDays);
    map['remind_on_due'] = Variable<bool>(remindOnDue);
    map['remind_after3'] = Variable<bool>(remindAfter3);
    map['remind_after7'] = Variable<bool>(remindAfter7);
    map['pin_enabled'] = Variable<bool>(pinEnabled);
    map['biometric_enabled'] = Variable<bool>(biometricEnabled);
    map['auto_lock_seconds'] = Variable<int>(autoLockSeconds);
    map['protect_sensitive'] = Variable<bool>(protectSensitive);
    if (!nullToAbsent || lastBackupAt != null) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt);
    }
    map['theme_mode'] = Variable<String>(themeMode);
    map['payment_methods'] = Variable<String>(paymentMethods);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    map['insight_enabled'] = Variable<bool>(insightEnabled);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(
      id: Value(id),
      onboardingComplete: Value(onboardingComplete),
      invoicePrefix: Value(invoicePrefix),
      nextInvoiceSequence: Value(nextInvoiceSequence),
      receiptPrefix: Value(receiptPrefix),
      nextReceiptSequence: Value(nextReceiptSequence),
      numberPadding: Value(numberPadding),
      defaultCurrency: Value(defaultCurrency),
      taxEnabled: Value(taxEnabled),
      defaultTaxRateBps: Value(defaultTaxRateBps),
      defaultTermsPreset: Value(defaultTermsPreset),
      defaultDueDays: Value(defaultDueDays),
      defaultNotes: Value(defaultNotes),
      defaultPaymentInstructions: Value(defaultPaymentInstructions),
      notificationsEnabled: Value(notificationsEnabled),
      remindBeforeDays: Value(remindBeforeDays),
      remindOnDue: Value(remindOnDue),
      remindAfter3: Value(remindAfter3),
      remindAfter7: Value(remindAfter7),
      pinEnabled: Value(pinEnabled),
      biometricEnabled: Value(biometricEnabled),
      autoLockSeconds: Value(autoLockSeconds),
      protectSensitive: Value(protectSensitive),
      lastBackupAt: lastBackupAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastBackupAt),
      themeMode: Value(themeMode),
      paymentMethods: Value(paymentMethods),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      insightEnabled: Value(insightEnabled),
    );
  }

  factory AppSettingRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSettingRow(
      id: serializer.fromJson<String>(json['id']),
      onboardingComplete: serializer.fromJson<bool>(json['onboardingComplete']),
      invoicePrefix: serializer.fromJson<String>(json['invoicePrefix']),
      nextInvoiceSequence: serializer.fromJson<int>(
        json['nextInvoiceSequence'],
      ),
      receiptPrefix: serializer.fromJson<String>(json['receiptPrefix']),
      nextReceiptSequence: serializer.fromJson<int>(
        json['nextReceiptSequence'],
      ),
      numberPadding: serializer.fromJson<int>(json['numberPadding']),
      defaultCurrency: serializer.fromJson<String>(json['defaultCurrency']),
      taxEnabled: serializer.fromJson<bool>(json['taxEnabled']),
      defaultTaxRateBps: serializer.fromJson<int>(json['defaultTaxRateBps']),
      defaultTermsPreset: serializer.fromJson<String>(
        json['defaultTermsPreset'],
      ),
      defaultDueDays: serializer.fromJson<int>(json['defaultDueDays']),
      defaultNotes: serializer.fromJson<String>(json['defaultNotes']),
      defaultPaymentInstructions: serializer.fromJson<String>(
        json['defaultPaymentInstructions'],
      ),
      notificationsEnabled: serializer.fromJson<bool>(
        json['notificationsEnabled'],
      ),
      remindBeforeDays: serializer.fromJson<int>(json['remindBeforeDays']),
      remindOnDue: serializer.fromJson<bool>(json['remindOnDue']),
      remindAfter3: serializer.fromJson<bool>(json['remindAfter3']),
      remindAfter7: serializer.fromJson<bool>(json['remindAfter7']),
      pinEnabled: serializer.fromJson<bool>(json['pinEnabled']),
      biometricEnabled: serializer.fromJson<bool>(json['biometricEnabled']),
      autoLockSeconds: serializer.fromJson<int>(json['autoLockSeconds']),
      protectSensitive: serializer.fromJson<bool>(json['protectSensitive']),
      lastBackupAt: serializer.fromJson<DateTime?>(json['lastBackupAt']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      paymentMethods: serializer.fromJson<String>(json['paymentMethods']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      insightEnabled: serializer.fromJson<bool>(json['insightEnabled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'onboardingComplete': serializer.toJson<bool>(onboardingComplete),
      'invoicePrefix': serializer.toJson<String>(invoicePrefix),
      'nextInvoiceSequence': serializer.toJson<int>(nextInvoiceSequence),
      'receiptPrefix': serializer.toJson<String>(receiptPrefix),
      'nextReceiptSequence': serializer.toJson<int>(nextReceiptSequence),
      'numberPadding': serializer.toJson<int>(numberPadding),
      'defaultCurrency': serializer.toJson<String>(defaultCurrency),
      'taxEnabled': serializer.toJson<bool>(taxEnabled),
      'defaultTaxRateBps': serializer.toJson<int>(defaultTaxRateBps),
      'defaultTermsPreset': serializer.toJson<String>(defaultTermsPreset),
      'defaultDueDays': serializer.toJson<int>(defaultDueDays),
      'defaultNotes': serializer.toJson<String>(defaultNotes),
      'defaultPaymentInstructions': serializer.toJson<String>(
        defaultPaymentInstructions,
      ),
      'notificationsEnabled': serializer.toJson<bool>(notificationsEnabled),
      'remindBeforeDays': serializer.toJson<int>(remindBeforeDays),
      'remindOnDue': serializer.toJson<bool>(remindOnDue),
      'remindAfter3': serializer.toJson<bool>(remindAfter3),
      'remindAfter7': serializer.toJson<bool>(remindAfter7),
      'pinEnabled': serializer.toJson<bool>(pinEnabled),
      'biometricEnabled': serializer.toJson<bool>(biometricEnabled),
      'autoLockSeconds': serializer.toJson<int>(autoLockSeconds),
      'protectSensitive': serializer.toJson<bool>(protectSensitive),
      'lastBackupAt': serializer.toJson<DateTime?>(lastBackupAt),
      'themeMode': serializer.toJson<String>(themeMode),
      'paymentMethods': serializer.toJson<String>(paymentMethods),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'insightEnabled': serializer.toJson<bool>(insightEnabled),
    };
  }

  AppSettingRow copyWith({
    String? id,
    bool? onboardingComplete,
    String? invoicePrefix,
    int? nextInvoiceSequence,
    String? receiptPrefix,
    int? nextReceiptSequence,
    int? numberPadding,
    String? defaultCurrency,
    bool? taxEnabled,
    int? defaultTaxRateBps,
    String? defaultTermsPreset,
    int? defaultDueDays,
    String? defaultNotes,
    String? defaultPaymentInstructions,
    bool? notificationsEnabled,
    int? remindBeforeDays,
    bool? remindOnDue,
    bool? remindAfter3,
    bool? remindAfter7,
    bool? pinEnabled,
    bool? biometricEnabled,
    int? autoLockSeconds,
    bool? protectSensitive,
    Value<DateTime?> lastBackupAt = const Value.absent(),
    String? themeMode,
    String? paymentMethods,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? insightEnabled,
  }) => AppSettingRow(
    id: id ?? this.id,
    onboardingComplete: onboardingComplete ?? this.onboardingComplete,
    invoicePrefix: invoicePrefix ?? this.invoicePrefix,
    nextInvoiceSequence: nextInvoiceSequence ?? this.nextInvoiceSequence,
    receiptPrefix: receiptPrefix ?? this.receiptPrefix,
    nextReceiptSequence: nextReceiptSequence ?? this.nextReceiptSequence,
    numberPadding: numberPadding ?? this.numberPadding,
    defaultCurrency: defaultCurrency ?? this.defaultCurrency,
    taxEnabled: taxEnabled ?? this.taxEnabled,
    defaultTaxRateBps: defaultTaxRateBps ?? this.defaultTaxRateBps,
    defaultTermsPreset: defaultTermsPreset ?? this.defaultTermsPreset,
    defaultDueDays: defaultDueDays ?? this.defaultDueDays,
    defaultNotes: defaultNotes ?? this.defaultNotes,
    defaultPaymentInstructions:
        defaultPaymentInstructions ?? this.defaultPaymentInstructions,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    remindBeforeDays: remindBeforeDays ?? this.remindBeforeDays,
    remindOnDue: remindOnDue ?? this.remindOnDue,
    remindAfter3: remindAfter3 ?? this.remindAfter3,
    remindAfter7: remindAfter7 ?? this.remindAfter7,
    pinEnabled: pinEnabled ?? this.pinEnabled,
    biometricEnabled: biometricEnabled ?? this.biometricEnabled,
    autoLockSeconds: autoLockSeconds ?? this.autoLockSeconds,
    protectSensitive: protectSensitive ?? this.protectSensitive,
    lastBackupAt: lastBackupAt.present ? lastBackupAt.value : this.lastBackupAt,
    themeMode: themeMode ?? this.themeMode,
    paymentMethods: paymentMethods ?? this.paymentMethods,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    insightEnabled: insightEnabled ?? this.insightEnabled,
  );
  AppSettingRow copyWithCompanion(AppSettingsCompanion data) {
    return AppSettingRow(
      id: data.id.present ? data.id.value : this.id,
      onboardingComplete: data.onboardingComplete.present
          ? data.onboardingComplete.value
          : this.onboardingComplete,
      invoicePrefix: data.invoicePrefix.present
          ? data.invoicePrefix.value
          : this.invoicePrefix,
      nextInvoiceSequence: data.nextInvoiceSequence.present
          ? data.nextInvoiceSequence.value
          : this.nextInvoiceSequence,
      receiptPrefix: data.receiptPrefix.present
          ? data.receiptPrefix.value
          : this.receiptPrefix,
      nextReceiptSequence: data.nextReceiptSequence.present
          ? data.nextReceiptSequence.value
          : this.nextReceiptSequence,
      numberPadding: data.numberPadding.present
          ? data.numberPadding.value
          : this.numberPadding,
      defaultCurrency: data.defaultCurrency.present
          ? data.defaultCurrency.value
          : this.defaultCurrency,
      taxEnabled: data.taxEnabled.present
          ? data.taxEnabled.value
          : this.taxEnabled,
      defaultTaxRateBps: data.defaultTaxRateBps.present
          ? data.defaultTaxRateBps.value
          : this.defaultTaxRateBps,
      defaultTermsPreset: data.defaultTermsPreset.present
          ? data.defaultTermsPreset.value
          : this.defaultTermsPreset,
      defaultDueDays: data.defaultDueDays.present
          ? data.defaultDueDays.value
          : this.defaultDueDays,
      defaultNotes: data.defaultNotes.present
          ? data.defaultNotes.value
          : this.defaultNotes,
      defaultPaymentInstructions: data.defaultPaymentInstructions.present
          ? data.defaultPaymentInstructions.value
          : this.defaultPaymentInstructions,
      notificationsEnabled: data.notificationsEnabled.present
          ? data.notificationsEnabled.value
          : this.notificationsEnabled,
      remindBeforeDays: data.remindBeforeDays.present
          ? data.remindBeforeDays.value
          : this.remindBeforeDays,
      remindOnDue: data.remindOnDue.present
          ? data.remindOnDue.value
          : this.remindOnDue,
      remindAfter3: data.remindAfter3.present
          ? data.remindAfter3.value
          : this.remindAfter3,
      remindAfter7: data.remindAfter7.present
          ? data.remindAfter7.value
          : this.remindAfter7,
      pinEnabled: data.pinEnabled.present
          ? data.pinEnabled.value
          : this.pinEnabled,
      biometricEnabled: data.biometricEnabled.present
          ? data.biometricEnabled.value
          : this.biometricEnabled,
      autoLockSeconds: data.autoLockSeconds.present
          ? data.autoLockSeconds.value
          : this.autoLockSeconds,
      protectSensitive: data.protectSensitive.present
          ? data.protectSensitive.value
          : this.protectSensitive,
      lastBackupAt: data.lastBackupAt.present
          ? data.lastBackupAt.value
          : this.lastBackupAt,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      paymentMethods: data.paymentMethods.present
          ? data.paymentMethods.value
          : this.paymentMethods,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      insightEnabled: data.insightEnabled.present
          ? data.insightEnabled.value
          : this.insightEnabled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingRow(')
          ..write('id: $id, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('nextInvoiceSequence: $nextInvoiceSequence, ')
          ..write('receiptPrefix: $receiptPrefix, ')
          ..write('nextReceiptSequence: $nextReceiptSequence, ')
          ..write('numberPadding: $numberPadding, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('taxEnabled: $taxEnabled, ')
          ..write('defaultTaxRateBps: $defaultTaxRateBps, ')
          ..write('defaultTermsPreset: $defaultTermsPreset, ')
          ..write('defaultDueDays: $defaultDueDays, ')
          ..write('defaultNotes: $defaultNotes, ')
          ..write('defaultPaymentInstructions: $defaultPaymentInstructions, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('remindBeforeDays: $remindBeforeDays, ')
          ..write('remindOnDue: $remindOnDue, ')
          ..write('remindAfter3: $remindAfter3, ')
          ..write('remindAfter7: $remindAfter7, ')
          ..write('pinEnabled: $pinEnabled, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('autoLockSeconds: $autoLockSeconds, ')
          ..write('protectSensitive: $protectSensitive, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('themeMode: $themeMode, ')
          ..write('paymentMethods: $paymentMethods, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('insightEnabled: $insightEnabled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    onboardingComplete,
    invoicePrefix,
    nextInvoiceSequence,
    receiptPrefix,
    nextReceiptSequence,
    numberPadding,
    defaultCurrency,
    taxEnabled,
    defaultTaxRateBps,
    defaultTermsPreset,
    defaultDueDays,
    defaultNotes,
    defaultPaymentInstructions,
    notificationsEnabled,
    remindBeforeDays,
    remindOnDue,
    remindAfter3,
    remindAfter7,
    pinEnabled,
    biometricEnabled,
    autoLockSeconds,
    protectSensitive,
    lastBackupAt,
    themeMode,
    paymentMethods,
    createdAt,
    updatedAt,
    insightEnabled,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSettingRow &&
          other.id == this.id &&
          other.onboardingComplete == this.onboardingComplete &&
          other.invoicePrefix == this.invoicePrefix &&
          other.nextInvoiceSequence == this.nextInvoiceSequence &&
          other.receiptPrefix == this.receiptPrefix &&
          other.nextReceiptSequence == this.nextReceiptSequence &&
          other.numberPadding == this.numberPadding &&
          other.defaultCurrency == this.defaultCurrency &&
          other.taxEnabled == this.taxEnabled &&
          other.defaultTaxRateBps == this.defaultTaxRateBps &&
          other.defaultTermsPreset == this.defaultTermsPreset &&
          other.defaultDueDays == this.defaultDueDays &&
          other.defaultNotes == this.defaultNotes &&
          other.defaultPaymentInstructions == this.defaultPaymentInstructions &&
          other.notificationsEnabled == this.notificationsEnabled &&
          other.remindBeforeDays == this.remindBeforeDays &&
          other.remindOnDue == this.remindOnDue &&
          other.remindAfter3 == this.remindAfter3 &&
          other.remindAfter7 == this.remindAfter7 &&
          other.pinEnabled == this.pinEnabled &&
          other.biometricEnabled == this.biometricEnabled &&
          other.autoLockSeconds == this.autoLockSeconds &&
          other.protectSensitive == this.protectSensitive &&
          other.lastBackupAt == this.lastBackupAt &&
          other.themeMode == this.themeMode &&
          other.paymentMethods == this.paymentMethods &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.insightEnabled == this.insightEnabled);
}

class AppSettingsCompanion extends UpdateCompanion<AppSettingRow> {
  final Value<String> id;
  final Value<bool> onboardingComplete;
  final Value<String> invoicePrefix;
  final Value<int> nextInvoiceSequence;
  final Value<String> receiptPrefix;
  final Value<int> nextReceiptSequence;
  final Value<int> numberPadding;
  final Value<String> defaultCurrency;
  final Value<bool> taxEnabled;
  final Value<int> defaultTaxRateBps;
  final Value<String> defaultTermsPreset;
  final Value<int> defaultDueDays;
  final Value<String> defaultNotes;
  final Value<String> defaultPaymentInstructions;
  final Value<bool> notificationsEnabled;
  final Value<int> remindBeforeDays;
  final Value<bool> remindOnDue;
  final Value<bool> remindAfter3;
  final Value<bool> remindAfter7;
  final Value<bool> pinEnabled;
  final Value<bool> biometricEnabled;
  final Value<int> autoLockSeconds;
  final Value<bool> protectSensitive;
  final Value<DateTime?> lastBackupAt;
  final Value<String> themeMode;
  final Value<String> paymentMethods;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<bool> insightEnabled;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.id = const Value.absent(),
    this.onboardingComplete = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.nextInvoiceSequence = const Value.absent(),
    this.receiptPrefix = const Value.absent(),
    this.nextReceiptSequence = const Value.absent(),
    this.numberPadding = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.taxEnabled = const Value.absent(),
    this.defaultTaxRateBps = const Value.absent(),
    this.defaultTermsPreset = const Value.absent(),
    this.defaultDueDays = const Value.absent(),
    this.defaultNotes = const Value.absent(),
    this.defaultPaymentInstructions = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.remindBeforeDays = const Value.absent(),
    this.remindOnDue = const Value.absent(),
    this.remindAfter3 = const Value.absent(),
    this.remindAfter7 = const Value.absent(),
    this.pinEnabled = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.autoLockSeconds = const Value.absent(),
    this.protectSensitive = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.paymentMethods = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.insightEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String id,
    this.onboardingComplete = const Value.absent(),
    this.invoicePrefix = const Value.absent(),
    this.nextInvoiceSequence = const Value.absent(),
    this.receiptPrefix = const Value.absent(),
    this.nextReceiptSequence = const Value.absent(),
    this.numberPadding = const Value.absent(),
    this.defaultCurrency = const Value.absent(),
    this.taxEnabled = const Value.absent(),
    this.defaultTaxRateBps = const Value.absent(),
    this.defaultTermsPreset = const Value.absent(),
    this.defaultDueDays = const Value.absent(),
    this.defaultNotes = const Value.absent(),
    this.defaultPaymentInstructions = const Value.absent(),
    this.notificationsEnabled = const Value.absent(),
    this.remindBeforeDays = const Value.absent(),
    this.remindOnDue = const Value.absent(),
    this.remindAfter3 = const Value.absent(),
    this.remindAfter7 = const Value.absent(),
    this.pinEnabled = const Value.absent(),
    this.biometricEnabled = const Value.absent(),
    this.autoLockSeconds = const Value.absent(),
    this.protectSensitive = const Value.absent(),
    this.lastBackupAt = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.paymentMethods = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.insightEnabled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<AppSettingRow> custom({
    Expression<String>? id,
    Expression<bool>? onboardingComplete,
    Expression<String>? invoicePrefix,
    Expression<int>? nextInvoiceSequence,
    Expression<String>? receiptPrefix,
    Expression<int>? nextReceiptSequence,
    Expression<int>? numberPadding,
    Expression<String>? defaultCurrency,
    Expression<bool>? taxEnabled,
    Expression<int>? defaultTaxRateBps,
    Expression<String>? defaultTermsPreset,
    Expression<int>? defaultDueDays,
    Expression<String>? defaultNotes,
    Expression<String>? defaultPaymentInstructions,
    Expression<bool>? notificationsEnabled,
    Expression<int>? remindBeforeDays,
    Expression<bool>? remindOnDue,
    Expression<bool>? remindAfter3,
    Expression<bool>? remindAfter7,
    Expression<bool>? pinEnabled,
    Expression<bool>? biometricEnabled,
    Expression<int>? autoLockSeconds,
    Expression<bool>? protectSensitive,
    Expression<DateTime>? lastBackupAt,
    Expression<String>? themeMode,
    Expression<String>? paymentMethods,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<bool>? insightEnabled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (onboardingComplete != null) 'onboarding_complete': onboardingComplete,
      if (invoicePrefix != null) 'invoice_prefix': invoicePrefix,
      if (nextInvoiceSequence != null)
        'next_invoice_sequence': nextInvoiceSequence,
      if (receiptPrefix != null) 'receipt_prefix': receiptPrefix,
      if (nextReceiptSequence != null)
        'next_receipt_sequence': nextReceiptSequence,
      if (numberPadding != null) 'number_padding': numberPadding,
      if (defaultCurrency != null) 'default_currency': defaultCurrency,
      if (taxEnabled != null) 'tax_enabled': taxEnabled,
      if (defaultTaxRateBps != null) 'default_tax_rate_bps': defaultTaxRateBps,
      if (defaultTermsPreset != null)
        'default_terms_preset': defaultTermsPreset,
      if (defaultDueDays != null) 'default_due_days': defaultDueDays,
      if (defaultNotes != null) 'default_notes': defaultNotes,
      if (defaultPaymentInstructions != null)
        'default_payment_instructions': defaultPaymentInstructions,
      if (notificationsEnabled != null)
        'notifications_enabled': notificationsEnabled,
      if (remindBeforeDays != null) 'remind_before_days': remindBeforeDays,
      if (remindOnDue != null) 'remind_on_due': remindOnDue,
      if (remindAfter3 != null) 'remind_after3': remindAfter3,
      if (remindAfter7 != null) 'remind_after7': remindAfter7,
      if (pinEnabled != null) 'pin_enabled': pinEnabled,
      if (biometricEnabled != null) 'biometric_enabled': biometricEnabled,
      if (autoLockSeconds != null) 'auto_lock_seconds': autoLockSeconds,
      if (protectSensitive != null) 'protect_sensitive': protectSensitive,
      if (lastBackupAt != null) 'last_backup_at': lastBackupAt,
      if (themeMode != null) 'theme_mode': themeMode,
      if (paymentMethods != null) 'payment_methods': paymentMethods,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (insightEnabled != null) 'insight_enabled': insightEnabled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? id,
    Value<bool>? onboardingComplete,
    Value<String>? invoicePrefix,
    Value<int>? nextInvoiceSequence,
    Value<String>? receiptPrefix,
    Value<int>? nextReceiptSequence,
    Value<int>? numberPadding,
    Value<String>? defaultCurrency,
    Value<bool>? taxEnabled,
    Value<int>? defaultTaxRateBps,
    Value<String>? defaultTermsPreset,
    Value<int>? defaultDueDays,
    Value<String>? defaultNotes,
    Value<String>? defaultPaymentInstructions,
    Value<bool>? notificationsEnabled,
    Value<int>? remindBeforeDays,
    Value<bool>? remindOnDue,
    Value<bool>? remindAfter3,
    Value<bool>? remindAfter7,
    Value<bool>? pinEnabled,
    Value<bool>? biometricEnabled,
    Value<int>? autoLockSeconds,
    Value<bool>? protectSensitive,
    Value<DateTime?>? lastBackupAt,
    Value<String>? themeMode,
    Value<String>? paymentMethods,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<bool>? insightEnabled,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      id: id ?? this.id,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      invoicePrefix: invoicePrefix ?? this.invoicePrefix,
      nextInvoiceSequence: nextInvoiceSequence ?? this.nextInvoiceSequence,
      receiptPrefix: receiptPrefix ?? this.receiptPrefix,
      nextReceiptSequence: nextReceiptSequence ?? this.nextReceiptSequence,
      numberPadding: numberPadding ?? this.numberPadding,
      defaultCurrency: defaultCurrency ?? this.defaultCurrency,
      taxEnabled: taxEnabled ?? this.taxEnabled,
      defaultTaxRateBps: defaultTaxRateBps ?? this.defaultTaxRateBps,
      defaultTermsPreset: defaultTermsPreset ?? this.defaultTermsPreset,
      defaultDueDays: defaultDueDays ?? this.defaultDueDays,
      defaultNotes: defaultNotes ?? this.defaultNotes,
      defaultPaymentInstructions:
          defaultPaymentInstructions ?? this.defaultPaymentInstructions,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      remindBeforeDays: remindBeforeDays ?? this.remindBeforeDays,
      remindOnDue: remindOnDue ?? this.remindOnDue,
      remindAfter3: remindAfter3 ?? this.remindAfter3,
      remindAfter7: remindAfter7 ?? this.remindAfter7,
      pinEnabled: pinEnabled ?? this.pinEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      autoLockSeconds: autoLockSeconds ?? this.autoLockSeconds,
      protectSensitive: protectSensitive ?? this.protectSensitive,
      lastBackupAt: lastBackupAt ?? this.lastBackupAt,
      themeMode: themeMode ?? this.themeMode,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      insightEnabled: insightEnabled ?? this.insightEnabled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (onboardingComplete.present) {
      map['onboarding_complete'] = Variable<bool>(onboardingComplete.value);
    }
    if (invoicePrefix.present) {
      map['invoice_prefix'] = Variable<String>(invoicePrefix.value);
    }
    if (nextInvoiceSequence.present) {
      map['next_invoice_sequence'] = Variable<int>(nextInvoiceSequence.value);
    }
    if (receiptPrefix.present) {
      map['receipt_prefix'] = Variable<String>(receiptPrefix.value);
    }
    if (nextReceiptSequence.present) {
      map['next_receipt_sequence'] = Variable<int>(nextReceiptSequence.value);
    }
    if (numberPadding.present) {
      map['number_padding'] = Variable<int>(numberPadding.value);
    }
    if (defaultCurrency.present) {
      map['default_currency'] = Variable<String>(defaultCurrency.value);
    }
    if (taxEnabled.present) {
      map['tax_enabled'] = Variable<bool>(taxEnabled.value);
    }
    if (defaultTaxRateBps.present) {
      map['default_tax_rate_bps'] = Variable<int>(defaultTaxRateBps.value);
    }
    if (defaultTermsPreset.present) {
      map['default_terms_preset'] = Variable<String>(defaultTermsPreset.value);
    }
    if (defaultDueDays.present) {
      map['default_due_days'] = Variable<int>(defaultDueDays.value);
    }
    if (defaultNotes.present) {
      map['default_notes'] = Variable<String>(defaultNotes.value);
    }
    if (defaultPaymentInstructions.present) {
      map['default_payment_instructions'] = Variable<String>(
        defaultPaymentInstructions.value,
      );
    }
    if (notificationsEnabled.present) {
      map['notifications_enabled'] = Variable<bool>(notificationsEnabled.value);
    }
    if (remindBeforeDays.present) {
      map['remind_before_days'] = Variable<int>(remindBeforeDays.value);
    }
    if (remindOnDue.present) {
      map['remind_on_due'] = Variable<bool>(remindOnDue.value);
    }
    if (remindAfter3.present) {
      map['remind_after3'] = Variable<bool>(remindAfter3.value);
    }
    if (remindAfter7.present) {
      map['remind_after7'] = Variable<bool>(remindAfter7.value);
    }
    if (pinEnabled.present) {
      map['pin_enabled'] = Variable<bool>(pinEnabled.value);
    }
    if (biometricEnabled.present) {
      map['biometric_enabled'] = Variable<bool>(biometricEnabled.value);
    }
    if (autoLockSeconds.present) {
      map['auto_lock_seconds'] = Variable<int>(autoLockSeconds.value);
    }
    if (protectSensitive.present) {
      map['protect_sensitive'] = Variable<bool>(protectSensitive.value);
    }
    if (lastBackupAt.present) {
      map['last_backup_at'] = Variable<DateTime>(lastBackupAt.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (paymentMethods.present) {
      map['payment_methods'] = Variable<String>(paymentMethods.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (insightEnabled.present) {
      map['insight_enabled'] = Variable<bool>(insightEnabled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('id: $id, ')
          ..write('onboardingComplete: $onboardingComplete, ')
          ..write('invoicePrefix: $invoicePrefix, ')
          ..write('nextInvoiceSequence: $nextInvoiceSequence, ')
          ..write('receiptPrefix: $receiptPrefix, ')
          ..write('nextReceiptSequence: $nextReceiptSequence, ')
          ..write('numberPadding: $numberPadding, ')
          ..write('defaultCurrency: $defaultCurrency, ')
          ..write('taxEnabled: $taxEnabled, ')
          ..write('defaultTaxRateBps: $defaultTaxRateBps, ')
          ..write('defaultTermsPreset: $defaultTermsPreset, ')
          ..write('defaultDueDays: $defaultDueDays, ')
          ..write('defaultNotes: $defaultNotes, ')
          ..write('defaultPaymentInstructions: $defaultPaymentInstructions, ')
          ..write('notificationsEnabled: $notificationsEnabled, ')
          ..write('remindBeforeDays: $remindBeforeDays, ')
          ..write('remindOnDue: $remindOnDue, ')
          ..write('remindAfter3: $remindAfter3, ')
          ..write('remindAfter7: $remindAfter7, ')
          ..write('pinEnabled: $pinEnabled, ')
          ..write('biometricEnabled: $biometricEnabled, ')
          ..write('autoLockSeconds: $autoLockSeconds, ')
          ..write('protectSensitive: $protectSensitive, ')
          ..write('lastBackupAt: $lastBackupAt, ')
          ..write('themeMode: $themeMode, ')
          ..write('paymentMethods: $paymentMethods, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('insightEnabled: $insightEnabled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BackupMetadataTable extends BackupMetadata
    with TableInfo<$BackupMetadataTable, BackupMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BackupMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fileNameMeta = const VerificationMeta(
    'fileName',
  );
  @override
  late final GeneratedColumn<String> fileName = GeneratedColumn<String>(
    'file_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _formatVersionMeta = const VerificationMeta(
    'formatVersion',
  );
  @override
  late final GeneratedColumn<int> formatVersion = GeneratedColumn<int>(
    'format_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _encryptedMeta = const VerificationMeta(
    'encrypted',
  );
  @override
  late final GeneratedColumn<bool> encrypted = GeneratedColumn<bool>(
    'encrypted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("encrypted" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sizeBytesMeta = const VerificationMeta(
    'sizeBytes',
  );
  @override
  late final GeneratedColumn<int> sizeBytes = GeneratedColumn<int>(
    'size_bytes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    fileName,
    formatVersion,
    encrypted,
    sizeBytes,
    note,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'backup_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<BackupMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('file_name')) {
      context.handle(
        _fileNameMeta,
        fileName.isAcceptableOrUnknown(data['file_name']!, _fileNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fileNameMeta);
    }
    if (data.containsKey('format_version')) {
      context.handle(
        _formatVersionMeta,
        formatVersion.isAcceptableOrUnknown(
          data['format_version']!,
          _formatVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_formatVersionMeta);
    }
    if (data.containsKey('encrypted')) {
      context.handle(
        _encryptedMeta,
        encrypted.isAcceptableOrUnknown(data['encrypted']!, _encryptedMeta),
      );
    }
    if (data.containsKey('size_bytes')) {
      context.handle(
        _sizeBytesMeta,
        sizeBytes.isAcceptableOrUnknown(data['size_bytes']!, _sizeBytesMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  BackupMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BackupMetadataRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      fileName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_name'],
      )!,
      formatVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}format_version'],
      )!,
      encrypted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}encrypted'],
      )!,
      sizeBytes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size_bytes'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
    );
  }

  @override
  $BackupMetadataTable createAlias(String alias) {
    return $BackupMetadataTable(attachedDatabase, alias);
  }
}

class BackupMetadataRow extends DataClass
    implements Insertable<BackupMetadataRow> {
  final String id;
  final DateTime createdAt;
  final String fileName;
  final int formatVersion;
  final bool encrypted;
  final int sizeBytes;
  final String? note;
  const BackupMetadataRow({
    required this.id,
    required this.createdAt,
    required this.fileName,
    required this.formatVersion,
    required this.encrypted,
    required this.sizeBytes,
    this.note,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['file_name'] = Variable<String>(fileName);
    map['format_version'] = Variable<int>(formatVersion);
    map['encrypted'] = Variable<bool>(encrypted);
    map['size_bytes'] = Variable<int>(sizeBytes);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    return map;
  }

  BackupMetadataCompanion toCompanion(bool nullToAbsent) {
    return BackupMetadataCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      fileName: Value(fileName),
      formatVersion: Value(formatVersion),
      encrypted: Value(encrypted),
      sizeBytes: Value(sizeBytes),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
    );
  }

  factory BackupMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BackupMetadataRow(
      id: serializer.fromJson<String>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      fileName: serializer.fromJson<String>(json['fileName']),
      formatVersion: serializer.fromJson<int>(json['formatVersion']),
      encrypted: serializer.fromJson<bool>(json['encrypted']),
      sizeBytes: serializer.fromJson<int>(json['sizeBytes']),
      note: serializer.fromJson<String?>(json['note']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'fileName': serializer.toJson<String>(fileName),
      'formatVersion': serializer.toJson<int>(formatVersion),
      'encrypted': serializer.toJson<bool>(encrypted),
      'sizeBytes': serializer.toJson<int>(sizeBytes),
      'note': serializer.toJson<String?>(note),
    };
  }

  BackupMetadataRow copyWith({
    String? id,
    DateTime? createdAt,
    String? fileName,
    int? formatVersion,
    bool? encrypted,
    int? sizeBytes,
    Value<String?> note = const Value.absent(),
  }) => BackupMetadataRow(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    fileName: fileName ?? this.fileName,
    formatVersion: formatVersion ?? this.formatVersion,
    encrypted: encrypted ?? this.encrypted,
    sizeBytes: sizeBytes ?? this.sizeBytes,
    note: note.present ? note.value : this.note,
  );
  BackupMetadataRow copyWithCompanion(BackupMetadataCompanion data) {
    return BackupMetadataRow(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      fileName: data.fileName.present ? data.fileName.value : this.fileName,
      formatVersion: data.formatVersion.present
          ? data.formatVersion.value
          : this.formatVersion,
      encrypted: data.encrypted.present ? data.encrypted.value : this.encrypted,
      sizeBytes: data.sizeBytes.present ? data.sizeBytes.value : this.sizeBytes,
      note: data.note.present ? data.note.value : this.note,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataRow(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('fileName: $fileName, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('encrypted: $encrypted, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('note: $note')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    fileName,
    formatVersion,
    encrypted,
    sizeBytes,
    note,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BackupMetadataRow &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.fileName == this.fileName &&
          other.formatVersion == this.formatVersion &&
          other.encrypted == this.encrypted &&
          other.sizeBytes == this.sizeBytes &&
          other.note == this.note);
}

class BackupMetadataCompanion extends UpdateCompanion<BackupMetadataRow> {
  final Value<String> id;
  final Value<DateTime> createdAt;
  final Value<String> fileName;
  final Value<int> formatVersion;
  final Value<bool> encrypted;
  final Value<int> sizeBytes;
  final Value<String?> note;
  final Value<int> rowid;
  const BackupMetadataCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.fileName = const Value.absent(),
    this.formatVersion = const Value.absent(),
    this.encrypted = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BackupMetadataCompanion.insert({
    required String id,
    required DateTime createdAt,
    required String fileName,
    required int formatVersion,
    this.encrypted = const Value.absent(),
    this.sizeBytes = const Value.absent(),
    this.note = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       createdAt = Value(createdAt),
       fileName = Value(fileName),
       formatVersion = Value(formatVersion);
  static Insertable<BackupMetadataRow> custom({
    Expression<String>? id,
    Expression<DateTime>? createdAt,
    Expression<String>? fileName,
    Expression<int>? formatVersion,
    Expression<bool>? encrypted,
    Expression<int>? sizeBytes,
    Expression<String>? note,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (fileName != null) 'file_name': fileName,
      if (formatVersion != null) 'format_version': formatVersion,
      if (encrypted != null) 'encrypted': encrypted,
      if (sizeBytes != null) 'size_bytes': sizeBytes,
      if (note != null) 'note': note,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BackupMetadataCompanion copyWith({
    Value<String>? id,
    Value<DateTime>? createdAt,
    Value<String>? fileName,
    Value<int>? formatVersion,
    Value<bool>? encrypted,
    Value<int>? sizeBytes,
    Value<String?>? note,
    Value<int>? rowid,
  }) {
    return BackupMetadataCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      fileName: fileName ?? this.fileName,
      formatVersion: formatVersion ?? this.formatVersion,
      encrypted: encrypted ?? this.encrypted,
      sizeBytes: sizeBytes ?? this.sizeBytes,
      note: note ?? this.note,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (fileName.present) {
      map['file_name'] = Variable<String>(fileName.value);
    }
    if (formatVersion.present) {
      map['format_version'] = Variable<int>(formatVersion.value);
    }
    if (encrypted.present) {
      map['encrypted'] = Variable<bool>(encrypted.value);
    }
    if (sizeBytes.present) {
      map['size_bytes'] = Variable<int>(sizeBytes.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BackupMetadataCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('fileName: $fileName, ')
          ..write('formatVersion: $formatVersion, ')
          ..write('encrypted: $encrypted, ')
          ..write('sizeBytes: $sizeBytes, ')
          ..write('note: $note, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $BusinessesTable businesses = $BusinessesTable(this);
  late final $BrandProfilesTable brandProfiles = $BrandProfilesTable(this);
  late final $BankAccountsTable bankAccounts = $BankAccountsTable(this);
  late final $ServicesTable services = $ServicesTable(this);
  late final $CustomersTable customers = $CustomersTable(this);
  late final $InvoicesTable invoices = $InvoicesTable(this);
  late final $InvoiceItemsTable invoiceItems = $InvoiceItemsTable(this);
  late final $PaymentsTable payments = $PaymentsTable(this);
  late final $ReceiptsTable receipts = $ReceiptsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $MessageTemplatesTable messageTemplates = $MessageTemplatesTable(
    this,
  );
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $BackupMetadataTable backupMetadata = $BackupMetadataTable(this);
  late final Index idxInvoicesStatus = Index(
    'idx_invoices_status',
    'CREATE INDEX idx_invoices_status ON invoices (status)',
  );
  late final Index idxInvoicesCustomer = Index(
    'idx_invoices_customer',
    'CREATE INDEX idx_invoices_customer ON invoices (customer_id)',
  );
  late final Index idxPaymentsInvoice = Index(
    'idx_payments_invoice',
    'CREATE INDEX idx_payments_invoice ON payments (invoice_id)',
  );
  late final Index idxRemindersInvoice = Index(
    'idx_reminders_invoice',
    'CREATE INDEX idx_reminders_invoice ON reminders (invoice_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    businesses,
    brandProfiles,
    bankAccounts,
    services,
    customers,
    invoices,
    invoiceItems,
    payments,
    receipts,
    reminders,
    messageTemplates,
    appSettings,
    backupMetadata,
    idxInvoicesStatus,
    idxInvoicesCustomer,
    idxPaymentsInvoice,
    idxRemindersInvoice,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('invoice_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'invoices',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$BusinessesTableCreateCompanionBuilder = BusinessesCompanion Function({
  required String id,
  required String legalName,
  Value<String?> tradingName,
  required String phone,
  required String whatsapp,
  required String email,
  required String address,
  Value<String?> website,
  Value<String?> registrationNumber,
  Value<String?> tin,
  Value<String?> description,
  Value<String> defaultCurrency,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$BusinessesTableUpdateCompanionBuilder = BusinessesCompanion Function({
  Value<String> id,
  Value<String> legalName,
  Value<String?> tradingName,
  Value<String> phone,
  Value<String> whatsapp,
  Value<String> email,
  Value<String> address,
  Value<String?> website,
  Value<String?> registrationNumber,
  Value<String?> tin,
  Value<String?> description,
  Value<String> defaultCurrency,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$BusinessesTableReferences
    extends BaseReferences<_$AppDatabase, $BusinessesTable, BusinessRow> {
  $$BusinessesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$BankAccountsTable, List<BankAccountRow>>
  _bankAccountsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.bankAccounts,
    aliasName: 'businesses__id__bank_accounts__business_id',
  );

  $$BankAccountsTableProcessedTableManager get bankAccountsRefs {
    final manager = $$BankAccountsTableTableManager(
      $_db,
      $_db.bankAccounts,
    ).filter((f) => f.businessId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_bankAccountsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ServicesTable, List<ServiceRow>>
  _servicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.services,
    aliasName: 'businesses__id__services__business_id',
  );

  $$ServicesTableProcessedTableManager get servicesRefs {
    final manager = $$ServicesTableTableManager(
      $_db,
      $_db.services,
    ).filter((f) => f.businessId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_servicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CustomersTable, List<CustomerRow>>
  _customersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.customers,
    aliasName: 'businesses__id__customers__business_id',
  );

  $$CustomersTableProcessedTableManager get customersRefs {
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.businessId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_customersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<InvoiceRow>>
  _invoicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'businesses__id__invoices__business_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.businessId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BusinessesTableFilterComposer
    extends Composer<_$AppDatabase, $BusinessesTable> {
  $$BusinessesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tradingName => $composableBuilder(
    column: $table.tradingName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatsapp => $composableBuilder(
    column: $table.whatsapp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tin => $composableBuilder(
    column: $table.tin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> bankAccountsRefs(
    Expression<bool> Function($$BankAccountsTableFilterComposer f) f,
  ) {
    final $$BankAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableFilterComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> servicesRefs(
    Expression<bool> Function($$ServicesTableFilterComposer f) f,
  ) {
    final $$ServicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableFilterComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> customersRefs(
    Expression<bool> Function($$CustomersTableFilterComposer f) f,
  ) {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BusinessesTableOrderingComposer
    extends Composer<_$AppDatabase, $BusinessesTable> {
  $$BusinessesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get legalName => $composableBuilder(
    column: $table.legalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tradingName => $composableBuilder(
    column: $table.tradingName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatsapp => $composableBuilder(
    column: $table.whatsapp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get website => $composableBuilder(
    column: $table.website,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tin => $composableBuilder(
    column: $table.tin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BusinessesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BusinessesTable> {
  $$BusinessesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get legalName =>
      $composableBuilder(column: $table.legalName, builder: (column) => column);

  GeneratedColumn<String> get tradingName => $composableBuilder(
    column: $table.tradingName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get whatsapp =>
      $composableBuilder(column: $table.whatsapp, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<String> get registrationNumber => $composableBuilder(
    column: $table.registrationNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tin =>
      $composableBuilder(column: $table.tin, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> bankAccountsRefs<T extends Object>(
    Expression<T> Function($$BankAccountsTableAnnotationComposer a) f,
  ) {
    final $$BankAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> servicesRefs<T extends Object>(
    Expression<T> Function($$ServicesTableAnnotationComposer a) f,
  ) {
    final $$ServicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableAnnotationComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> customersRefs<T extends Object>(
    Expression<T> Function($$CustomersTableAnnotationComposer a) f,
  ) {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.businessId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BusinessesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BusinessesTable,
          BusinessRow,
          $$BusinessesTableFilterComposer,
          $$BusinessesTableOrderingComposer,
          $$BusinessesTableAnnotationComposer,
          $$BusinessesTableCreateCompanionBuilder,
          $$BusinessesTableUpdateCompanionBuilder,
          (BusinessRow, $$BusinessesTableReferences),
          BusinessRow,
          PrefetchHooks Function({
            bool bankAccountsRefs,
            bool servicesRefs,
            bool customersRefs,
            bool invoicesRefs,
          })
        > {
  $$BusinessesTableTableManager(_$AppDatabase db, $BusinessesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BusinessesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BusinessesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BusinessesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> legalName = const Value.absent(),
                Value<String?> tradingName = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> whatsapp = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String?> website = const Value.absent(),
                Value<String?> registrationNumber = const Value.absent(),
                Value<String?> tin = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BusinessesCompanion(
                id: id,
                legalName: legalName,
                tradingName: tradingName,
                phone: phone,
                whatsapp: whatsapp,
                email: email,
                address: address,
                website: website,
                registrationNumber: registrationNumber,
                tin: tin,
                description: description,
                defaultCurrency: defaultCurrency,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String legalName,
                Value<String?> tradingName = const Value.absent(),
                required String phone,
                required String whatsapp,
                required String email,
                required String address,
                Value<String?> website = const Value.absent(),
                Value<String?> registrationNumber = const Value.absent(),
                Value<String?> tin = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BusinessesCompanion.insert(
                id: id,
                legalName: legalName,
                tradingName: tradingName,
                phone: phone,
                whatsapp: whatsapp,
                email: email,
                address: address,
                website: website,
                registrationNumber: registrationNumber,
                tin: tin,
                description: description,
                defaultCurrency: defaultCurrency,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BusinessesTable, BusinessRow>(table),
                  $$BusinessesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                bankAccountsRefs = false,
                servicesRefs = false,
                customersRefs = false,
                invoicesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (bankAccountsRefs) db.bankAccounts,
                    if (servicesRefs) db.services,
                    if (customersRefs) db.customers,
                    if (invoicesRefs) db.invoices,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (bankAccountsRefs)
                        await $_getPrefetchedDataByColumns<
                          BusinessRow,
                          $BusinessesTable,
                          BankAccountRow,
                          $BankAccountsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BusinessesTableReferences
                              ._bankAccountsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BusinessesTableReferences(
                                db,
                                table,
                                p0,
                              ).bankAccountsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'business_id',
                          typedResults: items,
                        ),
                      if (servicesRefs)
                        await $_getPrefetchedDataByColumns<
                          BusinessRow,
                          $BusinessesTable,
                          ServiceRow,
                          $ServicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$BusinessesTableReferences
                              ._servicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BusinessesTableReferences(
                                db,
                                table,
                                p0,
                              ).servicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'business_id',
                          typedResults: items,
                        ),
                      if (customersRefs)
                        await $_getPrefetchedDataByColumns<
                          BusinessRow,
                          $BusinessesTable,
                          CustomerRow,
                          $CustomersTable
                        >(
                          currentTable: table,
                          referencedTable: $$BusinessesTableReferences
                              ._customersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BusinessesTableReferences(
                                db,
                                table,
                                p0,
                              ).customersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'business_id',
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedDataByColumns<
                          BusinessRow,
                          $BusinessesTable,
                          InvoiceRow,
                          $InvoicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$BusinessesTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BusinessesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'business_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BusinessesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BusinessesTable,
      BusinessRow,
      $$BusinessesTableFilterComposer,
      $$BusinessesTableOrderingComposer,
      $$BusinessesTableAnnotationComposer,
      $$BusinessesTableCreateCompanionBuilder,
      $$BusinessesTableUpdateCompanionBuilder,
      (BusinessRow, $$BusinessesTableReferences),
      BusinessRow,
      PrefetchHooks Function({
        bool bankAccountsRefs,
        bool servicesRefs,
        bool customersRefs,
        bool invoicesRefs,
      })
    >;
typedef $$BrandProfilesTableCreateCompanionBuilder =
    BrandProfilesCompanion Function({
      required String id,
      required String ownerType,
      required String ownerId,
      Value<Uint8List?> logoBytes,
      Value<Uint8List?> signatureBytes,
      Value<String> primaryColor,
      Value<String> secondaryColor,
      Value<String> accentColor,
      Value<String?> tagline,
      Value<String?> footer,
      Value<String> template,
      Value<String?> tradingName,
      Value<String?> contactPhone,
      Value<String?> contactWhatsapp,
      Value<String?> contactEmail,
      Value<String?> contactAddress,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BrandProfilesTableUpdateCompanionBuilder =
    BrandProfilesCompanion Function({
      Value<String> id,
      Value<String> ownerType,
      Value<String> ownerId,
      Value<Uint8List?> logoBytes,
      Value<Uint8List?> signatureBytes,
      Value<String> primaryColor,
      Value<String> secondaryColor,
      Value<String> accentColor,
      Value<String?> tagline,
      Value<String?> footer,
      Value<String> template,
      Value<String?> tradingName,
      Value<String?> contactPhone,
      Value<String?> contactWhatsapp,
      Value<String?> contactEmail,
      Value<String?> contactAddress,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BrandProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $BrandProfilesTable> {
  $$BrandProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get logoBytes => $composableBuilder(
    column: $table.logoBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get signatureBytes => $composableBuilder(
    column: $table.signatureBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get secondaryColor => $composableBuilder(
    column: $table.secondaryColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get footer => $composableBuilder(
    column: $table.footer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tradingName => $composableBuilder(
    column: $table.tradingName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactWhatsapp => $composableBuilder(
    column: $table.contactWhatsapp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contactAddress => $composableBuilder(
    column: $table.contactAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BrandProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $BrandProfilesTable> {
  $$BrandProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get logoBytes => $composableBuilder(
    column: $table.logoBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get signatureBytes => $composableBuilder(
    column: $table.signatureBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get secondaryColor => $composableBuilder(
    column: $table.secondaryColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tagline => $composableBuilder(
    column: $table.tagline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get footer => $composableBuilder(
    column: $table.footer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tradingName => $composableBuilder(
    column: $table.tradingName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactWhatsapp => $composableBuilder(
    column: $table.contactWhatsapp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactAddress => $composableBuilder(
    column: $table.contactAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrandProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrandProfilesTable> {
  $$BrandProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<Uint8List> get logoBytes =>
      $composableBuilder(column: $table.logoBytes, builder: (column) => column);

  GeneratedColumn<Uint8List> get signatureBytes => $composableBuilder(
    column: $table.signatureBytes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get primaryColor => $composableBuilder(
    column: $table.primaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get secondaryColor => $composableBuilder(
    column: $table.secondaryColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accentColor => $composableBuilder(
    column: $table.accentColor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get tagline =>
      $composableBuilder(column: $table.tagline, builder: (column) => column);

  GeneratedColumn<String> get footer =>
      $composableBuilder(column: $table.footer, builder: (column) => column);

  GeneratedColumn<String> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<String> get tradingName => $composableBuilder(
    column: $table.tradingName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactPhone => $composableBuilder(
    column: $table.contactPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactWhatsapp => $composableBuilder(
    column: $table.contactWhatsapp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactEmail => $composableBuilder(
    column: $table.contactEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contactAddress => $composableBuilder(
    column: $table.contactAddress,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BrandProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrandProfilesTable,
          BrandProfileRow,
          $$BrandProfilesTableFilterComposer,
          $$BrandProfilesTableOrderingComposer,
          $$BrandProfilesTableAnnotationComposer,
          $$BrandProfilesTableCreateCompanionBuilder,
          $$BrandProfilesTableUpdateCompanionBuilder,
          (
            BrandProfileRow,
            BaseReferences<_$AppDatabase, $BrandProfilesTable, BrandProfileRow>,
          ),
          BrandProfileRow,
          PrefetchHooks Function()
        > {
  $$BrandProfilesTableTableManager(_$AppDatabase db, $BrandProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrandProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrandProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrandProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerType = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<Uint8List?> logoBytes = const Value.absent(),
                Value<Uint8List?> signatureBytes = const Value.absent(),
                Value<String> primaryColor = const Value.absent(),
                Value<String> secondaryColor = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<String?> tagline = const Value.absent(),
                Value<String?> footer = const Value.absent(),
                Value<String> template = const Value.absent(),
                Value<String?> tradingName = const Value.absent(),
                Value<String?> contactPhone = const Value.absent(),
                Value<String?> contactWhatsapp = const Value.absent(),
                Value<String?> contactEmail = const Value.absent(),
                Value<String?> contactAddress = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrandProfilesCompanion(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                logoBytes: logoBytes,
                signatureBytes: signatureBytes,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                accentColor: accentColor,
                tagline: tagline,
                footer: footer,
                template: template,
                tradingName: tradingName,
                contactPhone: contactPhone,
                contactWhatsapp: contactWhatsapp,
                contactEmail: contactEmail,
                contactAddress: contactAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerType,
                required String ownerId,
                Value<Uint8List?> logoBytes = const Value.absent(),
                Value<Uint8List?> signatureBytes = const Value.absent(),
                Value<String> primaryColor = const Value.absent(),
                Value<String> secondaryColor = const Value.absent(),
                Value<String> accentColor = const Value.absent(),
                Value<String?> tagline = const Value.absent(),
                Value<String?> footer = const Value.absent(),
                Value<String> template = const Value.absent(),
                Value<String?> tradingName = const Value.absent(),
                Value<String?> contactPhone = const Value.absent(),
                Value<String?> contactWhatsapp = const Value.absent(),
                Value<String?> contactEmail = const Value.absent(),
                Value<String?> contactAddress = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BrandProfilesCompanion.insert(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                logoBytes: logoBytes,
                signatureBytes: signatureBytes,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                accentColor: accentColor,
                tagline: tagline,
                footer: footer,
                template: template,
                tradingName: tradingName,
                contactPhone: contactPhone,
                contactWhatsapp: contactWhatsapp,
                contactEmail: contactEmail,
                contactAddress: contactAddress,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BrandProfilesTable, BrandProfileRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BrandProfilesTable,
                    BrandProfileRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BrandProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrandProfilesTable,
      BrandProfileRow,
      $$BrandProfilesTableFilterComposer,
      $$BrandProfilesTableOrderingComposer,
      $$BrandProfilesTableAnnotationComposer,
      $$BrandProfilesTableCreateCompanionBuilder,
      $$BrandProfilesTableUpdateCompanionBuilder,
      (
        BrandProfileRow,
        BaseReferences<_$AppDatabase, $BrandProfilesTable, BrandProfileRow>,
      ),
      BrandProfileRow,
      PrefetchHooks Function()
    >;
typedef $$BankAccountsTableCreateCompanionBuilder =
    BankAccountsCompanion Function({
      required String id,
      required String businessId,
      required String bankName,
      required String accountName,
      required String accountNumber,
      Value<String?> label,
      Value<bool> isDefault,
      Value<bool> isActive,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$BankAccountsTableUpdateCompanionBuilder =
    BankAccountsCompanion Function({
      Value<String> id,
      Value<String> businessId,
      Value<String> bankName,
      Value<String> accountName,
      Value<String> accountNumber,
      Value<String?> label,
      Value<bool> isDefault,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$BankAccountsTableReferences
    extends BaseReferences<_$AppDatabase, $BankAccountsTable, BankAccountRow> {
  $$BankAccountsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BusinessesTable _businessIdTable(_$AppDatabase db) =>
      db.businesses.createAlias('bank_accounts__business_id__businesses__id');

  $$BusinessesTableProcessedTableManager get businessId {
    final $_column = $_itemColumn<String>('business_id')!;

    final manager = $$BusinessesTableTableManager(
      $_db,
      $_db.businesses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_businessIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ServicesTable, List<ServiceRow>>
  _servicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.services,
    aliasName: 'bank_accounts__id__services__bank_account_id',
  );

  $$ServicesTableProcessedTableManager get servicesRefs {
    final manager = $$ServicesTableTableManager(
      $_db,
      $_db.services,
    ).filter((f) => f.bankAccountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_servicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<InvoiceRow>>
  _invoicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'bank_accounts__id__invoices__bank_account_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.bankAccountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentRow>>
  _paymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'bank_accounts__id__payments__bank_account_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.bankAccountId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$BankAccountsTableFilterComposer
    extends Composer<_$AppDatabase, $BankAccountsTable> {
  $$BankAccountsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountName => $composableBuilder(
    column: $table.accountName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BusinessesTableFilterComposer get businessId {
    final $$BusinessesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableFilterComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> servicesRefs(
    Expression<bool> Function($$ServicesTableFilterComposer f) f,
  ) {
    final $$ServicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.bankAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableFilterComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.bankAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.bankAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BankAccountsTableOrderingComposer
    extends Composer<_$AppDatabase, $BankAccountsTable> {
  $$BankAccountsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankName => $composableBuilder(
    column: $table.bankName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountName => $composableBuilder(
    column: $table.accountName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BusinessesTableOrderingComposer get businessId {
    final $$BusinessesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableOrderingComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$BankAccountsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BankAccountsTable> {
  $$BankAccountsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get bankName =>
      $composableBuilder(column: $table.bankName, builder: (column) => column);

  GeneratedColumn<String> get accountName => $composableBuilder(
    column: $table.accountName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accountNumber => $composableBuilder(
    column: $table.accountNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$BusinessesTableAnnotationComposer get businessId {
    final $$BusinessesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableAnnotationComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> servicesRefs<T extends Object>(
    Expression<T> Function($$ServicesTableAnnotationComposer a) f,
  ) {
    final $$ServicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.bankAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableAnnotationComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.bankAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.bankAccountId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$BankAccountsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BankAccountsTable,
          BankAccountRow,
          $$BankAccountsTableFilterComposer,
          $$BankAccountsTableOrderingComposer,
          $$BankAccountsTableAnnotationComposer,
          $$BankAccountsTableCreateCompanionBuilder,
          $$BankAccountsTableUpdateCompanionBuilder,
          (BankAccountRow, $$BankAccountsTableReferences),
          BankAccountRow,
          PrefetchHooks Function({
            bool businessId,
            bool servicesRefs,
            bool invoicesRefs,
            bool paymentsRefs,
          })
        > {
  $$BankAccountsTableTableManager(_$AppDatabase db, $BankAccountsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BankAccountsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BankAccountsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BankAccountsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> bankName = const Value.absent(),
                Value<String> accountName = const Value.absent(),
                Value<String> accountNumber = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BankAccountsCompanion(
                id: id,
                businessId: businessId,
                bankName: bankName,
                accountName: accountName,
                accountNumber: accountNumber,
                label: label,
                isDefault: isDefault,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String businessId,
                required String bankName,
                required String accountName,
                required String accountNumber,
                Value<String?> label = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => BankAccountsCompanion.insert(
                id: id,
                businessId: businessId,
                bankName: bankName,
                accountName: accountName,
                accountNumber: accountNumber,
                label: label,
                isDefault: isDefault,
                isActive: isActive,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BankAccountsTable, BankAccountRow>(table),
                  $$BankAccountsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                businessId = false,
                servicesRefs = false,
                invoicesRefs = false,
                paymentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (servicesRefs) db.services,
                    if (invoicesRefs) db.invoices,
                    if (paymentsRefs) db.payments,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (businessId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.businessId,
                            referencedTable: $$BankAccountsTableReferences
                                ._businessIdTable(db),
                            referencedColumn: $$BankAccountsTableReferences
                                ._businessIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (servicesRefs)
                        await $_getPrefetchedDataByColumns<
                          BankAccountRow,
                          $BankAccountsTable,
                          ServiceRow,
                          $ServicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$BankAccountsTableReferences
                              ._servicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BankAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).servicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_account_id',
                          typedResults: items,
                        ),
                      if (invoicesRefs)
                        await $_getPrefetchedDataByColumns<
                          BankAccountRow,
                          $BankAccountsTable,
                          InvoiceRow,
                          $InvoicesTable
                        >(
                          currentTable: table,
                          referencedTable: $$BankAccountsTableReferences
                              ._invoicesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BankAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).invoicesRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_account_id',
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedDataByColumns<
                          BankAccountRow,
                          $BankAccountsTable,
                          PaymentRow,
                          $PaymentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$BankAccountsTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$BankAccountsTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'bank_account_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$BankAccountsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BankAccountsTable,
      BankAccountRow,
      $$BankAccountsTableFilterComposer,
      $$BankAccountsTableOrderingComposer,
      $$BankAccountsTableAnnotationComposer,
      $$BankAccountsTableCreateCompanionBuilder,
      $$BankAccountsTableUpdateCompanionBuilder,
      (BankAccountRow, $$BankAccountsTableReferences),
      BankAccountRow,
      PrefetchHooks Function({
        bool businessId,
        bool servicesRefs,
        bool invoicesRefs,
        bool paymentsRefs,
      })
    >;
typedef $$ServicesTableCreateCompanionBuilder = ServicesCompanion Function({
  required String id,
  required String businessId,
  required String name,
  Value<String> description,
  Value<String> category,
  Value<int> defaultPriceMinor,
  Value<String> unit,
  Value<String?> customUnit,
  Value<String> currency,
  Value<String?> bankAccountId,
  Value<bool> isActive,
  Value<String> brandingMode,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$ServicesTableUpdateCompanionBuilder = ServicesCompanion Function({
  Value<String> id,
  Value<String> businessId,
  Value<String> name,
  Value<String> description,
  Value<String> category,
  Value<int> defaultPriceMinor,
  Value<String> unit,
  Value<String?> customUnit,
  Value<String> currency,
  Value<String?> bankAccountId,
  Value<bool> isActive,
  Value<String> brandingMode,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$ServicesTableReferences
    extends BaseReferences<_$AppDatabase, $ServicesTable, ServiceRow> {
  $$ServicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BusinessesTable _businessIdTable(_$AppDatabase db) =>
      db.businesses.createAlias('services__business_id__businesses__id');

  $$BusinessesTableProcessedTableManager get businessId {
    final $_column = $_itemColumn<String>('business_id')!;

    final manager = $$BusinessesTableTableManager(
      $_db,
      $_db.businesses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_businessIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BankAccountsTable _bankAccountIdTable(_$AppDatabase db) => db
      .bankAccounts
      .createAlias('services__bank_account_id__bank_accounts__id');

  $$BankAccountsTableProcessedTableManager? get bankAccountId {
    final $_column = $_itemColumn<String>('bank_account_id');
    if ($_column == null) return null;
    final manager = $$BankAccountsTableTableManager(
      $_db,
      $_db.bankAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItemRow>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: 'services__id__invoice_items__service_id',
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.serviceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ServicesTableFilterComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultPriceMinor => $composableBuilder(
    column: $table.defaultPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customUnit => $composableBuilder(
    column: $table.customUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brandingMode => $composableBuilder(
    column: $table.brandingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BusinessesTableFilterComposer get businessId {
    final $$BusinessesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableFilterComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableFilterComposer get bankAccountId {
    final $$BankAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableFilterComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.serviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServicesTableOrderingComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultPriceMinor => $composableBuilder(
    column: $table.defaultPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customUnit => $composableBuilder(
    column: $table.customUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brandingMode => $composableBuilder(
    column: $table.brandingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BusinessesTableOrderingComposer get businessId {
    final $$BusinessesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableOrderingComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableOrderingComposer get bankAccountId {
    final $$BankAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ServicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ServicesTable> {
  $$ServicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<int> get defaultPriceMinor => $composableBuilder(
    column: $table.defaultPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get customUnit => $composableBuilder(
    column: $table.customUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<String> get brandingMode => $composableBuilder(
    column: $table.brandingMode,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BusinessesTableAnnotationComposer get businessId {
    final $$BusinessesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableAnnotationComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableAnnotationComposer get bankAccountId {
    final $$BankAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.serviceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ServicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ServicesTable,
          ServiceRow,
          $$ServicesTableFilterComposer,
          $$ServicesTableOrderingComposer,
          $$ServicesTableAnnotationComposer,
          $$ServicesTableCreateCompanionBuilder,
          $$ServicesTableUpdateCompanionBuilder,
          (ServiceRow, $$ServicesTableReferences),
          ServiceRow,
          PrefetchHooks Function({
            bool businessId,
            bool bankAccountId,
            bool invoiceItemsRefs,
          })
        > {
  $$ServicesTableTableManager(_$AppDatabase db, $ServicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ServicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ServicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ServicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> defaultPriceMinor = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> customUnit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> bankAccountId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> brandingMode = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ServicesCompanion(
                id: id,
                businessId: businessId,
                name: name,
                description: description,
                category: category,
                defaultPriceMinor: defaultPriceMinor,
                unit: unit,
                customUnit: customUnit,
                currency: currency,
                bankAccountId: bankAccountId,
                isActive: isActive,
                brandingMode: brandingMode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String businessId,
                required String name,
                Value<String> description = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<int> defaultPriceMinor = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> customUnit = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> bankAccountId = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<String> brandingMode = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ServicesCompanion.insert(
                id: id,
                businessId: businessId,
                name: name,
                description: description,
                category: category,
                defaultPriceMinor: defaultPriceMinor,
                unit: unit,
                customUnit: customUnit,
                currency: currency,
                bankAccountId: bankAccountId,
                isActive: isActive,
                brandingMode: brandingMode,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ServicesTable, ServiceRow>(table),
                  $$ServicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                businessId = false,
                bankAccountId = false,
                invoiceItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (businessId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.businessId,
                            referencedTable: $$ServicesTableReferences
                                ._businessIdTable(db),
                            referencedColumn: $$ServicesTableReferences
                                ._businessIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (bankAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bankAccountId,
                            referencedTable: $$ServicesTableReferences
                                ._bankAccountIdTable(db),
                            referencedColumn: $$ServicesTableReferences
                                ._bankAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          ServiceRow,
                          $ServicesTable,
                          InvoiceItemRow,
                          $InvoiceItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ServicesTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ServicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'service_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ServicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ServicesTable,
      ServiceRow,
      $$ServicesTableFilterComposer,
      $$ServicesTableOrderingComposer,
      $$ServicesTableAnnotationComposer,
      $$ServicesTableCreateCompanionBuilder,
      $$ServicesTableUpdateCompanionBuilder,
      (ServiceRow, $$ServicesTableReferences),
      ServiceRow,
      PrefetchHooks Function({
        bool businessId,
        bool bankAccountId,
        bool invoiceItemsRefs,
      })
    >;
typedef $$CustomersTableCreateCompanionBuilder = CustomersCompanion Function({
  required String id,
  required String businessId,
  required String name,
  Value<String> phone,
  Value<String> whatsapp,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$CustomersTableUpdateCompanionBuilder = CustomersCompanion Function({
  Value<String> id,
  Value<String> businessId,
  Value<String> name,
  Value<String> phone,
  Value<String> whatsapp,
  Value<String?> email,
  Value<String?> address,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$CustomersTableReferences
    extends BaseReferences<_$AppDatabase, $CustomersTable, CustomerRow> {
  $$CustomersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BusinessesTable _businessIdTable(_$AppDatabase db) =>
      db.businesses.createAlias('customers__business_id__businesses__id');

  $$BusinessesTableProcessedTableManager get businessId {
    final $_column = $_itemColumn<String>('business_id')!;

    final manager = $$BusinessesTableTableManager(
      $_db,
      $_db.businesses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_businessIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoicesTable, List<InvoiceRow>>
  _invoicesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoices,
    aliasName: 'customers__id__invoices__customer_id',
  );

  $$InvoicesTableProcessedTableManager get invoicesRefs {
    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoicesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CustomersTableFilterComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get whatsapp => $composableBuilder(
    column: $table.whatsapp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BusinessesTableFilterComposer get businessId {
    final $$BusinessesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableFilterComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoicesRefs(
    Expression<bool> Function($$InvoicesTableFilterComposer f) f,
  ) {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phone => $composableBuilder(
    column: $table.phone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get whatsapp => $composableBuilder(
    column: $table.whatsapp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BusinessesTableOrderingComposer get businessId {
    final $$BusinessesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableOrderingComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $CustomersTable> {
  $$CustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get whatsapp =>
      $composableBuilder(column: $table.whatsapp, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BusinessesTableAnnotationComposer get businessId {
    final $$BusinessesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableAnnotationComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoicesRefs<T extends Object>(
    Expression<T> Function($$InvoicesTableAnnotationComposer a) f,
  ) {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.customerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CustomersTable,
          CustomerRow,
          $$CustomersTableFilterComposer,
          $$CustomersTableOrderingComposer,
          $$CustomersTableAnnotationComposer,
          $$CustomersTableCreateCompanionBuilder,
          $$CustomersTableUpdateCompanionBuilder,
          (CustomerRow, $$CustomersTableReferences),
          CustomerRow,
          PrefetchHooks Function({bool businessId, bool invoicesRefs})
        > {
  $$CustomersTableTableManager(_$AppDatabase db, $CustomersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> phone = const Value.absent(),
                Value<String> whatsapp = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion(
                id: id,
                businessId: businessId,
                name: name,
                phone: phone,
                whatsapp: whatsapp,
                email: email,
                address: address,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String businessId,
                required String name,
                Value<String> phone = const Value.absent(),
                Value<String> whatsapp = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CustomersCompanion.insert(
                id: id,
                businessId: businessId,
                name: name,
                phone: phone,
                whatsapp: whatsapp,
                email: email,
                address: address,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CustomersTable, CustomerRow>(table),
                  $$CustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({businessId = false, invoicesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (invoicesRefs) db.invoices],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (businessId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.businessId,
                        referencedTable: $$CustomersTableReferences
                            ._businessIdTable(db),
                        referencedColumn: $$CustomersTableReferences
                            ._businessIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (invoicesRefs)
                    await $_getPrefetchedDataByColumns<
                      CustomerRow,
                      $CustomersTable,
                      InvoiceRow,
                      $InvoicesTable
                    >(
                      currentTable: table,
                      referencedTable: $$CustomersTableReferences
                          ._invoicesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CustomersTableReferences(
                            db,
                            table,
                            p0,
                          ).invoicesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'customer_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CustomersTable,
      CustomerRow,
      $$CustomersTableFilterComposer,
      $$CustomersTableOrderingComposer,
      $$CustomersTableAnnotationComposer,
      $$CustomersTableCreateCompanionBuilder,
      $$CustomersTableUpdateCompanionBuilder,
      (CustomerRow, $$CustomersTableReferences),
      CustomerRow,
      PrefetchHooks Function({bool businessId, bool invoicesRefs})
    >;
typedef $$InvoicesTableCreateCompanionBuilder = InvoicesCompanion Function({
  required String id,
  required String businessId,
  Value<String?> number,
  required String status,
  required DateTime issueDate,
  required DateTime dueDate,
  Value<String?> customerId,
  required String customerName,
  Value<String> customerPhone,
  Value<String> customerWhatsapp,
  Value<String?> customerEmail,
  Value<String?> customerAddress,
  Value<bool> customerSaved,
  Value<int> discountMinor,
  Value<int> taxRateBps,
  Value<int> taxMinor,
  Value<int> chargesMinor,
  Value<int> subtotalMinor,
  Value<int> grandTotalMinor,
  Value<String> currency,
  Value<String?> bankAccountId,
  Value<String?> bankSnapshot,
  Value<String?> brandingSnapshot,
  Value<String> paymentInstructions,
  Value<String?> notes,
  Value<String?> terms,
  Value<String> termsPreset,
  Value<String> template,
  Value<DateTime?> issuedAt,
  Value<DateTime?> settledAt,
  Value<DateTime?> cancelledAt,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<int> rowid,
});
typedef $$InvoicesTableUpdateCompanionBuilder = InvoicesCompanion Function({
  Value<String> id,
  Value<String> businessId,
  Value<String?> number,
  Value<String> status,
  Value<DateTime> issueDate,
  Value<DateTime> dueDate,
  Value<String?> customerId,
  Value<String> customerName,
  Value<String> customerPhone,
  Value<String> customerWhatsapp,
  Value<String?> customerEmail,
  Value<String?> customerAddress,
  Value<bool> customerSaved,
  Value<int> discountMinor,
  Value<int> taxRateBps,
  Value<int> taxMinor,
  Value<int> chargesMinor,
  Value<int> subtotalMinor,
  Value<int> grandTotalMinor,
  Value<String> currency,
  Value<String?> bankAccountId,
  Value<String?> bankSnapshot,
  Value<String?> brandingSnapshot,
  Value<String> paymentInstructions,
  Value<String?> notes,
  Value<String?> terms,
  Value<String> termsPreset,
  Value<String> template,
  Value<DateTime?> issuedAt,
  Value<DateTime?> settledAt,
  Value<DateTime?> cancelledAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$InvoicesTableReferences
    extends BaseReferences<_$AppDatabase, $InvoicesTable, InvoiceRow> {
  $$InvoicesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $BusinessesTable _businessIdTable(_$AppDatabase db) =>
      db.businesses.createAlias('invoices__business_id__businesses__id');

  $$BusinessesTableProcessedTableManager get businessId {
    final $_column = $_itemColumn<String>('business_id')!;

    final manager = $$BusinessesTableTableManager(
      $_db,
      $_db.businesses,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_businessIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $CustomersTable _customerIdTable(_$AppDatabase db) =>
      db.customers.createAlias('invoices__customer_id__customers__id');

  $$CustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<String>('customer_id');
    if ($_column == null) return null;
    final manager = $$CustomersTableTableManager(
      $_db,
      $_db.customers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BankAccountsTable _bankAccountIdTable(_$AppDatabase db) => db
      .bankAccounts
      .createAlias('invoices__bank_account_id__bank_accounts__id');

  $$BankAccountsTableProcessedTableManager? get bankAccountId {
    final $_column = $_itemColumn<String>('bank_account_id');
    if ($_column == null) return null;
    final manager = $$BankAccountsTableTableManager(
      $_db,
      $_db.bankAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$InvoiceItemsTable, List<InvoiceItemRow>>
  _invoiceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.invoiceItems,
    aliasName: 'invoices__id__invoice_items__invoice_id',
  );

  $$InvoiceItemsTableProcessedTableManager get invoiceItemsRefs {
    final manager = $$InvoiceItemsTableTableManager(
      $_db,
      $_db.invoiceItems,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_invoiceItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PaymentsTable, List<PaymentRow>>
  _paymentsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.payments,
    aliasName: 'invoices__id__payments__invoice_id',
  );

  $$PaymentsTableProcessedTableManager get paymentsRefs {
    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_paymentsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReceiptsTable, List<ReceiptRow>>
  _receiptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: 'invoices__id__receipts__invoice_id',
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<ReminderRow>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'invoices__id__reminders__invoice_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.invoiceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$InvoicesTableFilterComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerWhatsapp => $composableBuilder(
    column: $table.customerWhatsapp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerEmail => $composableBuilder(
    column: $table.customerEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerAddress => $composableBuilder(
    column: $table.customerAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get customerSaved => $composableBuilder(
    column: $table.customerSaved,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get discountMinor => $composableBuilder(
    column: $table.discountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxRateBps => $composableBuilder(
    column: $table.taxRateBps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get taxMinor => $composableBuilder(
    column: $table.taxMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get chargesMinor => $composableBuilder(
    column: $table.chargesMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalMinor => $composableBuilder(
    column: $table.subtotalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get grandTotalMinor => $composableBuilder(
    column: $table.grandTotalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get bankSnapshot => $composableBuilder(
    column: $table.bankSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brandingSnapshot => $composableBuilder(
    column: $table.brandingSnapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get terms => $composableBuilder(
    column: $table.terms,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get termsPreset => $composableBuilder(
    column: $table.termsPreset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$BusinessesTableFilterComposer get businessId {
    final $$BusinessesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableFilterComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableFilterComposer get customerId {
    final $$CustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableFilterComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableFilterComposer get bankAccountId {
    final $$BankAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableFilterComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> invoiceItemsRefs(
    Expression<bool> Function($$InvoiceItemsTableFilterComposer f) f,
  ) {
    final $$InvoiceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableFilterComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> paymentsRefs(
    Expression<bool> Function($$PaymentsTableFilterComposer f) f,
  ) {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issueDate => $composableBuilder(
    column: $table.issueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dueDate => $composableBuilder(
    column: $table.dueDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerWhatsapp => $composableBuilder(
    column: $table.customerWhatsapp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerEmail => $composableBuilder(
    column: $table.customerEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerAddress => $composableBuilder(
    column: $table.customerAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get customerSaved => $composableBuilder(
    column: $table.customerSaved,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get discountMinor => $composableBuilder(
    column: $table.discountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxRateBps => $composableBuilder(
    column: $table.taxRateBps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get taxMinor => $composableBuilder(
    column: $table.taxMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get chargesMinor => $composableBuilder(
    column: $table.chargesMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalMinor => $composableBuilder(
    column: $table.subtotalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get grandTotalMinor => $composableBuilder(
    column: $table.grandTotalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currency => $composableBuilder(
    column: $table.currency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get bankSnapshot => $composableBuilder(
    column: $table.bankSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brandingSnapshot => $composableBuilder(
    column: $table.brandingSnapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get terms => $composableBuilder(
    column: $table.terms,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get termsPreset => $composableBuilder(
    column: $table.termsPreset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get template => $composableBuilder(
    column: $table.template,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get settledAt => $composableBuilder(
    column: $table.settledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$BusinessesTableOrderingComposer get businessId {
    final $$BusinessesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableOrderingComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableOrderingComposer get customerId {
    final $$CustomersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableOrderingComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableOrderingComposer get bankAccountId {
    final $$BankAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoicesTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoicesTable> {
  $$InvoicesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get issueDate =>
      $composableBuilder(column: $table.issueDate, builder: (column) => column);

  GeneratedColumn<DateTime> get dueDate =>
      $composableBuilder(column: $table.dueDate, builder: (column) => column);

  GeneratedColumn<String> get customerName => $composableBuilder(
    column: $table.customerName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerPhone => $composableBuilder(
    column: $table.customerPhone,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerWhatsapp => $composableBuilder(
    column: $table.customerWhatsapp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerEmail => $composableBuilder(
    column: $table.customerEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerAddress => $composableBuilder(
    column: $table.customerAddress,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get customerSaved => $composableBuilder(
    column: $table.customerSaved,
    builder: (column) => column,
  );

  GeneratedColumn<int> get discountMinor => $composableBuilder(
    column: $table.discountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxRateBps => $composableBuilder(
    column: $table.taxRateBps,
    builder: (column) => column,
  );

  GeneratedColumn<int> get taxMinor =>
      $composableBuilder(column: $table.taxMinor, builder: (column) => column);

  GeneratedColumn<int> get chargesMinor => $composableBuilder(
    column: $table.chargesMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalMinor => $composableBuilder(
    column: $table.subtotalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get grandTotalMinor => $composableBuilder(
    column: $table.grandTotalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currency =>
      $composableBuilder(column: $table.currency, builder: (column) => column);

  GeneratedColumn<String> get bankSnapshot => $composableBuilder(
    column: $table.bankSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brandingSnapshot => $composableBuilder(
    column: $table.brandingSnapshot,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentInstructions => $composableBuilder(
    column: $table.paymentInstructions,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get terms =>
      $composableBuilder(column: $table.terms, builder: (column) => column);

  GeneratedColumn<String> get termsPreset => $composableBuilder(
    column: $table.termsPreset,
    builder: (column) => column,
  );

  GeneratedColumn<String> get template =>
      $composableBuilder(column: $table.template, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get settledAt =>
      $composableBuilder(column: $table.settledAt, builder: (column) => column);

  GeneratedColumn<DateTime> get cancelledAt => $composableBuilder(
    column: $table.cancelledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$BusinessesTableAnnotationComposer get businessId {
    final $$BusinessesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.businessId,
      referencedTable: $db.businesses,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BusinessesTableAnnotationComposer(
            $db: $db,
            $table: $db.businesses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$CustomersTableAnnotationComposer get customerId {
    final $$CustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.customerId,
      referencedTable: $db.customers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.customers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableAnnotationComposer get bankAccountId {
    final $$BankAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> invoiceItemsRefs<T extends Object>(
    Expression<T> Function($$InvoiceItemsTableAnnotationComposer a) f,
  ) {
    final $$InvoiceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.invoiceItems,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoiceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.invoiceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> paymentsRefs<T extends Object>(
    Expression<T> Function($$PaymentsTableAnnotationComposer a) f,
  ) {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.invoiceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$InvoicesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoicesTable,
          InvoiceRow,
          $$InvoicesTableFilterComposer,
          $$InvoicesTableOrderingComposer,
          $$InvoicesTableAnnotationComposer,
          $$InvoicesTableCreateCompanionBuilder,
          $$InvoicesTableUpdateCompanionBuilder,
          (InvoiceRow, $$InvoicesTableReferences),
          InvoiceRow,
          PrefetchHooks Function({
            bool businessId,
            bool customerId,
            bool bankAccountId,
            bool invoiceItemsRefs,
            bool paymentsRefs,
            bool receiptsRefs,
            bool remindersRefs,
          })
        > {
  $$InvoicesTableTableManager(_$AppDatabase db, $InvoicesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoicesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoicesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoicesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> businessId = const Value.absent(),
                Value<String?> number = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> issueDate = const Value.absent(),
                Value<DateTime> dueDate = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<String> customerName = const Value.absent(),
                Value<String> customerPhone = const Value.absent(),
                Value<String> customerWhatsapp = const Value.absent(),
                Value<String?> customerEmail = const Value.absent(),
                Value<String?> customerAddress = const Value.absent(),
                Value<bool> customerSaved = const Value.absent(),
                Value<int> discountMinor = const Value.absent(),
                Value<int> taxRateBps = const Value.absent(),
                Value<int> taxMinor = const Value.absent(),
                Value<int> chargesMinor = const Value.absent(),
                Value<int> subtotalMinor = const Value.absent(),
                Value<int> grandTotalMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> bankAccountId = const Value.absent(),
                Value<String?> bankSnapshot = const Value.absent(),
                Value<String?> brandingSnapshot = const Value.absent(),
                Value<String> paymentInstructions = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> terms = const Value.absent(),
                Value<String> termsPreset = const Value.absent(),
                Value<String> template = const Value.absent(),
                Value<DateTime?> issuedAt = const Value.absent(),
                Value<DateTime?> settledAt = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion(
                id: id,
                businessId: businessId,
                number: number,
                status: status,
                issueDate: issueDate,
                dueDate: dueDate,
                customerId: customerId,
                customerName: customerName,
                customerPhone: customerPhone,
                customerWhatsapp: customerWhatsapp,
                customerEmail: customerEmail,
                customerAddress: customerAddress,
                customerSaved: customerSaved,
                discountMinor: discountMinor,
                taxRateBps: taxRateBps,
                taxMinor: taxMinor,
                chargesMinor: chargesMinor,
                subtotalMinor: subtotalMinor,
                grandTotalMinor: grandTotalMinor,
                currency: currency,
                bankAccountId: bankAccountId,
                bankSnapshot: bankSnapshot,
                brandingSnapshot: brandingSnapshot,
                paymentInstructions: paymentInstructions,
                notes: notes,
                terms: terms,
                termsPreset: termsPreset,
                template: template,
                issuedAt: issuedAt,
                settledAt: settledAt,
                cancelledAt: cancelledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String businessId,
                Value<String?> number = const Value.absent(),
                required String status,
                required DateTime issueDate,
                required DateTime dueDate,
                Value<String?> customerId = const Value.absent(),
                required String customerName,
                Value<String> customerPhone = const Value.absent(),
                Value<String> customerWhatsapp = const Value.absent(),
                Value<String?> customerEmail = const Value.absent(),
                Value<String?> customerAddress = const Value.absent(),
                Value<bool> customerSaved = const Value.absent(),
                Value<int> discountMinor = const Value.absent(),
                Value<int> taxRateBps = const Value.absent(),
                Value<int> taxMinor = const Value.absent(),
                Value<int> chargesMinor = const Value.absent(),
                Value<int> subtotalMinor = const Value.absent(),
                Value<int> grandTotalMinor = const Value.absent(),
                Value<String> currency = const Value.absent(),
                Value<String?> bankAccountId = const Value.absent(),
                Value<String?> bankSnapshot = const Value.absent(),
                Value<String?> brandingSnapshot = const Value.absent(),
                Value<String> paymentInstructions = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> terms = const Value.absent(),
                Value<String> termsPreset = const Value.absent(),
                Value<String> template = const Value.absent(),
                Value<DateTime?> issuedAt = const Value.absent(),
                Value<DateTime?> settledAt = const Value.absent(),
                Value<DateTime?> cancelledAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => InvoicesCompanion.insert(
                id: id,
                businessId: businessId,
                number: number,
                status: status,
                issueDate: issueDate,
                dueDate: dueDate,
                customerId: customerId,
                customerName: customerName,
                customerPhone: customerPhone,
                customerWhatsapp: customerWhatsapp,
                customerEmail: customerEmail,
                customerAddress: customerAddress,
                customerSaved: customerSaved,
                discountMinor: discountMinor,
                taxRateBps: taxRateBps,
                taxMinor: taxMinor,
                chargesMinor: chargesMinor,
                subtotalMinor: subtotalMinor,
                grandTotalMinor: grandTotalMinor,
                currency: currency,
                bankAccountId: bankAccountId,
                bankSnapshot: bankSnapshot,
                brandingSnapshot: brandingSnapshot,
                paymentInstructions: paymentInstructions,
                notes: notes,
                terms: terms,
                termsPreset: termsPreset,
                template: template,
                issuedAt: issuedAt,
                settledAt: settledAt,
                cancelledAt: cancelledAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoicesTable, InvoiceRow>(table),
                  $$InvoicesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                businessId = false,
                customerId = false,
                bankAccountId = false,
                invoiceItemsRefs = false,
                paymentsRefs = false,
                receiptsRefs = false,
                remindersRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (invoiceItemsRefs) db.invoiceItems,
                    if (paymentsRefs) db.payments,
                    if (receiptsRefs) db.receipts,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (businessId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.businessId,
                            referencedTable: $$InvoicesTableReferences
                                ._businessIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._businessIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (customerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.customerId,
                            referencedTable: $$InvoicesTableReferences
                                ._customerIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._customerIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (bankAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bankAccountId,
                            referencedTable: $$InvoicesTableReferences
                                ._bankAccountIdTable(db),
                            referencedColumn: $$InvoicesTableReferences
                                ._bankAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (invoiceItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          InvoiceRow,
                          $InvoicesTable,
                          InvoiceItemRow,
                          $InvoiceItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._invoiceItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).invoiceItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'invoice_id',
                          typedResults: items,
                        ),
                      if (paymentsRefs)
                        await $_getPrefetchedDataByColumns<
                          InvoiceRow,
                          $InvoicesTable,
                          PaymentRow,
                          $PaymentsTable
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._paymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).paymentsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'invoice_id',
                          typedResults: items,
                        ),
                      if (receiptsRefs)
                        await $_getPrefetchedDataByColumns<
                          InvoiceRow,
                          $InvoicesTable,
                          ReceiptRow,
                          $ReceiptsTable
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._receiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'invoice_id',
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedDataByColumns<
                          InvoiceRow,
                          $InvoicesTable,
                          ReminderRow,
                          $RemindersTable
                        >(
                          currentTable: table,
                          referencedTable: $$InvoicesTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$InvoicesTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'invoice_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$InvoicesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoicesTable,
      InvoiceRow,
      $$InvoicesTableFilterComposer,
      $$InvoicesTableOrderingComposer,
      $$InvoicesTableAnnotationComposer,
      $$InvoicesTableCreateCompanionBuilder,
      $$InvoicesTableUpdateCompanionBuilder,
      (InvoiceRow, $$InvoicesTableReferences),
      InvoiceRow,
      PrefetchHooks Function({
        bool businessId,
        bool customerId,
        bool bankAccountId,
        bool invoiceItemsRefs,
        bool paymentsRefs,
        bool receiptsRefs,
        bool remindersRefs,
      })
    >;
typedef $$InvoiceItemsTableCreateCompanionBuilder =
    InvoiceItemsCompanion Function({
      required String id,
      required String invoiceId,
      Value<String?> serviceId,
      required String name,
      Value<String> description,
      required int quantityMilli,
      required String unit,
      Value<String?> customUnit,
      required int unitPriceMinor,
      required int lineTotalMinor,
      Value<int> position,
      Value<int> rowid,
    });
typedef $$InvoiceItemsTableUpdateCompanionBuilder =
    InvoiceItemsCompanion Function({
      Value<String> id,
      Value<String> invoiceId,
      Value<String?> serviceId,
      Value<String> name,
      Value<String> description,
      Value<int> quantityMilli,
      Value<String> unit,
      Value<String?> customUnit,
      Value<int> unitPriceMinor,
      Value<int> lineTotalMinor,
      Value<int> position,
      Value<int> rowid,
    });

final class $$InvoiceItemsTableReferences
    extends BaseReferences<_$AppDatabase, $InvoiceItemsTable, InvoiceItemRow> {
  $$InvoiceItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('invoice_items__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ServicesTable _serviceIdTable(_$AppDatabase db) =>
      db.services.createAlias('invoice_items__service_id__services__id');

  $$ServicesTableProcessedTableManager? get serviceId {
    final $_column = $_itemColumn<String>('service_id');
    if ($_column == null) return null;
    final manager = $$ServicesTableTableManager(
      $_db,
      $_db.services,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_serviceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InvoiceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customUnit => $composableBuilder(
    column: $table.customUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get lineTotalMinor => $composableBuilder(
    column: $table.lineTotalMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServicesTableFilterComposer get serviceId {
    final $$ServicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceId,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableFilterComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customUnit => $composableBuilder(
    column: $table.customUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get lineTotalMinor => $composableBuilder(
    column: $table.lineTotalMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServicesTableOrderingComposer get serviceId {
    final $$ServicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceId,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableOrderingComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InvoiceItemsTable> {
  $$InvoiceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<int> get quantityMilli => $composableBuilder(
    column: $table.quantityMilli,
    builder: (column) => column,
  );

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get customUnit => $composableBuilder(
    column: $table.customUnit,
    builder: (column) => column,
  );

  GeneratedColumn<int> get unitPriceMinor => $composableBuilder(
    column: $table.unitPriceMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get lineTotalMinor => $composableBuilder(
    column: $table.lineTotalMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ServicesTableAnnotationComposer get serviceId {
    final $$ServicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.serviceId,
      referencedTable: $db.services,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ServicesTableAnnotationComposer(
            $db: $db,
            $table: $db.services,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InvoiceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InvoiceItemsTable,
          InvoiceItemRow,
          $$InvoiceItemsTableFilterComposer,
          $$InvoiceItemsTableOrderingComposer,
          $$InvoiceItemsTableAnnotationComposer,
          $$InvoiceItemsTableCreateCompanionBuilder,
          $$InvoiceItemsTableUpdateCompanionBuilder,
          (InvoiceItemRow, $$InvoiceItemsTableReferences),
          InvoiceItemRow,
          PrefetchHooks Function({bool invoiceId, bool serviceId})
        > {
  $$InvoiceItemsTableTableManager(_$AppDatabase db, $InvoiceItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InvoiceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InvoiceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$InvoiceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String?> serviceId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<int> quantityMilli = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String?> customUnit = const Value.absent(),
                Value<int> unitPriceMinor = const Value.absent(),
                Value<int> lineTotalMinor = const Value.absent(),
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsCompanion(
                id: id,
                invoiceId: invoiceId,
                serviceId: serviceId,
                name: name,
                description: description,
                quantityMilli: quantityMilli,
                unit: unit,
                customUnit: customUnit,
                unitPriceMinor: unitPriceMinor,
                lineTotalMinor: lineTotalMinor,
                position: position,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                Value<String?> serviceId = const Value.absent(),
                required String name,
                Value<String> description = const Value.absent(),
                required int quantityMilli,
                required String unit,
                Value<String?> customUnit = const Value.absent(),
                required int unitPriceMinor,
                required int lineTotalMinor,
                Value<int> position = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InvoiceItemsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                serviceId: serviceId,
                name: name,
                description: description,
                quantityMilli: quantityMilli,
                unit: unit,
                customUnit: customUnit,
                unitPriceMinor: unitPriceMinor,
                lineTotalMinor: lineTotalMinor,
                position: position,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$InvoiceItemsTable, InvoiceItemRow>(table),
                  $$InvoiceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false, serviceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$InvoiceItemsTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$InvoiceItemsTableReferences
                            ._invoiceIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (serviceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.serviceId,
                        referencedTable: $$InvoiceItemsTableReferences
                            ._serviceIdTable(db),
                        referencedColumn: $$InvoiceItemsTableReferences
                            ._serviceIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InvoiceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InvoiceItemsTable,
      InvoiceItemRow,
      $$InvoiceItemsTableFilterComposer,
      $$InvoiceItemsTableOrderingComposer,
      $$InvoiceItemsTableAnnotationComposer,
      $$InvoiceItemsTableCreateCompanionBuilder,
      $$InvoiceItemsTableUpdateCompanionBuilder,
      (InvoiceItemRow, $$InvoiceItemsTableReferences),
      InvoiceItemRow,
      PrefetchHooks Function({bool invoiceId, bool serviceId})
    >;
typedef $$PaymentsTableCreateCompanionBuilder = PaymentsCompanion Function({
  required String id,
  required String invoiceId,
  required String idempotencyKey,
  required int amountMinor,
  required DateTime paidAt,
  required String method,
  Value<String?> bankAccountId,
  Value<String?> reference,
  Value<String?> notes,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$PaymentsTableUpdateCompanionBuilder = PaymentsCompanion Function({
  Value<String> id,
  Value<String> invoiceId,
  Value<String> idempotencyKey,
  Value<int> amountMinor,
  Value<DateTime> paidAt,
  Value<String> method,
  Value<String?> bankAccountId,
  Value<String?> reference,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$PaymentsTableReferences
    extends BaseReferences<_$AppDatabase, $PaymentsTable, PaymentRow> {
  $$PaymentsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('payments__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $BankAccountsTable _bankAccountIdTable(_$AppDatabase db) => db
      .bankAccounts
      .createAlias('payments__bank_account_id__bank_accounts__id');

  $$BankAccountsTableProcessedTableManager? get bankAccountId {
    final $_column = $_itemColumn<String>('bank_account_id');
    if ($_column == null) return null;
    final manager = $$BankAccountsTableTableManager(
      $_db,
      $_db.bankAccounts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_bankAccountIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReceiptsTable, List<ReceiptRow>>
  _receiptsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.receipts,
    aliasName: 'payments__id__receipts__payment_id',
  );

  $$ReceiptsTableProcessedTableManager get receiptsRefs {
    final manager = $$ReceiptsTableTableManager(
      $_db,
      $_db.receipts,
    ).filter((f) => f.paymentId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_receiptsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableFilterComposer get bankAccountId {
    final $$BankAccountsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableFilterComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> receiptsRefs(
    Expression<bool> Function($$ReceiptsTableFilterComposer f) f,
  ) {
    final $$ReceiptsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.paymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableFilterComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get paidAt => $composableBuilder(
    column: $table.paidAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get method => $composableBuilder(
    column: $table.method,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableOrderingComposer get bankAccountId {
    final $$BankAccountsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableOrderingComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PaymentsTable> {
  $$PaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idempotencyKey => $composableBuilder(
    column: $table.idempotencyKey,
    builder: (column) => column,
  );

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get paidAt =>
      $composableBuilder(column: $table.paidAt, builder: (column) => column);

  GeneratedColumn<String> get method =>
      $composableBuilder(column: $table.method, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$BankAccountsTableAnnotationComposer get bankAccountId {
    final $$BankAccountsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.bankAccountId,
      referencedTable: $db.bankAccounts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$BankAccountsTableAnnotationComposer(
            $db: $db,
            $table: $db.bankAccounts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> receiptsRefs<T extends Object>(
    Expression<T> Function($$ReceiptsTableAnnotationComposer a) f,
  ) {
    final $$ReceiptsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.receipts,
      getReferencedColumn: (t) => t.paymentId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReceiptsTableAnnotationComposer(
            $db: $db,
            $table: $db.receipts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PaymentsTable,
          PaymentRow,
          $$PaymentsTableFilterComposer,
          $$PaymentsTableOrderingComposer,
          $$PaymentsTableAnnotationComposer,
          $$PaymentsTableCreateCompanionBuilder,
          $$PaymentsTableUpdateCompanionBuilder,
          (PaymentRow, $$PaymentsTableReferences),
          PaymentRow,
          PrefetchHooks Function({
            bool invoiceId,
            bool bankAccountId,
            bool receiptsRefs,
          })
        > {
  $$PaymentsTableTableManager(_$AppDatabase db, $PaymentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PaymentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> idempotencyKey = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<DateTime> paidAt = const Value.absent(),
                Value<String> method = const Value.absent(),
                Value<String?> bankAccountId = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion(
                id: id,
                invoiceId: invoiceId,
                idempotencyKey: idempotencyKey,
                amountMinor: amountMinor,
                paidAt: paidAt,
                method: method,
                bankAccountId: bankAccountId,
                reference: reference,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                required String idempotencyKey,
                required int amountMinor,
                required DateTime paidAt,
                required String method,
                Value<String?> bankAccountId = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => PaymentsCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                idempotencyKey: idempotencyKey,
                amountMinor: amountMinor,
                paidAt: paidAt,
                method: method,
                bankAccountId: bankAccountId,
                reference: reference,
                notes: notes,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PaymentsTable, PaymentRow>(table),
                  $$PaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                invoiceId = false,
                bankAccountId = false,
                receiptsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (receiptsRefs) db.receipts],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (invoiceId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.invoiceId,
                            referencedTable: $$PaymentsTableReferences
                                ._invoiceIdTable(db),
                            referencedColumn: $$PaymentsTableReferences
                                ._invoiceIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (bankAccountId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.bankAccountId,
                            referencedTable: $$PaymentsTableReferences
                                ._bankAccountIdTable(db),
                            referencedColumn: $$PaymentsTableReferences
                                ._bankAccountIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (receiptsRefs)
                        await $_getPrefetchedDataByColumns<
                          PaymentRow,
                          $PaymentsTable,
                          ReceiptRow,
                          $ReceiptsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PaymentsTableReferences
                              ._receiptsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PaymentsTableReferences(
                                db,
                                table,
                                p0,
                              ).receiptsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'payment_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PaymentsTable,
      PaymentRow,
      $$PaymentsTableFilterComposer,
      $$PaymentsTableOrderingComposer,
      $$PaymentsTableAnnotationComposer,
      $$PaymentsTableCreateCompanionBuilder,
      $$PaymentsTableUpdateCompanionBuilder,
      (PaymentRow, $$PaymentsTableReferences),
      PaymentRow,
      PrefetchHooks Function({
        bool invoiceId,
        bool bankAccountId,
        bool receiptsRefs,
      })
    >;
typedef $$ReceiptsTableCreateCompanionBuilder = ReceiptsCompanion Function({
  required String id,
  required String number,
  required String paymentId,
  required String invoiceId,
  required int amountMinor,
  required int remainingMinor,
  required String marker,
  required String snapshot,
  required DateTime issuedAt,
  Value<int> rowid,
});
typedef $$ReceiptsTableUpdateCompanionBuilder = ReceiptsCompanion Function({
  Value<String> id,
  Value<String> number,
  Value<String> paymentId,
  Value<String> invoiceId,
  Value<int> amountMinor,
  Value<int> remainingMinor,
  Value<String> marker,
  Value<String> snapshot,
  Value<DateTime> issuedAt,
  Value<int> rowid,
});

final class $$ReceiptsTableReferences
    extends BaseReferences<_$AppDatabase, $ReceiptsTable, ReceiptRow> {
  $$ReceiptsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PaymentsTable _paymentIdTable(_$AppDatabase db) =>
      db.payments.createAlias('receipts__payment_id__payments__id');

  $$PaymentsTableProcessedTableManager get paymentId {
    final $_column = $_itemColumn<String>('payment_id')!;

    final manager = $$PaymentsTableTableManager(
      $_db,
      $_db.payments,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_paymentIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('receipts__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReceiptsTableFilterComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remainingMinor => $composableBuilder(
    column: $table.remainingMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marker => $composableBuilder(
    column: $table.marker,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get snapshot => $composableBuilder(
    column: $table.snapshot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PaymentsTableFilterComposer get paymentId {
    final $$PaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableFilterComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get number => $composableBuilder(
    column: $table.number,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainingMinor => $composableBuilder(
    column: $table.remainingMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marker => $composableBuilder(
    column: $table.marker,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get snapshot => $composableBuilder(
    column: $table.snapshot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PaymentsTableOrderingComposer get paymentId {
    final $$PaymentsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableOrderingComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReceiptsTable> {
  $$ReceiptsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get number =>
      $composableBuilder(column: $table.number, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remainingMinor => $composableBuilder(
    column: $table.remainingMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get marker =>
      $composableBuilder(column: $table.marker, builder: (column) => column);

  GeneratedColumn<String> get snapshot =>
      $composableBuilder(column: $table.snapshot, builder: (column) => column);

  GeneratedColumn<DateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  $$PaymentsTableAnnotationComposer get paymentId {
    final $$PaymentsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.paymentId,
      referencedTable: $db.payments,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PaymentsTableAnnotationComposer(
            $db: $db,
            $table: $db.payments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReceiptsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReceiptsTable,
          ReceiptRow,
          $$ReceiptsTableFilterComposer,
          $$ReceiptsTableOrderingComposer,
          $$ReceiptsTableAnnotationComposer,
          $$ReceiptsTableCreateCompanionBuilder,
          $$ReceiptsTableUpdateCompanionBuilder,
          (ReceiptRow, $$ReceiptsTableReferences),
          ReceiptRow,
          PrefetchHooks Function({bool paymentId, bool invoiceId})
        > {
  $$ReceiptsTableTableManager(_$AppDatabase db, $ReceiptsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReceiptsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReceiptsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReceiptsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> number = const Value.absent(),
                Value<String> paymentId = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<int> remainingMinor = const Value.absent(),
                Value<String> marker = const Value.absent(),
                Value<String> snapshot = const Value.absent(),
                Value<DateTime> issuedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion(
                id: id,
                number: number,
                paymentId: paymentId,
                invoiceId: invoiceId,
                amountMinor: amountMinor,
                remainingMinor: remainingMinor,
                marker: marker,
                snapshot: snapshot,
                issuedAt: issuedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String number,
                required String paymentId,
                required String invoiceId,
                required int amountMinor,
                required int remainingMinor,
                required String marker,
                required String snapshot,
                required DateTime issuedAt,
                Value<int> rowid = const Value.absent(),
              }) => ReceiptsCompanion.insert(
                id: id,
                number: number,
                paymentId: paymentId,
                invoiceId: invoiceId,
                amountMinor: amountMinor,
                remainingMinor: remainingMinor,
                marker: marker,
                snapshot: snapshot,
                issuedAt: issuedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReceiptsTable, ReceiptRow>(table),
                  $$ReceiptsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({paymentId = false, invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (paymentId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.paymentId,
                        referencedTable: $$ReceiptsTableReferences
                            ._paymentIdTable(db),
                        referencedColumn: $$ReceiptsTableReferences
                            ._paymentIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$ReceiptsTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$ReceiptsTableReferences
                            ._invoiceIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReceiptsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReceiptsTable,
      ReceiptRow,
      $$ReceiptsTableFilterComposer,
      $$ReceiptsTableOrderingComposer,
      $$ReceiptsTableAnnotationComposer,
      $$ReceiptsTableCreateCompanionBuilder,
      $$ReceiptsTableUpdateCompanionBuilder,
      (ReceiptRow, $$ReceiptsTableReferences),
      ReceiptRow,
      PrefetchHooks Function({bool paymentId, bool invoiceId})
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required String invoiceId,
  required String kind,
  required DateTime scheduledAt,
  required int notificationId,
  required String status,
  Value<DateTime?> sentAt,
  Value<String?> message,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<String> invoiceId,
  Value<String> kind,
  Value<DateTime> scheduledAt,
  Value<int> notificationId,
  Value<String> status,
  Value<DateTime?> sentAt,
  Value<String?> message,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, ReminderRow> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $InvoicesTable _invoiceIdTable(_$AppDatabase db) =>
      db.invoices.createAlias('reminders__invoice_id__invoices__id');

  $$InvoicesTableProcessedTableManager get invoiceId {
    final $_column = $_itemColumn<String>('invoice_id')!;

    final manager = $$InvoicesTableTableManager(
      $_db,
      $_db.invoices,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_invoiceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$InvoicesTableFilterComposer get invoiceId {
    final $$InvoicesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableFilterComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sentAt => $composableBuilder(
    column: $table.sentAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get message => $composableBuilder(
    column: $table.message,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$InvoicesTableOrderingComposer get invoiceId {
    final $$InvoicesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableOrderingComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get notificationId => $composableBuilder(
    column: $table.notificationId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get sentAt =>
      $composableBuilder(column: $table.sentAt, builder: (column) => column);

  GeneratedColumn<String> get message =>
      $composableBuilder(column: $table.message, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$InvoicesTableAnnotationComposer get invoiceId {
    final $$InvoicesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.invoiceId,
      referencedTable: $db.invoices,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InvoicesTableAnnotationComposer(
            $db: $db,
            $table: $db.invoices,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          ReminderRow,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (ReminderRow, $$RemindersTableReferences),
          ReminderRow,
          PrefetchHooks Function({bool invoiceId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> invoiceId = const Value.absent(),
                Value<String> kind = const Value.absent(),
                Value<DateTime> scheduledAt = const Value.absent(),
                Value<int> notificationId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> sentAt = const Value.absent(),
                Value<String?> message = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                invoiceId: invoiceId,
                kind: kind,
                scheduledAt: scheduledAt,
                notificationId: notificationId,
                status: status,
                sentAt: sentAt,
                message: message,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String invoiceId,
                required String kind,
                required DateTime scheduledAt,
                required int notificationId,
                required String status,
                Value<DateTime?> sentAt = const Value.absent(),
                Value<String?> message = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                invoiceId: invoiceId,
                kind: kind,
                scheduledAt: scheduledAt,
                notificationId: notificationId,
                status: status,
                sentAt: sentAt,
                message: message,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, ReminderRow>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({invoiceId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (invoiceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.invoiceId,
                        referencedTable: $$RemindersTableReferences
                            ._invoiceIdTable(db),
                        referencedColumn: $$RemindersTableReferences
                            ._invoiceIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      ReminderRow,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (ReminderRow, $$RemindersTableReferences),
      ReminderRow,
      PrefetchHooks Function({bool invoiceId})
    >;
typedef $$MessageTemplatesTableCreateCompanionBuilder =
    MessageTemplatesCompanion Function({
      required String id,
      required String type,
      required String name,
      required String body,
      Value<bool> isDefault,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MessageTemplatesTableUpdateCompanionBuilder =
    MessageTemplatesCompanion Function({
      Value<String> id,
      Value<String> type,
      Value<String> name,
      Value<String> body,
      Value<bool> isDefault,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MessageTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MessageTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MessageTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MessageTemplatesTable> {
  $$MessageTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MessageTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MessageTemplatesTable,
          MessageTemplateRow,
          $$MessageTemplatesTableFilterComposer,
          $$MessageTemplatesTableOrderingComposer,
          $$MessageTemplatesTableAnnotationComposer,
          $$MessageTemplatesTableCreateCompanionBuilder,
          $$MessageTemplatesTableUpdateCompanionBuilder,
          (
            MessageTemplateRow,
            BaseReferences<
              _$AppDatabase,
              $MessageTemplatesTable,
              MessageTemplateRow
            >,
          ),
          MessageTemplateRow,
          PrefetchHooks Function()
        > {
  $$MessageTemplatesTableTableManager(
    _$AppDatabase db,
    $MessageTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MessageTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MessageTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MessageTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MessageTemplatesCompanion(
                id: id,
                type: type,
                name: name,
                body: body,
                isDefault: isDefault,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String type,
                required String name,
                required String body,
                Value<bool> isDefault = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MessageTemplatesCompanion.insert(
                id: id,
                type: type,
                name: name,
                body: body,
                isDefault: isDefault,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MessageTemplatesTable, MessageTemplateRow>(
                    table,
                  ),
                  BaseReferences<
                    _$AppDatabase,
                    $MessageTemplatesTable,
                    MessageTemplateRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MessageTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MessageTemplatesTable,
      MessageTemplateRow,
      $$MessageTemplatesTableFilterComposer,
      $$MessageTemplatesTableOrderingComposer,
      $$MessageTemplatesTableAnnotationComposer,
      $$MessageTemplatesTableCreateCompanionBuilder,
      $$MessageTemplatesTableUpdateCompanionBuilder,
      (
        MessageTemplateRow,
        BaseReferences<
          _$AppDatabase,
          $MessageTemplatesTable,
          MessageTemplateRow
        >,
      ),
      MessageTemplateRow,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String id,
      Value<bool> onboardingComplete,
      Value<String> invoicePrefix,
      Value<int> nextInvoiceSequence,
      Value<String> receiptPrefix,
      Value<int> nextReceiptSequence,
      Value<int> numberPadding,
      Value<String> defaultCurrency,
      Value<bool> taxEnabled,
      Value<int> defaultTaxRateBps,
      Value<String> defaultTermsPreset,
      Value<int> defaultDueDays,
      Value<String> defaultNotes,
      Value<String> defaultPaymentInstructions,
      Value<bool> notificationsEnabled,
      Value<int> remindBeforeDays,
      Value<bool> remindOnDue,
      Value<bool> remindAfter3,
      Value<bool> remindAfter7,
      Value<bool> pinEnabled,
      Value<bool> biometricEnabled,
      Value<int> autoLockSeconds,
      Value<bool> protectSensitive,
      Value<DateTime?> lastBackupAt,
      Value<String> themeMode,
      Value<String> paymentMethods,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<bool> insightEnabled,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> id,
      Value<bool> onboardingComplete,
      Value<String> invoicePrefix,
      Value<int> nextInvoiceSequence,
      Value<String> receiptPrefix,
      Value<int> nextReceiptSequence,
      Value<int> numberPadding,
      Value<String> defaultCurrency,
      Value<bool> taxEnabled,
      Value<int> defaultTaxRateBps,
      Value<String> defaultTermsPreset,
      Value<int> defaultDueDays,
      Value<String> defaultNotes,
      Value<String> defaultPaymentInstructions,
      Value<bool> notificationsEnabled,
      Value<int> remindBeforeDays,
      Value<bool> remindOnDue,
      Value<bool> remindAfter3,
      Value<bool> remindAfter7,
      Value<bool> pinEnabled,
      Value<bool> biometricEnabled,
      Value<int> autoLockSeconds,
      Value<bool> protectSensitive,
      Value<DateTime?> lastBackupAt,
      Value<String> themeMode,
      Value<String> paymentMethods,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<bool> insightEnabled,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextInvoiceSequence => $composableBuilder(
    column: $table.nextInvoiceSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get receiptPrefix => $composableBuilder(
    column: $table.receiptPrefix,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextReceiptSequence => $composableBuilder(
    column: $table.nextReceiptSequence,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get numberPadding => $composableBuilder(
    column: $table.numberPadding,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get taxEnabled => $composableBuilder(
    column: $table.taxEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultTaxRateBps => $composableBuilder(
    column: $table.defaultTaxRateBps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultTermsPreset => $composableBuilder(
    column: $table.defaultTermsPreset,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get defaultDueDays => $composableBuilder(
    column: $table.defaultDueDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultNotes => $composableBuilder(
    column: $table.defaultNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get defaultPaymentInstructions => $composableBuilder(
    column: $table.defaultPaymentInstructions,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get remindBeforeDays => $composableBuilder(
    column: $table.remindBeforeDays,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindOnDue => $composableBuilder(
    column: $table.remindOnDue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindAfter3 => $composableBuilder(
    column: $table.remindAfter3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get remindAfter7 => $composableBuilder(
    column: $table.remindAfter7,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get pinEnabled => $composableBuilder(
    column: $table.pinEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get autoLockSeconds => $composableBuilder(
    column: $table.autoLockSeconds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get protectSensitive => $composableBuilder(
    column: $table.protectSensitive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethods => $composableBuilder(
    column: $table.paymentMethods,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get insightEnabled => $composableBuilder(
    column: $table.insightEnabled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextInvoiceSequence => $composableBuilder(
    column: $table.nextInvoiceSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get receiptPrefix => $composableBuilder(
    column: $table.receiptPrefix,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextReceiptSequence => $composableBuilder(
    column: $table.nextReceiptSequence,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get numberPadding => $composableBuilder(
    column: $table.numberPadding,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get taxEnabled => $composableBuilder(
    column: $table.taxEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultTaxRateBps => $composableBuilder(
    column: $table.defaultTaxRateBps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultTermsPreset => $composableBuilder(
    column: $table.defaultTermsPreset,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get defaultDueDays => $composableBuilder(
    column: $table.defaultDueDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultNotes => $composableBuilder(
    column: $table.defaultNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get defaultPaymentInstructions => $composableBuilder(
    column: $table.defaultPaymentInstructions,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remindBeforeDays => $composableBuilder(
    column: $table.remindBeforeDays,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindOnDue => $composableBuilder(
    column: $table.remindOnDue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindAfter3 => $composableBuilder(
    column: $table.remindAfter3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get remindAfter7 => $composableBuilder(
    column: $table.remindAfter7,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get pinEnabled => $composableBuilder(
    column: $table.pinEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get autoLockSeconds => $composableBuilder(
    column: $table.autoLockSeconds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get protectSensitive => $composableBuilder(
    column: $table.protectSensitive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethods => $composableBuilder(
    column: $table.paymentMethods,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get insightEnabled => $composableBuilder(
    column: $table.insightEnabled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<bool> get onboardingComplete => $composableBuilder(
    column: $table.onboardingComplete,
    builder: (column) => column,
  );

  GeneratedColumn<String> get invoicePrefix => $composableBuilder(
    column: $table.invoicePrefix,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextInvoiceSequence => $composableBuilder(
    column: $table.nextInvoiceSequence,
    builder: (column) => column,
  );

  GeneratedColumn<String> get receiptPrefix => $composableBuilder(
    column: $table.receiptPrefix,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextReceiptSequence => $composableBuilder(
    column: $table.nextReceiptSequence,
    builder: (column) => column,
  );

  GeneratedColumn<int> get numberPadding => $composableBuilder(
    column: $table.numberPadding,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultCurrency => $composableBuilder(
    column: $table.defaultCurrency,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get taxEnabled => $composableBuilder(
    column: $table.taxEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultTaxRateBps => $composableBuilder(
    column: $table.defaultTaxRateBps,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultTermsPreset => $composableBuilder(
    column: $table.defaultTermsPreset,
    builder: (column) => column,
  );

  GeneratedColumn<int> get defaultDueDays => $composableBuilder(
    column: $table.defaultDueDays,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultNotes => $composableBuilder(
    column: $table.defaultNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get defaultPaymentInstructions => $composableBuilder(
    column: $table.defaultPaymentInstructions,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notificationsEnabled => $composableBuilder(
    column: $table.notificationsEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get remindBeforeDays => $composableBuilder(
    column: $table.remindBeforeDays,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindOnDue => $composableBuilder(
    column: $table.remindOnDue,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindAfter3 => $composableBuilder(
    column: $table.remindAfter3,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get remindAfter7 => $composableBuilder(
    column: $table.remindAfter7,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get pinEnabled => $composableBuilder(
    column: $table.pinEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get biometricEnabled => $composableBuilder(
    column: $table.biometricEnabled,
    builder: (column) => column,
  );

  GeneratedColumn<int> get autoLockSeconds => $composableBuilder(
    column: $table.autoLockSeconds,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get protectSensitive => $composableBuilder(
    column: $table.protectSensitive,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastBackupAt => $composableBuilder(
    column: $table.lastBackupAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get paymentMethods => $composableBuilder(
    column: $table.paymentMethods,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<bool> get insightEnabled => $composableBuilder(
    column: $table.insightEnabled,
    builder: (column) => column,
  );
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSettingRow,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSettingRow,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>,
          ),
          AppSettingRow,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<bool> onboardingComplete = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<int> nextInvoiceSequence = const Value.absent(),
                Value<String> receiptPrefix = const Value.absent(),
                Value<int> nextReceiptSequence = const Value.absent(),
                Value<int> numberPadding = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<bool> taxEnabled = const Value.absent(),
                Value<int> defaultTaxRateBps = const Value.absent(),
                Value<String> defaultTermsPreset = const Value.absent(),
                Value<int> defaultDueDays = const Value.absent(),
                Value<String> defaultNotes = const Value.absent(),
                Value<String> defaultPaymentInstructions = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> remindBeforeDays = const Value.absent(),
                Value<bool> remindOnDue = const Value.absent(),
                Value<bool> remindAfter3 = const Value.absent(),
                Value<bool> remindAfter7 = const Value.absent(),
                Value<bool> pinEnabled = const Value.absent(),
                Value<bool> biometricEnabled = const Value.absent(),
                Value<int> autoLockSeconds = const Value.absent(),
                Value<bool> protectSensitive = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> paymentMethods = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<bool> insightEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(
                id: id,
                onboardingComplete: onboardingComplete,
                invoicePrefix: invoicePrefix,
                nextInvoiceSequence: nextInvoiceSequence,
                receiptPrefix: receiptPrefix,
                nextReceiptSequence: nextReceiptSequence,
                numberPadding: numberPadding,
                defaultCurrency: defaultCurrency,
                taxEnabled: taxEnabled,
                defaultTaxRateBps: defaultTaxRateBps,
                defaultTermsPreset: defaultTermsPreset,
                defaultDueDays: defaultDueDays,
                defaultNotes: defaultNotes,
                defaultPaymentInstructions: defaultPaymentInstructions,
                notificationsEnabled: notificationsEnabled,
                remindBeforeDays: remindBeforeDays,
                remindOnDue: remindOnDue,
                remindAfter3: remindAfter3,
                remindAfter7: remindAfter7,
                pinEnabled: pinEnabled,
                biometricEnabled: biometricEnabled,
                autoLockSeconds: autoLockSeconds,
                protectSensitive: protectSensitive,
                lastBackupAt: lastBackupAt,
                themeMode: themeMode,
                paymentMethods: paymentMethods,
                createdAt: createdAt,
                updatedAt: updatedAt,
                insightEnabled: insightEnabled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<bool> onboardingComplete = const Value.absent(),
                Value<String> invoicePrefix = const Value.absent(),
                Value<int> nextInvoiceSequence = const Value.absent(),
                Value<String> receiptPrefix = const Value.absent(),
                Value<int> nextReceiptSequence = const Value.absent(),
                Value<int> numberPadding = const Value.absent(),
                Value<String> defaultCurrency = const Value.absent(),
                Value<bool> taxEnabled = const Value.absent(),
                Value<int> defaultTaxRateBps = const Value.absent(),
                Value<String> defaultTermsPreset = const Value.absent(),
                Value<int> defaultDueDays = const Value.absent(),
                Value<String> defaultNotes = const Value.absent(),
                Value<String> defaultPaymentInstructions = const Value.absent(),
                Value<bool> notificationsEnabled = const Value.absent(),
                Value<int> remindBeforeDays = const Value.absent(),
                Value<bool> remindOnDue = const Value.absent(),
                Value<bool> remindAfter3 = const Value.absent(),
                Value<bool> remindAfter7 = const Value.absent(),
                Value<bool> pinEnabled = const Value.absent(),
                Value<bool> biometricEnabled = const Value.absent(),
                Value<int> autoLockSeconds = const Value.absent(),
                Value<bool> protectSensitive = const Value.absent(),
                Value<DateTime?> lastBackupAt = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<String> paymentMethods = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<bool> insightEnabled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                id: id,
                onboardingComplete: onboardingComplete,
                invoicePrefix: invoicePrefix,
                nextInvoiceSequence: nextInvoiceSequence,
                receiptPrefix: receiptPrefix,
                nextReceiptSequence: nextReceiptSequence,
                numberPadding: numberPadding,
                defaultCurrency: defaultCurrency,
                taxEnabled: taxEnabled,
                defaultTaxRateBps: defaultTaxRateBps,
                defaultTermsPreset: defaultTermsPreset,
                defaultDueDays: defaultDueDays,
                defaultNotes: defaultNotes,
                defaultPaymentInstructions: defaultPaymentInstructions,
                notificationsEnabled: notificationsEnabled,
                remindBeforeDays: remindBeforeDays,
                remindOnDue: remindOnDue,
                remindAfter3: remindAfter3,
                remindAfter7: remindAfter7,
                pinEnabled: pinEnabled,
                biometricEnabled: biometricEnabled,
                autoLockSeconds: autoLockSeconds,
                protectSensitive: protectSensitive,
                lastBackupAt: lastBackupAt,
                themeMode: themeMode,
                paymentMethods: paymentMethods,
                createdAt: createdAt,
                updatedAt: updatedAt,
                insightEnabled: insightEnabled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSettingRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AppSettingsTable,
                    AppSettingRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSettingRow,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSettingRow,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSettingRow>,
      ),
      AppSettingRow,
      PrefetchHooks Function()
    >;
typedef $$BackupMetadataTableCreateCompanionBuilder =
    BackupMetadataCompanion Function({
      required String id,
      required DateTime createdAt,
      required String fileName,
      required int formatVersion,
      Value<bool> encrypted,
      Value<int> sizeBytes,
      Value<String?> note,
      Value<int> rowid,
    });
typedef $$BackupMetadataTableUpdateCompanionBuilder =
    BackupMetadataCompanion Function({
      Value<String> id,
      Value<DateTime> createdAt,
      Value<String> fileName,
      Value<int> formatVersion,
      Value<bool> encrypted,
      Value<int> sizeBytes,
      Value<String?> note,
      Value<int> rowid,
    });

class $$BackupMetadataTableFilterComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get encrypted => $composableBuilder(
    column: $table.encrypted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BackupMetadataTableOrderingComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileName => $composableBuilder(
    column: $table.fileName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get encrypted => $composableBuilder(
    column: $table.encrypted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sizeBytes => $composableBuilder(
    column: $table.sizeBytes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BackupMetadataTableAnnotationComposer
    extends Composer<_$AppDatabase, $BackupMetadataTable> {
  $$BackupMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get fileName =>
      $composableBuilder(column: $table.fileName, builder: (column) => column);

  GeneratedColumn<int> get formatVersion => $composableBuilder(
    column: $table.formatVersion,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get encrypted =>
      $composableBuilder(column: $table.encrypted, builder: (column) => column);

  GeneratedColumn<int> get sizeBytes =>
      $composableBuilder(column: $table.sizeBytes, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);
}

class $$BackupMetadataTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BackupMetadataTable,
          BackupMetadataRow,
          $$BackupMetadataTableFilterComposer,
          $$BackupMetadataTableOrderingComposer,
          $$BackupMetadataTableAnnotationComposer,
          $$BackupMetadataTableCreateCompanionBuilder,
          $$BackupMetadataTableUpdateCompanionBuilder,
          (
            BackupMetadataRow,
            BaseReferences<
              _$AppDatabase,
              $BackupMetadataTable,
              BackupMetadataRow
            >,
          ),
          BackupMetadataRow,
          PrefetchHooks Function()
        > {
  $$BackupMetadataTableTableManager(
    _$AppDatabase db,
    $BackupMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BackupMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BackupMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BackupMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String> fileName = const Value.absent(),
                Value<int> formatVersion = const Value.absent(),
                Value<bool> encrypted = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupMetadataCompanion(
                id: id,
                createdAt: createdAt,
                fileName: fileName,
                formatVersion: formatVersion,
                encrypted: encrypted,
                sizeBytes: sizeBytes,
                note: note,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required DateTime createdAt,
                required String fileName,
                required int formatVersion,
                Value<bool> encrypted = const Value.absent(),
                Value<int> sizeBytes = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BackupMetadataCompanion.insert(
                id: id,
                createdAt: createdAt,
                fileName: fileName,
                formatVersion: formatVersion,
                encrypted: encrypted,
                sizeBytes: sizeBytes,
                note: note,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$BackupMetadataTable, BackupMetadataRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $BackupMetadataTable,
                    BackupMetadataRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BackupMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BackupMetadataTable,
      BackupMetadataRow,
      $$BackupMetadataTableFilterComposer,
      $$BackupMetadataTableOrderingComposer,
      $$BackupMetadataTableAnnotationComposer,
      $$BackupMetadataTableCreateCompanionBuilder,
      $$BackupMetadataTableUpdateCompanionBuilder,
      (
        BackupMetadataRow,
        BaseReferences<_$AppDatabase, $BackupMetadataTable, BackupMetadataRow>,
      ),
      BackupMetadataRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$BusinessesTableTableManager get businesses =>
      $$BusinessesTableTableManager(_db, _db.businesses);
  $$BrandProfilesTableTableManager get brandProfiles =>
      $$BrandProfilesTableTableManager(_db, _db.brandProfiles);
  $$BankAccountsTableTableManager get bankAccounts =>
      $$BankAccountsTableTableManager(_db, _db.bankAccounts);
  $$ServicesTableTableManager get services =>
      $$ServicesTableTableManager(_db, _db.services);
  $$CustomersTableTableManager get customers =>
      $$CustomersTableTableManager(_db, _db.customers);
  $$InvoicesTableTableManager get invoices =>
      $$InvoicesTableTableManager(_db, _db.invoices);
  $$InvoiceItemsTableTableManager get invoiceItems =>
      $$InvoiceItemsTableTableManager(_db, _db.invoiceItems);
  $$PaymentsTableTableManager get payments =>
      $$PaymentsTableTableManager(_db, _db.payments);
  $$ReceiptsTableTableManager get receipts =>
      $$ReceiptsTableTableManager(_db, _db.receipts);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$MessageTemplatesTableTableManager get messageTemplates =>
      $$MessageTemplatesTableTableManager(_db, _db.messageTemplates);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$BackupMetadataTableTableManager get backupMetadata =>
      $$BackupMetadataTableTableManager(_db, _db.backupMetadata);
}
