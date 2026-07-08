// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ciclo_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCicloLocalCollection on Isar {
  IsarCollection<CicloLocal> get cicloLocals => this.collection();
}

const CicloLocalSchema = CollectionSchema(
  name: r'CicloLocal',
  id: 3430925921269515290,
  properties: {
    r'clienteId': PropertySchema(
      id: 0,
      name: r'clienteId',
      type: IsarType.string,
    ),
    r'clienteNombre': PropertySchema(
      id: 1,
      name: r'clienteNombre',
      type: IsarType.string,
    ),
    r'duracionMinutos': PropertySchema(
      id: 2,
      name: r'duracionMinutos',
      type: IsarType.long,
    ),
    r'estado': PropertySchema(
      id: 3,
      name: r'estado',
      type: IsarType.string,
    ),
    r'finEn': PropertySchema(
      id: 4,
      name: r'finEn',
      type: IsarType.dateTime,
    ),
    r'id': PropertySchema(
      id: 5,
      name: r'id',
      type: IsarType.string,
    ),
    r'inicioEn': PropertySchema(
      id: 6,
      name: r'inicioEn',
      type: IsarType.dateTime,
    ),
    r'programaId': PropertySchema(
      id: 7,
      name: r'programaId',
      type: IsarType.string,
    ),
    r'programaNombre': PropertySchema(
      id: 8,
      name: r'programaNombre',
      type: IsarType.string,
    ),
    r'sincronizado': PropertySchema(
      id: 9,
      name: r'sincronizado',
      type: IsarType.bool,
    ),
    r'turnoId': PropertySchema(
      id: 10,
      name: r'turnoId',
      type: IsarType.string,
    ),
    r'usuarioId': PropertySchema(
      id: 11,
      name: r'usuarioId',
      type: IsarType.string,
    )
  },
  estimateSize: _cicloLocalEstimateSize,
  serialize: _cicloLocalSerialize,
  deserialize: _cicloLocalDeserialize,
  deserializeProp: _cicloLocalDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'id': IndexSchema(
      id: -3268401673993471357,
      name: r'id',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'id',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'usuarioId': IndexSchema(
      id: -6806307564427522310,
      name: r'usuarioId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'usuarioId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'estado': IndexSchema(
      id: -4800696143246816208,
      name: r'estado',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'estado',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'sincronizado': IndexSchema(
      id: -5635005241243394166,
      name: r'sincronizado',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sincronizado',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _cicloLocalGetId,
  getLinks: _cicloLocalGetLinks,
  attach: _cicloLocalAttach,
  version: '3.1.0+1',
);

int _cicloLocalEstimateSize(
  CicloLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.clienteId.length * 3;
  {
    final value = object.clienteNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.estado.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.programaId.length * 3;
  {
    final value = object.programaNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.turnoId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.usuarioId.length * 3;
  return bytesCount;
}

void _cicloLocalSerialize(
  CicloLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.clienteId);
  writer.writeString(offsets[1], object.clienteNombre);
  writer.writeLong(offsets[2], object.duracionMinutos);
  writer.writeString(offsets[3], object.estado);
  writer.writeDateTime(offsets[4], object.finEn);
  writer.writeString(offsets[5], object.id);
  writer.writeDateTime(offsets[6], object.inicioEn);
  writer.writeString(offsets[7], object.programaId);
  writer.writeString(offsets[8], object.programaNombre);
  writer.writeBool(offsets[9], object.sincronizado);
  writer.writeString(offsets[10], object.turnoId);
  writer.writeString(offsets[11], object.usuarioId);
}

CicloLocal _cicloLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CicloLocal();
  object.clienteId = reader.readString(offsets[0]);
  object.clienteNombre = reader.readStringOrNull(offsets[1]);
  object.duracionMinutos = reader.readLong(offsets[2]);
  object.estado = reader.readString(offsets[3]);
  object.finEn = reader.readDateTimeOrNull(offsets[4]);
  object.id = reader.readString(offsets[5]);
  object.inicioEn = reader.readDateTime(offsets[6]);
  object.isarId = id;
  object.programaId = reader.readString(offsets[7]);
  object.programaNombre = reader.readStringOrNull(offsets[8]);
  object.sincronizado = reader.readBool(offsets[9]);
  object.turnoId = reader.readStringOrNull(offsets[10]);
  object.usuarioId = reader.readString(offsets[11]);
  return object;
}

P _cicloLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readDateTime(offset)) as P;
    case 7:
      return (reader.readString(offset)) as P;
    case 8:
      return (reader.readStringOrNull(offset)) as P;
    case 9:
      return (reader.readBool(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _cicloLocalGetId(CicloLocal object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _cicloLocalGetLinks(CicloLocal object) {
  return [];
}

void _cicloLocalAttach(IsarCollection<dynamic> col, Id id, CicloLocal object) {
  object.isarId = id;
}

extension CicloLocalByIndex on IsarCollection<CicloLocal> {
  Future<CicloLocal?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  CicloLocal? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<CicloLocal?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<CicloLocal?> getAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'id', values);
  }

  Future<int> deleteAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'id', values);
  }

  int deleteAllByIdSync(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'id', values);
  }

  Future<Id> putById(CicloLocal object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(CicloLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<CicloLocal> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<CicloLocal> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension CicloLocalQueryWhereSort
    on QueryBuilder<CicloLocal, CicloLocal, QWhere> {
  QueryBuilder<CicloLocal, CicloLocal, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhere> anySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sincronizado'),
      );
    });
  }
}

