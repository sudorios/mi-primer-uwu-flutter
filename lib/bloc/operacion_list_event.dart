import 'package:equatable/equatable.dart';

//Clase base para todos los eventos relacionados con la lista de operaciones

abstract class OperacionListEvent extends Equatable{

const OperacionListEvent();

@override

List<Object?> get props => [];}

//Programamos el evento que se dispara para escuchar los cambios en la lista de operaciones - Firestore

class OperacionListSubscribeEvent extends OperacionListEvent{}