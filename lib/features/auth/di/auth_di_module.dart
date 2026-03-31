import 'package:get_it/get_it.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:redux_example/features/auth/data/data_source/auth_remote_data_source_impl.dart';
import 'package:redux_example/features/auth/data/repository/auth_repository_impl.dart';
import 'package:redux_example/features/auth/domain/repository/auth_repository.dart';
import 'package:redux_example/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:redux_example/features/auth/domain/use_cases/sign_out_use_case.dart';

final class AuthDiModule implements DiModule {
  @override
  Future<void> register(GetIt instance) async {
    instance.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
    instance.registerSingleton<AuthRepository>(AuthRepositoryImpl(instance.get()));
    instance.registerSingleton(SignInUseCase(instance.get()));
    instance.registerSingleton(SignOutUseCase(instance.get()));
  }
}