extension CicloLocalQueryWhere
    on QueryBuilder<CicloLocal, CicloLocal, QWhereClause> {
  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> isarIdNotEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> idNotEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [id],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'id',
              lower: [],
              upper: [id],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> usuarioIdEqualTo(
      String usuarioId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'usuarioId',
        value: [usuarioId],
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> usuarioIdNotEqualTo(
      String usuarioId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'usuarioId',
              lower: [],
              upper: [usuarioId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'usuarioId',
              lower: [usuarioId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'usuarioId',
              lower: [usuarioId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'usuarioId',
              lower: [],
              upper: [usuarioId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> estadoEqualTo(
      String estado) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'estado',
        value: [estado],
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> estadoNotEqualTo(
      String estado) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'estado',
              lower: [],
              upper: [estado],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'estado',
              lower: [estado],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'estado',
              lower: [estado],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'estado',
              lower: [],
              upper: [estado],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause> sincronizadoEqualTo(
      bool sincronizado) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sincronizado',
        value: [sincronizado],
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterWhereClause>
      sincronizadoNotEqualTo(bool sincronizado) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sincronizado',
              lower: [],
              upper: [sincronizado],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sincronizado',
              lower: [sincronizado],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sincronizado',
              lower: [sincronizado],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sincronizado',
              lower: [],
              upper: [sincronizado],
              includeUpper: false,
            ));
      }
    });
  }
}

extension CicloLocalQueryFilter
    on QueryBuilder<CicloLocal, CicloLocal, QFilterCondition> {
  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> clienteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clienteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clienteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> clienteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clienteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> clienteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clienteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clienteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> clienteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clienteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> clienteIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clienteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> clienteIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clienteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clienteId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clienteId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'clienteNombre',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'clienteNombre',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clienteNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'clienteNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'clienteNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'clienteNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'clienteNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'clienteNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'clienteNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'clienteNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'clienteNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      clienteNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'clienteNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      duracionMinutosEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duracionMinutos',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      duracionMinutosGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duracionMinutos',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      duracionMinutosLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duracionMinutos',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      duracionMinutosBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duracionMinutos',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'estado',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'estado',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'estado',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> estadoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      estadoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'estado',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> finEnIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'finEn',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> finEnIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'finEn',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> finEnEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'finEn',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> finEnGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'finEn',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> finEnLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'finEn',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> finEnBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'finEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> inicioEnEqualTo(
      DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'inicioEn',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      inicioEnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'inicioEn',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> inicioEnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'inicioEn',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> inicioEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'inicioEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> programaIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> programaIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'programaId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> programaIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'programaId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'programaId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'programaId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'programaNombre',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'programaNombre',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'programaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'programaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'programaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'programaNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'programaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'programaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'programaNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'programaNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'programaNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      programaNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'programaNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      sincronizadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sincronizado',
        value: value,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'turnoId',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      turnoIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'turnoId',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'turnoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      turnoIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'turnoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'turnoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'turnoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'turnoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'turnoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'turnoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'turnoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> turnoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'turnoId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      turnoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'turnoId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> usuarioIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      usuarioIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> usuarioIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> usuarioIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'usuarioId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      usuarioIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> usuarioIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> usuarioIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition> usuarioIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'usuarioId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      usuarioIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usuarioId',
        value: '',
      ));
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterFilterCondition>
      usuarioIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'usuarioId',
        value: '',
      ));
    });
  }
}

