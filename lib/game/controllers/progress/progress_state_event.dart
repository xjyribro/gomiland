part of 'progress_state_bloc.dart';

abstract class ProgressStateEvent extends Equatable {
  const ProgressStateEvent();
}

class PlasticProgressChange extends ProgressStateEvent {
  const PlasticProgressChange(this.plastic);

  final int plastic;

  @override
  List<Object?> get props => [plastic];
}

class PaperProgressChange extends ProgressStateEvent {
  const PaperProgressChange(this.paper);

  final int paper;

  @override
  List<Object?> get props => [paper];
}

class MetalProgressChange extends ProgressStateEvent {
  const MetalProgressChange(this.metal);

  final int metal;

  @override
  List<Object?> get props => [metal];
}

class ElectronicsProgressChange extends ProgressStateEvent {
  const ElectronicsProgressChange(this.electronics);

  final int electronics;

  @override
  List<Object?> get props => [electronics];
}

class GlassProgressChange extends ProgressStateEvent {
  const GlassProgressChange(this.glass);

  final int glass;

  @override
  List<Object?> get props => [glass];
}

class FoodProgressChange extends ProgressStateEvent {
  const FoodProgressChange(this.food);

  final int food;

  @override
  List<Object?> get props => [food];
}

class QianBiProgressChange extends ProgressStateEvent {
  const QianBiProgressChange(this.qianBi);

  final int qianBi;

  @override
  List<Object?> get props => [qianBi];
}

class ManukaProgressChange extends ProgressStateEvent {
  const ManukaProgressChange(this.manuka);

  final int manuka;

  @override
  List<Object?> get props => [manuka];
}

class StarkProgressChange extends ProgressStateEvent {
  const StarkProgressChange(this.stark);

  final int stark;

  @override
  List<Object?> get props => [stark];
}

class AsimovProgressChange extends ProgressStateEvent {
  const AsimovProgressChange(this.asimov);

  final int asimov;

  @override
  List<Object?> get props => [asimov];
}

class RisaProgressChange extends ProgressStateEvent {
  const RisaProgressChange(this.risa);

  final int risa;

  @override
  List<Object?> get props => [risa];
}

class MoonProgressChange extends ProgressStateEvent {
  const MoonProgressChange(this.moon);

  final int moon;

  @override
  List<Object?> get props => [moon];
}

class WrongProgressChange extends ProgressStateEvent {
  const WrongProgressChange(this.wrong);

  final int wrong;

  @override
  List<Object?> get props => [wrong];
}

class NeighbourStateChange extends ProgressStateEvent {
  const NeighbourStateChange(this.neighbourState);

  final String neighbourState;

  @override
  List<Object?> get props => [neighbourState];
}