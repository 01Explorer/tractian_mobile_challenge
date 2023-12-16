import 'package:equatable/equatable.dart';

interface class Failure extends Equatable {
  final String message;

  const Failure({required this.message});

  @override
  List<Object?> get props => [message];
}

class CompanyFailure extends Failure {
  const CompanyFailure({required String message}) : super(message: message);
}