extension CicloLocalQueryObject
    on QueryBuilder<CicloLocal, CicloLocal, QFilterCondition> {}

extension CicloLocalQueryLinks
    on QueryBuilder<CicloLocal, CicloLocal, QFilterCondition> {}

extension CicloLocalQuerySortBy
    on QueryBuilder<CicloLocal, CicloLocal, QSortBy> {
  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByClienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByClienteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByClienteNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteNombre', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByClienteNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteNombre', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByDuracionMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMinutos', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy>
      sortByDuracionMinutosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMinutos', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByFinEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finEn', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByFinEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finEn', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByInicioEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioEn', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByInicioEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioEn', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByProgramaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByProgramaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByProgramaNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaNombre', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy>
      sortByProgramaNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaNombre', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortBySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortBySincronizadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByTurnoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'turnoId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByTurnoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'turnoId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByUsuarioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> sortByUsuarioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.desc);
    });
  }
}

extension CicloLocalQuerySortThenBy
    on QueryBuilder<CicloLocal, CicloLocal, QSortThenBy> {
  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByClienteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByClienteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByClienteNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteNombre', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByClienteNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'clienteNombre', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByDuracionMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMinutos', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy>
      thenByDuracionMinutosDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duracionMinutos', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByEstado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByEstadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'estado', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByFinEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finEn', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByFinEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'finEn', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByInicioEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioEn', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByInicioEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'inicioEn', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByProgramaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByProgramaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByProgramaNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaNombre', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy>
      thenByProgramaNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaNombre', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenBySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenBySincronizadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByTurnoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'turnoId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByTurnoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'turnoId', Sort.desc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByUsuarioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.asc);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QAfterSortBy> thenByUsuarioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.desc);
    });
  }
}

extension CicloLocalQueryWhereDistinct
    on QueryBuilder<CicloLocal, CicloLocal, QDistinct> {
  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByClienteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clienteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByClienteNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'clienteNombre',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByDuracionMinutos() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duracionMinutos');
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByEstado(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'estado', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByFinEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'finEn');
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByInicioEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'inicioEn');
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByProgramaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'programaId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByProgramaNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'programaNombre',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctBySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sincronizado');
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByTurnoId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'turnoId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CicloLocal, CicloLocal, QDistinct> distinctByUsuarioId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usuarioId', caseSensitive: caseSensitive);
    });
  }
}

extension CicloLocalQueryProperty
    on QueryBuilder<CicloLocal, CicloLocal, QQueryProperty> {
  QueryBuilder<CicloLocal, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CicloLocal, String, QQueryOperations> clienteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clienteId');
    });
  }

  QueryBuilder<CicloLocal, String?, QQueryOperations> clienteNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'clienteNombre');
    });
  }

  QueryBuilder<CicloLocal, int, QQueryOperations> duracionMinutosProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duracionMinutos');
    });
  }

  QueryBuilder<CicloLocal, String, QQueryOperations> estadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'estado');
    });
  }

  QueryBuilder<CicloLocal, DateTime?, QQueryOperations> finEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'finEn');
    });
  }

  QueryBuilder<CicloLocal, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CicloLocal, DateTime, QQueryOperations> inicioEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'inicioEn');
    });
  }

  QueryBuilder<CicloLocal, String, QQueryOperations> programaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'programaId');
    });
  }

  QueryBuilder<CicloLocal, String?, QQueryOperations> programaNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'programaNombre');
    });
  }

  QueryBuilder<CicloLocal, bool, QQueryOperations> sincronizadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sincronizado');
    });
  }

  QueryBuilder<CicloLocal, String?, QQueryOperations> turnoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'turnoId');
    });
  }

  QueryBuilder<CicloLocal, String, QQueryOperations> usuarioIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usuarioId');
    });
  }
}
