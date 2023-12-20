import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helpers/constansts.dart';
import '../../../domain/entities/abstract_classes/item.dart';
import '../../../domain/entities/company_entity.dart';
import '../../../injection_container.dart';
import '../bloc/tree_view_bloc.dart';
import '../bloc/tree_view_event.dart';
import '../bloc/tree_view_state.dart';
import 'components/tree_component.dart';

class TreeView extends StatelessWidget {
  final CompanyEntity company;
  const TreeView({super.key, required this.company});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            company.name,
          ),
        ),
        body: BlocBuilder<TreeViewBloc, TreeViewState>(
          builder: (context, state) {
            return switch (state) {
              (TreeViewLoading _) => const Center(
                  child: CircularProgressIndicator(),
                ),
              (TreeViewLoaded treeViewLoaded) => Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: _FilterSection(
                        company: company,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Expanded(
                        child: SingleChildScrollView(
                      child: Column(
                        children: treeViewLoaded.rootAssets
                            .map<Widget>((e) => TreeComponent(itemToBuild: e))
                            .toList(),
                      ),
                    ))
                  ],
                ),
              (TreeViewFailure failure) => Center(
                  child: Column(
                    children: [
                      Text(
                        failure.message,
                        style: const TextStyle(color: Colors.black),
                      ),
                      ElevatedButton(
                        onPressed: () => locator<TreeViewBloc>()
                            .add(LoadTreeViewEvent(company: company)),
                        child: const Text('Tentar novamente'),
                      )
                    ],
                  ),
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _FilterSection extends StatefulWidget {
  final CompanyEntity company;
  const _FilterSection({required this.company});

  @override
  State<_FilterSection> createState() => _FilterSectionState();
}

class _FilterSectionState extends State<_FilterSection> {
  late final TextEditingController _textEditingController;
  late bool filterEnergySensor;
  late bool filterCriticalSensor;
  late List<Item> rootAssets;

  @override
  void initState() {
    super.initState();
    final blocState = context.read<TreeViewBloc>().state as TreeViewLoaded;
    _textEditingController = TextEditingController(text: blocState.filter);
    filterEnergySensor = blocState.isFilteredByEnergySensor;
    filterCriticalSensor = blocState.isFilteredByCriticalSensor;
    rootAssets = blocState.rootAssets;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocListener<TreeViewBloc, TreeViewState>(
      listener: (context, state) {
        if (state is TreeViewLoaded) {
          setState(() {
            _textEditingController.text = state.filter;
            filterEnergySensor = state.isFilteredByEnergySensor;
            filterCriticalSensor = state.isFilteredByCriticalSensor;
          });
        }
      },
      child: Column(
        children: [
          SizedBox(
            width: screenSize.width,
            height: screenSize.height * 0.07,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Color(0xffEAEFF3),
                        contentPadding: EdgeInsets.all(2),
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Buscar Ativo ou Local',
                      ),
                      onChanged: (value) => _textEditingController.text = value,
                      onFieldSubmitted: (value) {
                        context.read<TreeViewBloc>().add(
                              FilterTreeViewEvent(
                                company: widget.company,
                                filter: value,
                                filterEnergySensor: filterEnergySensor,
                                filterCriticalSensor: filterCriticalSensor,
                              ),
                            );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: companiesColors,
                    child: const Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: screenSize.height * 0.06,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TreeViewBloc>().add(
                            FilterTreeViewEvent(
                              company: widget.company,
                              filter: _textEditingController.text,
                              filterEnergySensor: !filterEnergySensor,
                              filterCriticalSensor: filterCriticalSensor,
                            ),
                          );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.bolt_rounded,
                          color: filterEnergySensor
                              ? companiesColors
                              : Colors.grey,
                        ),
                        Flexible(
                          child: Text(
                            'Sensor de Energia',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color:
                                      filterEnergySensor ? null : Colors.grey,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<TreeViewBloc>().add(
                            FilterTreeViewEvent(
                              company: widget.company,
                              filter: _textEditingController.text,
                              filterEnergySensor: filterEnergySensor,
                              filterCriticalSensor: !filterCriticalSensor,
                            ),
                          );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.error_outline_rounded,
                          color: filterCriticalSensor
                              ? companiesColors
                              : Colors.grey,
                        ),
                        Flexible(
                          child: Text(
                            'Crítico',
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(
                                  color:
                                      filterCriticalSensor ? null : Colors.grey,
                                ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
