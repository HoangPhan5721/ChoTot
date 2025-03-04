part of 'personal_bloc.dart';

/// Represents the state of Personal in the application.
// ignore_for_file: must_be_immutable
class PersonalState extends Equatable {
  PersonalState({this.PersonalModelObj});

  PersonalModel? PersonalModelObj;

  @override
  List<Object?> get props => [PersonalModelObj];

  PersonalState copyWith({PersonalModel? PersonalModelObj}) {
    return PersonalState(
      PersonalModelObj: PersonalModelObj ?? this.PersonalModelObj,
    );
  }
}
