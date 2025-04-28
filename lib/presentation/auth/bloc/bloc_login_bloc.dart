import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';
import 'package:training/data/dataresource/auth_remote_datasource.dart';
import 'package:training/data/model/response/auth_response_model.dart';

part 'bloc_login_event.dart';
part 'bloc_login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRemoteDataSource authRemoteDataSource;

  LoginBloc(this.authRemoteDataSource) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());

      final result = await authRemoteDataSource.login(event.email, event.password);

      result.fold(
        (l) {
          emit(LoginFailure(message: l));
        }, 
        (r) {
          emit(LoginSuccess(authResponseModel: r));
        }
      );
    });
  }
}
