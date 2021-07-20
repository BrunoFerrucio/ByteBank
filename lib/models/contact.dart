class Contact{
  final int id;
  final String name;
  final int accountName;

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountName: $accountName}';
  }

  Contact(this.id, this.name, this.accountName);
}