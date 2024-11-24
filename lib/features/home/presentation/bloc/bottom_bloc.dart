import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Events for BottomBloc
abstract class BottomEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event when a bottom navigation item is tapped
class BottomNavigationItemTapped extends BottomEvent {
  final int index;

  BottomNavigationItemTapped(this.index);

  @override
  List<Object?> get props => [index];
}

/// States for BottomBloc
abstract class BottomState extends Equatable {
  @override
  List<Object?> get props => [];
}

/// State to track the selected bottom navigation index
class BottomNavigationState extends BottomState {
  final int selectedIndex;

  BottomNavigationState(this.selectedIndex);

  @override
  List<Object?> get props => [selectedIndex];
}

/// BottomBloc to manage navigation
class BottomBloc extends Bloc<BottomEvent, BottomNavigationState> {
  BottomBloc() : super(BottomNavigationState(0)) {
    on<BottomNavigationItemTapped>(_onNavigationItemTapped);
  }

  void _onNavigationItemTapped(
      BottomNavigationItemTapped event, Emitter<BottomNavigationState> emit) {
    emit(BottomNavigationState(event.index));
  }
}
