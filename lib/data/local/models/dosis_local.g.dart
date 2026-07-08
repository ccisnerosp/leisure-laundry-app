// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dosis_local.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetDosisLocalCollection on Isar {
  IsarCollection<DosisLocal> get dosisLocals => this.collection();
}

const DosisLocalSchema = CollectionSchema(
  name: r'DosisLocal',
  id: -7834897781154091125,
  properties: {
    r'dosis': PropertySchema(
      id: 0,
      name: r'dosis',
      type: IsarType.double,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'insumoId': PropertySchema(
      id: 2,
      name: r'insumoId',
      type: IsarType.string,
    ),
    r'insumoNombre': PropertySchema(
      id: 3,
      name: r'insumoNombre',
      type: IsarType.string,
    ),
    r'insumoUnidad': PropertySchema(
      id: 4,
      name: r'insumoUnidad',
      type: IsarType.string,
    ),
    r'programaId': PropertySchema(
      id: 5,
      name: r'programaId',
      type: IsarType.string,
    )
  },
  estimateSize: _dosisLocalEstimateSize,
  serialize: _dosisLocalSerialize,
  deserialize: _dosisLocalDeserialize,
  deserializeProp: _dosisLocalDeserializeProp,
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
    r'programaId': IndexSchema(
      id: 5452496480357072346,
      name: r'programaId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'programaId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _dosisLocalGetId,
  getLinks: _dosisLocalGetLinks,
  attach: _dosisLocalAttach,
  version: '3.1.0+1',
);

int _dosisLocalEstimateSize(
  DosisLocal object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.insumoId.length * 3;
  {
    final value = object.insumoNombre;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.insumoUnidad;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.programaId.length * 3;
  return bytesCount;
}

void _dosisLocalSerialize(
  DosisLocal object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDouble(offsets[0], object.dosis);
  writer.writeString(offsets[1], object.id);
  writer.writeString(offsets[2], object.insumoId);
  writer.writeString(offsets[3], object.insumoNombre);
  writer.writeString(offsets[4], object.insumoUnidad);
  writer.writeString(offsets[5], object.programaId);
}

DosisLocal _dosisLocalDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = DosisLocal();
  object.dosis = reader.readDouble(offsets[0]);
  object.id = reader.readString(offsets[1]);
  object.insumoId = reader.readString(offsets[2]);
  object.insumoNombre = reader.readStringOrNull(offsets[3]);
  object.insumoUnidad = reader.readStringOrNull(offsets[4]);
  object.isarId = id;
  object.programaId = reader.readString(offsets[5]);
  return object;
}

P _dosisLocalDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDouble(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _dosisLocalGetId(DosisLocal object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _dosisLocalGetLinks(DosisLocal object) {
  return [];
}

void _dosisLocalAttach(IsarCollection<dynamic> col, Id id, DosisLocal object) {
  object.isarId = id;
}

extension DosisLocalByIndex on IsarCollection<DosisLocal> {
  Future<DosisLocal?> getById(String id) {
    return getByIndex(r'id', [id]);
  }

  DosisLocal? getByIdSync(String id) {
    return getByIndexSync(r'id', [id]);
  }

  Future<bool> deleteById(String id) {
    return deleteByIndex(r'id', [id]);
  }

  bool deleteByIdSync(String id) {
    return deleteByIndexSync(r'id', [id]);
  }

  Future<List<DosisLocal?>> getAllById(List<String> idValues) {
    final values = idValues.map((e) => [e]).toList();
    return getAllByIndex(r'id', values);
  }

  List<DosisLocal?> getAllByIdSync(List<String> idValues) {
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

  Future<Id> putById(DosisLocal object) {
    return putByIndex(r'id', object);
  }

  Id putByIdSync(DosisLocal object, {bool saveLinks = true}) {
    return putByIndexSync(r'id', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllById(List<DosisLocal> objects) {
    return putAllByIndex(r'id', objects);
  }

  List<Id> putAllByIdSync(List<DosisLocal> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'id', objects, saveLinks: saveLinks);
  }
}

extension DosisLocalQueryWhereSort
    on QueryBuilder<DosisLocal, DosisLocal, QWhere> {
  QueryBuilder<DosisLocal, DosisLocal, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension DosisLocalQueryWhere
    on QueryBuilder<DosisLocal, DosisLocal, QWhereClause> {
  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> isarIdEqualTo(
      Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> isarIdNotEqualTo(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> isarIdGreaterThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> isarIdLessThan(
      Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> idEqualTo(String id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'id',
        value: [id],
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> idNotEqualTo(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> programaIdEqualTo(
      String programaId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'programaId',
        value: [programaId],
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterWhereClause> programaIdNotEqualTo(
      String programaId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'programaId',
              lower: [],
              upper: [programaId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'programaId',
              lower: [programaId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'programaId',
              lower: [programaId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'programaId',
              lower: [],
              upper: [programaId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension DosisLocalQueryFilter
    on QueryBuilder<DosisLocal, DosisLocal, QFilterCondition> {
  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> dosisEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dosis',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> dosisGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dosis',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> dosisLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dosis',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> dosisBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dosis',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idEqualTo(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idBetween(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idStartsWith(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idEndsWith(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idContains(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idMatches(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> insumoIdEqualTo(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoIdGreaterThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> insumoIdLessThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> insumoIdBetween(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoIdStartsWith(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> insumoIdEndsWith(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> insumoIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insumoId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> insumoIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insumoId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoId',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insumoId',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'insumoNombre',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'insumoNombre',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreEqualTo(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreGreaterThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreLessThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreBetween(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreStartsWith(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreEndsWith(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insumoNombre',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insumoNombre',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoNombreIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insumoNombre',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'insumoUnidad',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'insumoUnidad',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoUnidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'insumoUnidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'insumoUnidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'insumoUnidad',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'insumoUnidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'insumoUnidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'insumoUnidad',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'insumoUnidad',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'insumoUnidad',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      insumoUnidadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'insumoUnidad',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> isarIdEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> isarIdGreaterThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> isarIdLessThan(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> isarIdBetween(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> programaIdEqualTo(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> programaIdBetween(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      programaIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'programaId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition> programaIdMatches(
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

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      programaIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'programaId',
        value: '',
      ));
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterFilterCondition>
      programaIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'programaId',
        value: '',
      ));
    });
  }
}

extension DosisLocalQueryObject
    on QueryBuilder<DosisLocal, DosisLocal, QFilterCondition> {}

extension DosisLocalQueryLinks
    on QueryBuilder<DosisLocal, DosisLocal, QFilterCondition> {}

extension DosisLocalQuerySortBy
    on QueryBuilder<DosisLocal, DosisLocal, QSortBy> {
  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByDosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosis', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByDosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosis', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByInsumoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByInsumoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByInsumoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByInsumoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByInsumoUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoUnidad', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByInsumoUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoUnidad', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByProgramaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> sortByProgramaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.desc);
    });
  }
}

extension DosisLocalQuerySortThenBy
    on QueryBuilder<DosisLocal, DosisLocal, QSortThenBy> {
  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByDosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosis', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByDosisDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dosis', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByInsumoId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByInsumoIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoId', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByInsumoNombre() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByInsumoNombreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoNombre', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByInsumoUnidad() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoUnidad', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByInsumoUnidadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'insumoUnidad', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByProgramaId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.asc);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QAfterSortBy> thenByProgramaIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'programaId', Sort.desc);
    });
  }
}

extension DosisLocalQueryWhereDistinct
    on QueryBuilder<DosisLocal, DosisLocal, QDistinct> {
  QueryBuilder<DosisLocal, DosisLocal, QDistinct> distinctByDosis() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dosis');
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QDistinct> distinctById(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'id', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QDistinct> distinctByInsumoId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insumoId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QDistinct> distinctByInsumoNombre(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insumoNombre', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QDistinct> distinctByInsumoUnidad(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'insumoUnidad', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<DosisLocal, DosisLocal, QDistinct> distinctByProgramaId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'programaId', caseSensitive: caseSensitive);
    });
  }
}

extension DosisLocalQueryProperty
    on QueryBuilder<DosisLocal, DosisLocal, QQueryProperty> {
  QueryBuilder<DosisLocal, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<DosisLocal, double, QQueryOperations> dosisProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dosis');
    });
  }

  QueryBuilder<DosisLocal, String, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<DosisLocal, String, QQueryOperations> insumoIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insumoId');
    });
  }

  QueryBuilder<DosisLocal, String?, QQueryOperations> insumoNombreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insumoNombre');
    });
  }

  QueryBuilder<DosisLocal, String?, QQueryOperations> insumoUnidadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'insumoUnidad');
    });
  }

  QueryBuilder<DosisLocal, String, QQueryOperations> programaIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'programaId');
    });
  }
}
