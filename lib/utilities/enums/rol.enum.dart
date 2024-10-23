enum RolEnum { admin,superadmin,user }

extension RolEnumExtension on RolEnum {
  String get name {
    switch (this) {
      case RolEnum.admin:
        return 'admin';
      case RolEnum.superadmin:
        return 'superadmin';
      case RolEnum.user:
        return 'user';
    }
  }
}
