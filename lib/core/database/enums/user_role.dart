enum UserRole {
  admin('admin', 'Administrador'),
  user('user', 'Usuário');

  const UserRole(this.value, this.displayName);

  final String value;
  final String displayName;

  static UserRole fromString(String value) {
    switch (value) {
      case 'admin':
        return UserRole.admin;
      case 'user':
        return UserRole.user;
      default:
        return UserRole.user;
    }
  }

  bool get isAdmin => this == UserRole.admin;
  bool get isUser => this == UserRole.user;
}