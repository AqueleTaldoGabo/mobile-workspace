
import 'package:apk_agenda_contatos/database/model/contact_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ContactHelper {
  static final ContactHelper _instance = ContactHelper.internal();

  factory ContactHelper() => _instance;

  ContactHelper.internal();

  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    }

    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, "contactsDB.db");

    return await openDatabase(
      path,
      version: 2,
      onCreate: (Database db, int newVersion) async {
        await db.execute('''
          CREATE TABLE $contactTable (
            $idColumn INTEGER PRIMARY KEY AUTOINCREMENT,
            $nameColumn TEXT,
            $emailColumn TEXT,
            $phoneColumn TEXT,
            $imgColumn TEXT,
            $cepColumn TEXT DEFAULT '',
            $logradouroColumn TEXT DEFAULT '',
            $bairroColumn TEXT DEFAULT '',
            $cidadeColumn TEXT DEFAULT '',
            $estadoColumn TEXT DEFAULT '',
            $numeroColumn TEXT DEFAULT '',
            $complementoColumn TEXT DEFAULT ''
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          final colunas = [
            cepColumn,
            logradouroColumn,
            bairroColumn,
            cidadeColumn,
            estadoColumn,
            numeroColumn,
            complementoColumn,
          ];

          for (final coluna in colunas) {
            await db.execute(
              'ALTER TABLE $contactTable '
              'ADD COLUMN $coluna TEXT DEFAULT \'\'',
            );
          }
        }
      },
    );
  }

  Future<Contact> saveContact(Contact contact) async {
    final dbContact = await db;

    contact.id = await dbContact.insert(
      contactTable,
      contact.toMap(),
    );

    return contact;
  }

  Future<Contact?> getContact(int id) async {
    final dbContact = await db;

    final maps = await dbContact.query(
      contactTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    }

    return null;
  }

  Future<List<Contact>> getAllContacts() async {
    final dbContact = await db;

    final listMap = await dbContact.query(contactTable);

    return listMap.map((map) => Contact.fromMap(map)).toList();
  }

  Future<int> deleteContact(int id) async {
    final dbContact = await db;

    return dbContact.delete(
      contactTable,
      where: '$idColumn = ?',
      whereArgs: [id],
    );
  }

  Future<int> updateContact(Contact contact) async {
    final dbContact = await db;

    return dbContact.update(
      contactTable,
      contact.toMap(),
      where: '$idColumn = ?',
      whereArgs: [contact.id],
    );
  }
}
