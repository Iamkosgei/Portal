// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/questions/presentation/bloc/add_question/add_question_cubit.dart'
    as _i216;
import '../../features/questions/presentation/bloc/delete_question/delete_question_cubit.dart'
    as _i182;
import '../../features/questions/presentation/bloc/question/question_cubit.dart'
    as _i980;
import '../../features/questions/presentation/bloc/question_details/question_details_cubit.dart'
    as _i469;
import '../../features/submissions/presentation/bloc/submissions/submission_cubit.dart'
    as _i691;
import '../../features/questions/domain/repositories/i_question_repository.dart'
    as _i404;
import '../../features/submissions/domain/repositories/i_submission_repository.dart'
    as _i106;
import '../../features/questions/data/repositories/question_repository_impl.dart'
    as _i421;
import '../../features/submissions/data/repositories/submission_repository_impl.dart'
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
    gh.factory<_i182.DeleteQuestionCubit>(
        () => _i182.DeleteQuestionCubit(gh<_i404.IQuestionRepository>()));
    gh.factory<_i691.SubmissionCubit>(
        () => _i691.SubmissionCubit(gh<_i106.ISubmissionRepository>()));
    return this;
  }
}

class _$DatabaseModule extends _i384.DatabaseModule {}
