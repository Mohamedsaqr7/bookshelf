abstract class AuthState{}
class AuthInitState extends AuthState{}

class UserRegisterloadingState extends AuthState{}
class UserRegistersuccessState extends AuthState{}
class UserRegisterErrorState extends AuthState{}

class UserlogloadingState extends AuthState{}
class UserlogsuccessState extends AuthState{}
class UserlogErrorState extends AuthState{}