// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/home_page/application/add_question/add_question_cubit.dart'
    as _i216;
import '../../features/home_page/application/question/question_cubit.dart'
    as _i980;
import '../../features/home_page/application/question_details/question_details_cubit.dart'
    as _i469;
import '../../features/home_page/application/submissions/submission_cubit.dart'
    as _i691;
import '../../features/home_page/domain/repositories/i_question_repository.dart'
    as _i404;
import '../../features/home_page/domain/repositories/i_submission_repository.dart'
    as _i106;
import '../../features/home_page/infrastructure/repositories/question_repository_impl.dart'
    as _i421;
import '../../features/home_page/infrastructure/repositories/submission_repository_impl.dart'
    as _i429;
import '../database/database.dart' as _i660;
import 'database_module.dart' as _i384;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final databaseModule = _$DatabaseModule();
    await gh.factoryAsync<_i660.AppDatabase>(
      () => databaseModule.database,
      preResolve: true,
    );
    gh.factory<_i106.ISubmissionRepository>(
        () => _i429.SubmissionRepositoryImpl(gh<_i660.AppDatabase>()));
    gh.factory<_i469.QuestionDetailsCubit>(
        () => _i469.QuestionDetailsCubit(gh<_i106.ISubmissionRepository>()));
    gh.factory<_i404.IQuestionRepository>(
        () => _i421.QuestionRepositoryImpl(gh<_i660.AppDatabase>()));
    gh.factory<_i980.QuestionCubit>(
        () => _i980.QuestionCubit(gh<_i404.IQuestionRepository>()));
    gh.factory<_i216.AddQuestionCubit>(
        () => _i216.AddQuestionCubit(gh<_i404.IQuestionRepository>()));
    gh.factory<_i691.SubmissionCubit>(
        () => _i691.SubmissionCubit(gh<_i106.ISubmissionRepository>()));
    return this;
  }
}

class _$DatabaseModule extends _i384.DatabaseModule {}
