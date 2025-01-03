import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portal/core/service_locator/get_it.dart';
import 'package:portal/features/submissions/presentation/bloc/submissions/submission_cubit.dart';
import 'package:portal/features/submissions/presentation/widgets/submission_page_body.dart';

class SubmissionsPage extends StatelessWidget {
  const SubmissionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SubmissionCubit>()..loadAllSubmissions(),
      child: const SubmissionPageBody(),
    );
  }
}
