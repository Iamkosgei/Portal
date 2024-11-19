// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/questions/data/repositories/question_repository_impl.dart'
    as _i758;
import '../../features/questions/domain/repositories/i_question_repository.dart'
    as _i341;
import '../../features/questions/presentation/bloc/add_question/add_question_cubit.dart'
    as _i446;
import '../../features/questions/presentation/bloc/delete_question/delete_question_cubit.dart'
    as _i619;
import '../../features/questions/presentation/bloc/question/question_cubit.dart'
    as _i483;
import '../../features/questions/presentation/bloc/question_details/question_details_cubit.dart'
    as _i351;
import '../../features/submissions/data/repositories/submission_repository_impl.dart'
    as _i772;
import '../../features/submissions/domain/repositories/i_submission_repository.dart'
    as _i144;
import '../../features/submissions/presentation/bloc/submissions/submission_cubit.dart'
    as _i34;
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
    gh.factory<_i144.ISubmissionRepository>(
        () => _i772.SubmissionRepositoryImpl(gh<_i660.AppDatabase>()));
    gh.factory<_i341.IQuestionRepository>(
        () => _i758.QuestionRepositoryImpl(gh<_i660.AppDatabase>()));
    gh.factory<_i34.SubmissionCubit>(
        () => _i34.SubmissionCubit(gh<_i144.ISubmissionRepository>()));
    gh.factory<_i483.QuestionCubit>(
        () => _i483.QuestionCubit(gh<_i341.IQuestionRepository>()));
    gh.factory<_i446.AddQuestionCubit>(
        () => _i446.AddQuestionCubit(gh<_i341.IQuestionRepository>()));
    gh.factory<_i619.DeleteQuestionCubit>(
        () => _i619.DeleteQuestionCubit(gh<_i341.IQuestionRepository>()));
    gh.factory<_i351.QuestionDetailsCubit>(
        () => _i351.QuestionDetailsCubit(gh<_i144.ISubmissionRepository>()));
    return this;
  }
}

class _$DatabaseModule extends _i384.DatabaseModule {}
