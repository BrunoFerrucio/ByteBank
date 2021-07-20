import 'package:bytebank/database/app_database.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
      ),
      body: FutureBuilder<List<Contact>>(
        initialData: [],
        future: Future.delayed(Duration(seconds: 1)).then((value) => findAll()), //Busca os contatos
        builder: (context, snapshot) {
          switch(snapshot.connectionState) {
            case ConnectionState.none:
            // Future ainda não executado
              break;
            case ConnectionState.waiting:
            // Estado de carregamento
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text('Carregando...'),
                  ],
                ),
              );
              break;
            case ConnectionState.active:
            // Exibi os dados conforme forem ficando prontos
              break;
            case ConnectionState.done:
            // Devolve tudo o que foi carregado de uma vez
              final List<Contact> contacts = snapshot.data;
              return ListView.builder(
                itemBuilder: (context, index) {
                  final Contact contact = contacts[index];
                  return _ContactItem(contact);
                },
                itemCount: contacts.length,
              );
              break;
          }
          return Text('Unknown error switch');
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ContactForm()),
          ).then((newContact) => debugPrint(newContact.toString()));
        },
      ),
    );
  }
}

class _ContactItem extends StatelessWidget {

  final Contact contact;

  _ContactItem(this.contact)

  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 24.0),
        ),
        subtitle: Text(
          contact.accountName.toString(),
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}