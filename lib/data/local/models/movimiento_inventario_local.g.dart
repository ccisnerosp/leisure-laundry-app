// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movimiento_inventario_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMovimientoInventarioLocalCollection on Isar {
  IsarCollection<MovimientoInventarioLocal> get movimientoInventarioLocals =>
      this.collection();
}

const MovimientoInventarioLocalSchema = CollectionSchema(
  name: r'MovimientoInventarioLocal',
  id: 635554041761723153,
  properties: {
    r'cantidad': PropertySchema(
      id: 0,
      name: r'cantidad',
      type: IsarType.double,
    ),
    r'cicloId': PropertySchema(
      id: 1,
      name: r'cicloId',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 2,
      name: r'id',
      type: IsarType.string,
    ),
    r'insumoId': PropertySchema(
      id: 3,
      name: r'insumoId',
      type: IsarType.string,
    ),
    r'insumoNombre': PropertySchema(
      id: 4,
      name: r'insumoNombre',
      type: IsarType.string,
    ),
    r'registradoEn': PropertySchema(
      id: 5,
      name: r'registradoEn',
      type: IsarType.dateTime,
    ),
    r'sincronizado': PropertySchema(
      id: 6,
      name: r'sincronizado',
      type: IsarType.bool,
    ),
    r'stockResultante': PropertySchema(
      id: 7,
      name: r'stockResultante',
      type: IsarType.double,
    ),
    r'tipo': PropertySchema(
      id: 8,
      name: r'tipo',
      type: IsarType.string,
    ),
    r'usuarioId': PropertySchema(
      id: 9,
      name: r'usuarioId',
      type: IsarType.string,
    )
  },
  estimateSize: _movimientoInventarioLocalEstimateSize,
  serialize: _movimientoInventarioLocalSerialize,
  deserialize: _movimientoInventarioLocalDeserialize,
  deserializeProp: _movimientoInventarioLocalDeserializeProp,
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
    r'insumoId': IndexSchema(
      id: 8122576719315007979,
      name: r'insumoId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'insumoId',
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
  getId: _movimientoInventarioLocalGetId,
  getLinks: _movimientoInventarioLocalGetLinks,
  attach: _movimientoInventarioLocalAttach,
  version: '3.1.0+1',
);

int _movimientoInventarioLocalEstimateSize(
  MovimientoInventarioLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cicloId;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.insumoId.length * 3;
  {
    final value = object.insumoNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.tipo.length * 3;
  bytesCount += 3 + object.usuarioId.length * 3;
  return bytesCount;
}

void _movimientoInventarioLocalSerialize(
  MovimientoInventarioLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.cantidad);
  writer.writeString(offsets[1], object.cicloId);
  writer.writeString(offsets[2], object.id);
  writer.writeString(offsets[3], object.insumoId);
  writer.writeString(offsets[4], object.insumoNombre);
  writer.writeDateTime(offsets[5], object.registradoEn);
  writer.writeBool(offsets[6], object.sincronizado);
  writer.writeDouble(offsets[7], object.stockResultante);
  writer.writeString(offsets[8], object.tipo);
  writer.writeString(offsets[9], object.usuarioId);
}

MovimientoInventarioLocal _movimientoInventarioLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MovimientoInventarioLocal();
  object.cantidad = reader.readDouble(offsets[0]);
  object.cicloId = reader.readStringOrNull(offsets[1]);
  object.id = reader.readString(offsets[2]);
  object.insumoId = reader.readString(offsets[3]);
  object.insumoNombre = reader.readStringOrNull(offsets[4]);
  object.isarId = id;
  object.registradoEn = reader.readDateTime(offsets[5]);
  object.sincronizado = reader.readBool(offsets[6]);
  object.stockResultante = reader.readDouble(offsets[7]);
  object.tipo = reader.readString(offsets[8]);
  object.usuarioId = reader.readString(offsets[9]);
  return object;
}

