import 'package:flutter_bloc/flutter_bloc.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  int currentIndex = 0;

  NavigationCubit() : super(NavigationInitial());

  void changeTab(int index) {
    currentIndex = index;
    emit(NavigationChanged(index));
  }
}