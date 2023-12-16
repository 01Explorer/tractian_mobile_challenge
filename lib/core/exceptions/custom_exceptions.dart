import 'package:equatable/equatable.dart';

class CompanyException extends Equatable implements Exception {
  final String message;

  const CompanyException({required this.message});

  @override
  List<Object?> get props => [message];
}
