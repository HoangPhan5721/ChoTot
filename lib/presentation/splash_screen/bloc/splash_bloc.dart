
import 'package:equatable/equatable.dart';
import 'package:intern/core/app_export.dart';
import '../models/splash_model.dart';
part 'splash_event.dart';
part 'splash_state.dart';
/// A bloc that manages the state of a Splash according to the event that is dispatched to it.
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc(SplashState initialstate) : super(initialstate) {
    on<SplashInitialEvent>(_onInitialize);
  }

  _onInitialize(SplashInitialEvent event,
      Emitter<SplashState> emit,) async {
    Future.delayed(const Duration(milliseconds: 3000), () {
      NavigatorService.popAndPushNamed(
        AppRoutes.loginScreen,
      );
    });
  }
}