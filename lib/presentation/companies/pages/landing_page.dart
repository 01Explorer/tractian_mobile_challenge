import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';

import '../bloc/company_bloc.dart';
import '../bloc/company_event.dart';
import '../bloc/company_state.dart';
import 'components/company_list_tile_component.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompanyBloc, CompanyState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Image.asset('assets/images/logo.png'),
          ),
          body: switch (state) {
            (CompanyLoading _) => const _CompanyLoadingView(),
            (CompanyLoaded companyLoaded) =>
              _CompanyLoadedView(companies: companyLoaded.companies),
            (CompanyFailure state) =>
              _CompanyFailureView(message: state.message),
            _ => Container()
          },
        );
      },
    );
  }
}

class _CompanyLoadedView extends StatelessWidget {
  const _CompanyLoadedView({
    required this.companies,
  });

  final List<CompanyEntity> companies;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: companies.length,
      itemBuilder: (context, index) {
        return CompanyListTileComponent(company: companies[index]);
      },
    );
  }
}

class _CompanyLoadingView extends StatelessWidget {
  const _CompanyLoadingView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _CompanyFailureView extends StatelessWidget {
  const _CompanyFailureView({
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(message),
          ElevatedButton.icon(
            onPressed: () async {
              context.read<CompanyBloc>().add(LoadCompaniesEvent());
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Tentar Novamente'),
          )
        ],
      ),
    );
  }
}
