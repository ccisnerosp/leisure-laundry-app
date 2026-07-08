// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insumo_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetInsumoLocalCollection on Isar {
  IsarCollection<InsumoLocal> get insumoLocals => this.collection();
}

const InsumoLocalSchema = CollectionSchema(
  name: r'InsumoLocal',
  id: -8561231351379322860,
  properties: {
    r'activo': PropertySchema(
      id: 0,
      name: r'activo',
      type: IsarType.bool,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'nombre': PropertySchema(
      id: 2,
      name: r'nombre',
      type: IsarType.string,
    ),
    r'stockActual': PropertySchema(
      id: 3,
      name: r'stockActual',
      type: IsarType.double,
    ),
    r'umbralMinimo': PropertySchema(
      id: 4,
      name: r'umbralMinimo',
      type: IsarType.double,
    ),
    r'unidad': PropertySchema(
      id: 5,
      name: r'unidad',
      type: IsarType.string,
    )
  },
  estimateSize: _insumoLocalEstimateSize,
  serialize: _insumoLocalSerialize,
  deserialize: _insumoLocalDeserialize,
  deserializeProp: _insumoLocalDeserializeProp,
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
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _insumoLocalGetId,
  getLinks: _insumoLocalGetLinks,
  attach: _insumoLocalAttach,
  version: '3.1.0+1',
);

int _insumoLocalEstimateSize(
  InsumoLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.nombre.length * 3;
  bytesCount += 3 + object.unidad.length * 3;
  return bytesCount;
}

void _insumoLocalSerialize(
  InsumoLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.activo);
  writer.writeString(offsets[1], object.id);
  writer.writeString(offsets[2], object.nombre);
  writer.writeDouble(offsets[3], object.stockActual);
  writer.writeDouble(offsets[4], object.umbralMinimo);
  writer.writeString(offsets[5], object.unidad);
}

InsumoLocal _insumoLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = InsumoLocal();
  object.activo = reader.readBool(offsets[0]);
  object.id = reader.readString(offsets[1]);
  object.isarId = id;
  object.nombre = reader.readString(offsets[2]);
  object.stockActual = reader.readDouble(offsets[3]);
  object.umbralMinimo = reader.readDouble(offsets[4]);
  object.unidad = reader.readString(offsets[5]);
  return object;
}

P _insumoLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBool(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readDouble(offset)) as P;
    case 4:
      return (reader.readDouble(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _insumoLocalGetId(InsumoLocal object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _insumoLocalGetLinks(InsumoLocal object) {
  return [];
}

void _insumoLocalAttach(
    IsarCollection<dynamic> col, Id id, InsumoLocal object) {
  object.isarId = id;
}

extension InsumoLocalByIndex on IsarCollection<InsumoLocal> {
  Future<InsumoLocal?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  InsumoLocal? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<InsumoLocal?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<InsumoLocal?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(InsumoLocal object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(InsumoLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<InsumoLocal> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<InsumoLocal> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension InsumoLocalQueryWhereSort
    on QueryBuilder<InsumoLocal, InsumoLocal, QWhere> {
  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension InsumoLocalQueryWhere
    on QueryBuilder<InsumoLocal, InsumoLocal, QWhereClause> {
  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> idEqualTo(
      String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterWhereClause> idNotEqualTo(
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
}

extension InsumoLocalQueryFilter
    on QueryBuilder<InsumoLocal, InsumoLocal, QFilterCondition> {
  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> activoEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'activo',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idContains(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idMatches(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      isarIdGreaterThan(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> nombreEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      nombreGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> nombreLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> nombreBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nombre',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      nombreStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> nombreEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> nombreContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> nombreMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      nombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      nombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nombre',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      stockActualEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'stockActual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      stockActualGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'stockActual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      stockActualLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'stockActual',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      stockActualBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'stockActual',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      umbralMinimoEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'umbralMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      umbralMinimoGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'umbralMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      umbralMinimoLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'umbralMinimo',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      umbralMinimoBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'umbralMinimo',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> unidadEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      unidadGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'unidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> unidadLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'unidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> unidadBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'unidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      unidadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'unidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> unidadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'unidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> unidadContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'unidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition> unidadMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'unidad',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      unidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'unidad',
        value: '',
      ));
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterFilterCondition>
      unidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'unidad',
        value: '',
      ));
    });
  }
}

extension InsumoLocalQueryObject
    on QueryBuilder<InsumoLocal, InsumoLocal, QFilterCondition> {}

extension InsumoLocalQueryLinks
    on QueryBuilder<InsumoLocal, InsumoLocal, QFilterCondition> {}

extension InsumoLocalQuerySortBy
    on QueryBuilder<InsumoLocal, InsumoLocal, QSortBy> {
  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByActivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByStockActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockActual', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByStockActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockActual', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByUmbralMinimo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy>
      sortByUmbralMinimoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> sortByUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.desc);
    });
  }
}

extension InsumoLocalQuerySortThenBy
    on QueryBuilder<InsumoLocal, InsumoLocal, QSortThenBy> {
  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByActivoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'activo', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nombre', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByStockActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockActual', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByStockActualDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'stockActual', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByUmbralMinimo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy>
      thenByUmbralMinimoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'umbralMinimo', Sort.desc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.asc);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QAfterSortBy> thenByUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unidad', Sort.desc);
    });
  }
}

extension InsumoLocalQueryWhereDistinct
    on QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> {
  QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> distinctByActivo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'activo');
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> distinctByNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> distinctByStockActual() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'stockActual');
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> distinctByUmbralMinimo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'umbralMinimo');
    });
  }

  QueryBuilder<InsumoLocal, InsumoLocal, QDistinct> distinctByUnidad(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unidad', caseSensitive: caseSensitive);
    });
  }
}

extension InsumoLocalQueryProperty
    on QueryBuilder<InsumoLocal, InsumoLocal, QQueryProperty> {
  QueryBuilder<InsumoLocal, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<InsumoLocal, bool, QQueryOperations> activoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'activo');
    });
  }

  QueryBuilder<InsumoLocal, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<InsumoLocal, String, QQueryOperations> nombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nombre');
    });
  }

  QueryBuilder<InsumoLocal, double, QQueryOperations> stockActualProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'stockActual');
    });
  }

  QueryBuilder<InsumoLocal, double, QQueryOperations> umbralMinimoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'umbralMinimo');
    });
  }

  QueryBuilder<InsumoLocal, String, QQueryOperations> unidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unidad');
    });
  }
}
