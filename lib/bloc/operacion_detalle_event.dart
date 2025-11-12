import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class OperacionDetalleEvent extends Equatable {
  const OperacionDetalleEvent();

  @override
  List<Object?> get props => [];
}

class CargarOperacionDetalle extends OperacionDetalleEvent {
  final String docId;
  const CargarOperacionDetalle(this.docId);
  @override
  List<Object?> get props => [docId];
}