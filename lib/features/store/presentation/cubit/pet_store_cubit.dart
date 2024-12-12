import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pet_store_state.dart';

class PetStoreCubit extends Cubit<PetStoreState> {
  PetStoreCubit() : super(PetStoreInitial());
}
