import 'package:bytebank/models/contact.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> getData() async {
  final String path = join(await getDatabasesPath(), 'bytebank.db');
  return openDatabase(
    path,
    onCreate: (db, version) {
      db.execute('CREATE TABLE contacts('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'account_number INTEGER)'
      ); // db.Create
    }, //onCreate
    version: 1,
    // onDowngrade: onDatabaseDowngradeDelete, // Quando retorna a versão do banco apaga TODOS os dados
  );
} // Cria banco de dados

Future<int> save(Contact contact) async{
  final Database db = await getData();
  final Map<String, dynamic> contactMap = Map();
  contactMap['id'] = contact.id;
  contactMap['name'] = contact.name;
  contactMap['account_number'] = contact.accountName;

  return db.insert('contacts', contactMap);
} // Salva contato

Future<List<Contact>> findAll() async{
  final Database db = await getData();
  final List<Map<String, dynamic>> result = await db.query('contacts');
  final List<Contact> contacts = [];
  for (Map<String, dynamic> row in result) {
    final Contact contact = Contact(
      row['id'],
      row['name'],
      row['account_number'],
    );
    contacts.add(contact);
  }
// Pega o resultado e coloca em uma lista para ser retornado
} // Exibi todos os contatos