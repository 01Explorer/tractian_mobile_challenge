import 'package:equatable/equatable.dart';
import 'package:tractian_challenge/domain/entities/company_entity.dart';

abstract class TreeViewEvent extends Equatable {
  const TreeViewEvent();

  @override
  List<Object?> get props => [];
}

class LoadTreeViewEvent extends TreeViewEvent {
  final CompanyEntity company;

  const LoadTreeViewEvent({
    required this.company,
  });
  @override
  List<Object?> get props => [
        company,
        super.props,
      ];
}

class FilterTreeViewEvent extends TreeViewEvent {
  final CompanyEntity company;
  final String filter;
  final bool filterEnergySensor;
  final bool filterCriticalSensor;

  const FilterTreeViewEvent({
    required this.company,
    this.filter = '',
    this.filterEnergySensor = false,
    this.filterCriticalSensor = false,
  });

  @override
  List<Object?> get props => [
        company,
        filter,
        filterEnergySensor,
        filterCriticalSensor,
        super.props,
      ];
}
