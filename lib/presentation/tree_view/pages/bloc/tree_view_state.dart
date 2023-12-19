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

  const TreeViewLoaded({required this.rootAssets});

  @override
  List<Object> get props => [rootAssets, super.props];
}

class TreeViewFailure extends TreeViewState {
  final String message;

  const TreeViewFailure({required this.message});

  @override
  List<Object> get props => [message, super.props];
}
