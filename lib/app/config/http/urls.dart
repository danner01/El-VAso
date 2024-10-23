class Urls {
  //--------------- Auth ------------------
  static const login = 'auth/login';
  static const register = 'auth/register';
  static const registerSocial = 'auth/social';
  static const resendCode = 'auth/resend';
  static const verifyEmail = 'auth/verifyEmail';
  static const verifyRecoveryPass = 'auth/verif';
  static const velidate = 'auth/validate';
  static const verifyToken = 'auth/renewtoken';
  static const deactivate = 'user/deactivate';
  //--------- User ----------
  static const userMe = 'me';
  static const updateFToken = 'updateToken';
  static const updateUser = 'updateUser';
  static const deleteUser = 'user';
  static const searchUserByIndentification = 'searchUserByIndentification ';
  static const changePassword = 'user/password';
  //--------- Disco ----------
  static const getAllDisc = 'discos';
  static const discById = 'discos';
  static const updateDisco = 'discos';
  //--------- Event ----------
  static const createEvent = 'events';
  static const getAllEvents = 'events';
}
