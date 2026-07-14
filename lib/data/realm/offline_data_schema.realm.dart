// // dart format width=80
// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'offline_data_schema.dart';

// // **************************************************************************
// // RealmObjectGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: type=lint
// class OfflineDataSchema extends _OfflineDataSchema
//     with RealmEntity, RealmObjectBase, RealmObject {
//   OfflineDataSchema(
//     String primaryKey,
//     DateTime timestamp,
//     String jsonData,
//   ) {
//     RealmObjectBase.set(this, 'primaryKey', primaryKey);
//     RealmObjectBase.set(this, 'timestamp', timestamp);
//     RealmObjectBase.set(this, 'jsonData', jsonData);
//   }

//   OfflineDataSchema._();

//   @override
//   String get primaryKey =>
//       RealmObjectBase.get<String>(this, 'primaryKey') as String;
//   @override
//   set primaryKey(String value) =>
//       RealmObjectBase.set(this, 'primaryKey', value);

//   @override
//   DateTime get timestamp =>
//       RealmObjectBase.get<DateTime>(this, 'timestamp') as DateTime;
//   @override
//   set timestamp(DateTime value) =>
//       RealmObjectBase.set(this, 'timestamp', value);

//   @override
//   String get jsonData =>
//       RealmObjectBase.get<String>(this, 'jsonData') as String;
//   @override
//   set jsonData(String value) => RealmObjectBase.set(this, 'jsonData', value);

//   @override
//   Stream<RealmObjectChanges<OfflineDataSchema>> get changes =>
//       RealmObjectBase.getChanges<OfflineDataSchema>(this);

//   @override
//   Stream<RealmObjectChanges<OfflineDataSchema>> changesFor(
//           [List<String>? keyPaths]) =>
//       RealmObjectBase.getChangesFor<OfflineDataSchema>(this, keyPaths);

//   @override
//   OfflineDataSchema freeze() =>
//       RealmObjectBase.freezeObject<OfflineDataSchema>(this);

//   EJsonValue toEJson() {
//     return <String, dynamic>{
//       'primaryKey': primaryKey.toEJson(),
//       'timestamp': timestamp.toEJson(),
//       'jsonData': jsonData.toEJson(),
//     };
//   }

//   static EJsonValue _toEJson(OfflineDataSchema value) => value.toEJson();
//   static OfflineDataSchema _fromEJson(EJsonValue ejson) {
//     if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
//     return switch (ejson) {
//       {
//         'primaryKey': EJsonValue primaryKey,
//         'timestamp': EJsonValue timestamp,
//         'jsonData': EJsonValue jsonData,
//       } =>
//         OfflineDataSchema(
//           fromEJson(primaryKey),
//           fromEJson(timestamp),
//           fromEJson(jsonData),
//         ),
//       _ => raiseInvalidEJson(ejson),
//     };
//   }

//   static final schema = () {
//     RealmObjectBase.registerFactory(OfflineDataSchema._);
//     register(_toEJson, _fromEJson);
//     return const SchemaObject(
//         ObjectType.realmObject, OfflineDataSchema, 'OfflineDataSchema', [
//       SchemaProperty('primaryKey', RealmPropertyType.string, primaryKey: true),
//       SchemaProperty('timestamp', RealmPropertyType.timestamp),
//       SchemaProperty('jsonData', RealmPropertyType.string),
//     ]);
//   }();

//   @override
//   SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
// }
