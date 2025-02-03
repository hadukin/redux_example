import 'package:get_it/get_it.dart';
import 'package:redux_example/di/di.dart';
import 'package:redux_example/features/auth/data/data_source/auth_remote_data_source.dart';
import 'package:redux_example/features/auth/data/data_source/auth_remote_data_source_impl.dart';
import 'package:redux_example/features/auth/data/repository/auth_repository_impl.dart';
import 'package:redux_example/features/auth/domain/repository/auth_repository.dart';
import 'package:redux_example/features/auth/domain/use_cases/auth_use_cases.dart';
import 'package:redux_example/features/auth/domain/use_cases/auth_use_cases_impl.dart';

final class AuthDiModule implements DiModule {
  @override
  Future<void> register(GetIt instance) async {
    instance.registerSingleton<AuthRemoteDataSource>(AuthRemoteDataSourceImpl());
    instance.registerSingleton<AuthRepository>(AuthRepositoryImpl(instance.get()));
    instance.registerSingleton<AuthUseCases>(AuthUseCasesImpl(instance.get()));
  }
}
