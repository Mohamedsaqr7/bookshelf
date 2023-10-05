abstract class AuthState{}
class AuthInitState extends AuthState{}

class UserRegisterloadingState extends AuthState{}
class UserRegistersuccessState extends AuthState{}
class UserRegisterErrorState extends AuthState{}

class UserlogloadingState extends AuthState{}
class UserlogsuccessState extends AuthState{}
class UserlogErrorState extends AuthState{}
class changecheckState extends AuthState{}

class UserlogoutloadingState extends AuthState{}
class UserlogoutsuccessState extends AuthState{}
class UserlogoutErrorState extends AuthState{}

class forgetpassloadingState extends AuthState{}
class forgetpasssuccessState extends AuthState{}
class forgetpassErrorState extends AuthState{}

class VerifyloadingState extends AuthState{}
class VerifysuccessState extends AuthState{}
class VerifyErrorState extends AuthState{}

class ResendverifyloadingState extends AuthState{}
class ResendverifysuccessState extends AuthState{}
class ResendverifyErrorState extends AuthState{}