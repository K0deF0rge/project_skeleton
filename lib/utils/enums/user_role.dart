enum UserRole {
  owner,
  user;

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'owner':
        return UserRole.owner;
      case 'user':
      default:
        return UserRole.user;
    }
  }

  String toShortString() => name;
}
