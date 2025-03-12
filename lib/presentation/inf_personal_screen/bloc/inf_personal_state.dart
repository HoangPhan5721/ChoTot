import '../model/inf_personal_model.dart';

class InfPersonalState {
  final InfPersonalModel infPersonalModelObj;
  final bool isLoading;
  final String? error;

  InfPersonalState({
    required this.infPersonalModelObj,
    this.isLoading = false,
    this.error,
  });

  InfPersonalState copyWith({
    InfPersonalModel? infPersonalModelObj,
    bool? isLoading,
    String? error,
  }) {
    return InfPersonalState(
      infPersonalModelObj: infPersonalModelObj ?? this.infPersonalModelObj,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
