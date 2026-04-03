import 'package:get_it/get_it.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/feature/auth/data/data_source/remote/auth_remote_data_source.dart';
import 'package:redux_example/feature/auth/data/data_source/remote/auth_remote_data_source_impl.dart';
import 'package:redux_example/feature/auth/data/repository/auth_repository_impl.dart';
import 'package:redux_example/feature/auth/domain/repository/auth_repository.dart';
import 'package:redux_example/feature/auth/domain/use_case/sign_in_use_case.dart';
import 'package:redux_example/feature/auth/domain/use_case/sign_out_use_case.dart';

final class AuthDiModule implements DiModule {
  @override
  Future<void> register(GetIt instance) async {
    instance.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
    instance.registerSingleton<AuthRepository>(AuthRepositoryImpl(instance.get()));
    instance.registerSingleton(SignInUseCase(instance.get()));
    instance.registerSingleton(SignOutUseCase(instance.get()));
  }
}