P _movimientoInventarioLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readDateTime(offset)) as P;
    case 6:
      return (reader.readBool(offset)) as P;
    case 7:
      return (reader.readDouble(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _movimientoInventarioLocalGetId(MovimientoInventarioLocal object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _movimientoInventarioLocalGetLinks(
    MovimientoInventarioLocal object) {
  return [];
}

void _movimientoInventarioLocalAttach(
    IsarCollection<dynamic> col, Id id, MovimientoInventarioLocal object) {
  object.isarId = id;
}

extension MovimientoInventarioLocalByIndex
    on IsarCollection<MovimientoInventarioLocal> {
  Future<MovimientoInventarioLocal?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  MovimientoInventarioLocal? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<MovimientoInventarioLocal?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<MovimientoInventarioLocal?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(MovimientoInventarioLocal object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(MovimientoInventarioLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<MovimientoInventarioLocal> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<MovimientoInventarioLocal> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension MovimientoInventarioLocalQueryWhereSort on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QWhere> {
  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhere> anySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'sincronizado'),
      );
    });
  }
}

extension MovimientoInventarioLocalQueryWhere on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QWhereClause> {
  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> idNotEqualTo(String id) {
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> insumoIdEqualTo(String insumoId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'insumoId',
        value: [insumoId],
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> insumoIdNotEqualTo(String insumoId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insumoId',
              lower: [],
              upper: [insumoId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insumoId',
              lower: [insumoId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insumoId',
              lower: [insumoId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'insumoId',
              lower: [],
              upper: [insumoId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> sincronizadoEqualTo(bool sincronizado) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sincronizado',
        value: [sincronizado],
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterWhereClause> sincronizadoNotEqualTo(bool sincronizado) {
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

extension MovimientoInventarioLocalQueryFilter on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QFilterCondition> {
  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cantidadEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cantidad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cantidadGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cantidad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cantidadLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cantidad',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cantidadBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cantidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cicloId',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cicloId',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cicloId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cicloId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cicloId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cicloId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cicloId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cicloId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      cicloIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cicloId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      cicloIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cicloId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cicloId',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> cicloIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cicloId',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idLessThan(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idBetween(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'insumoId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      insumoIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      insumoIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insumoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoId',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insumoId',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'insumoNombre',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'insumoNombre',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'insumoNombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      insumoNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      insumoNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insumoNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> insumoNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insumoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> registradoEnEqualTo(DateTime value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'registradoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> registradoEnGreaterThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'registradoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> registradoEnLessThan(
    DateTime value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'registradoEn',
        value: value,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> registradoEnBetween(
    DateTime lower,
    DateTime upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'registradoEn',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> sincronizadoEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sincronizado',
        value: value,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> stockResultanteEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stockResultante',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> stockResultanteGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stockResultante',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> stockResultanteLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stockResultante',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> stockResultanteBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stockResultante',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tipo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      tipoContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tipo',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      tipoMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tipo',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> tipoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tipo',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdEqualTo(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdGreaterThan(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdLessThan(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdBetween(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdStartsWith(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdEndsWith(
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

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      usuarioIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'usuarioId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
          QAfterFilterCondition>
      usuarioIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'usuarioId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'usuarioId',
        value: '',
      ));
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterFilterCondition> usuarioIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'usuarioId',
        value: '',
      ));
    });
  }
}

extension MovimientoInventarioLocalQueryObject on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QFilterCondition> {}

extension MovimientoInventarioLocalQueryLinks on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QFilterCondition> {}

extension MovimientoInventarioLocalQuerySortBy on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QSortBy> {
  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByCicloId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByCicloIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloId', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByInsumoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByInsumoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByInsumoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByInsumoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByRegistradoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registradoEn', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByRegistradoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registradoEn', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortBySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortBySincronizadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByStockResultante() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockResultante', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByStockResultanteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockResultante', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByUsuarioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> sortByUsuarioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.desc);
    });
  }
}

extension MovimientoInventarioLocalQuerySortThenBy on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QSortThenBy> {
  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByCantidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cantidad', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByCicloId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByCicloIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cicloId', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByInsumoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByInsumoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByInsumoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByInsumoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByRegistradoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registradoEn', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByRegistradoEnDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'registradoEn', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenBySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenBySincronizadoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sincronizado', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByStockResultante() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockResultante', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByStockResultanteDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockResultante', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByTipo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByTipoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'tipo', Sort.desc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByUsuarioId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.asc);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal,
      QAfterSortBy> thenByUsuarioIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'usuarioId', Sort.desc);
    });
  }
}

extension MovimientoInventarioLocalQueryWhereDistinct on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct> {
  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByCantidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cantidad');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByCicloId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cicloId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctById({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByInsumoId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insumoId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByInsumoNombre({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insumoNombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByRegistradoEn() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'registradoEn');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctBySincronizado() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sincronizado');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByStockResultante() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stockResultante');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByTipo({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tipo', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MovimientoInventarioLocal, MovimientoInventarioLocal, QDistinct>
      distinctByUsuarioId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'usuarioId', caseSensitive: caseSensitive);
    });
  }
}

extension MovimientoInventarioLocalQueryProperty on QueryBuilder<
    MovimientoInventarioLocal, MovimientoInventarioLocal, QQueryProperty> {
  QueryBuilder<MovimientoInventarioLocal, int, QQueryOperations>
      isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, double, QQueryOperations>
      cantidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cantidad');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, String?, QQueryOperations>
      cicloIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cicloId');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, String, QQueryOperations>
      idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, String, QQueryOperations>
      insumoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insumoId');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, String?, QQueryOperations>
      insumoNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insumoNombre');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, DateTime, QQueryOperations>
      registradoEnProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'registradoEn');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, bool, QQueryOperations>
      sincronizadoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sincronizado');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, double, QQueryOperations>
      stockResultanteProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stockResultante');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, String, QQueryOperations>
      tipoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tipo');
    });
  }

  QueryBuilder<MovimientoInventarioLocal, String, QQueryOperations>
      usuarioIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'usuarioId');
    });
  }
}
