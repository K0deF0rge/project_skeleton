enum Modules {
  products,
  users;

  static Modules fromString(String role) {
    switch (role.toLowerCase()) {
      case 'users':
        return Modules.users;
      case 'products':
      default:
        return Modules.products;
    }
  }

  String toShortString() => name;
}
