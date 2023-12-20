import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/domain/entities/abstract_classes/item.dart';

abstract class TreeViewState extends Equatable {
  const TreeViewState();

  @override
  List<Object> get props => [];
}

class TreeViewInitial extends TreeViewState {}

class TreeViewLoading extends TreeViewState {}

class TreeViewLoaded extends TreeViewState {
  final List<Item> rootAssets;
  final bool isFilteredByEnergySensor;
  final bool isFilteredByCriticalSensor;
  final String filter;

  const TreeViewLoaded({
    required this.rootAssets,
    this.filter = '',
    this.isFilteredByEnergySensor = false,
    this.isFilteredByCriticalSensor = false,
  });

  TreeViewLoaded copyWith({
    List<Item>? rootAssets,
    bool? isFilteredByEnergySensor,
    bool? isFilteredByCriticalSensor,
    String? filter,
  }) {
    return TreeViewLoaded(
      rootAssets: rootAssets ?? this.rootAssets,
      isFilteredByEnergySensor:
          isFilteredByEnergySensor ?? this.isFilteredByEnergySensor,
      isFilteredByCriticalSensor:
          isFilteredByCriticalSensor ?? this.isFilteredByCriticalSensor,
      filter: filter ?? this.filter,
    );
  }

  @override
  List<Object> get props => [
        rootAssets,
        isFilteredByCriticalSensor,
        isFilteredByEnergySensor,
        filter,
        super.props
      ];
}

class TreeViewFailure extends TreeViewState {
  final String message;

  const TreeViewFailure({required this.message});

  @override
  List<Object> get props => [message, super.props];
}
