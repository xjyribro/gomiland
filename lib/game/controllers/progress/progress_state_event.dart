part of 'progress_state_bloc.dart';

abstract class ProgressStateEvent extends Equatable {
  const ProgressStateEvent();
}

class SetHasSave extends ProgressStateEvent {
  const SetHasSave(this.hasSave);

  final bool hasSave;

  @override
  List<Object?> get props => [hasSave];
}

class SetPlasticProgress extends ProgressStateEvent {
  const SetPlasticProgress(this.plastic);

  final int plastic;

  @override
  List<Object?> get props => [plastic];
}

class SetPaperProgress extends ProgressStateEvent {
  const SetPaperProgress(this.paper);

  final int paper;

  @override
  List<Object?> get props => [paper];
}

class SetMetalProgress extends ProgressStateEvent {
  const SetMetalProgress(this.metal);

  final int metal;

  @override
  List<Object?> get props => [metal];
}

class SetElectronicsProgress extends ProgressStateEvent {
  const SetElectronicsProgress(this.electronics);

  final int electronics;

  @override
  List<Object?> get props => [electronics];
}

class SetGlassProgress extends ProgressStateEvent {
  const SetGlassProgress(this.glass);

  final int glass;

  @override
  List<Object?> get props => [glass];
}

class SetFoodProgress extends ProgressStateEvent {
  const SetFoodProgress(this.food);

  final int food;

  @override
  List<Object?> get props => [food];
}

class SetQianBiProgress extends ProgressStateEvent {
  const SetQianBiProgress(this.qianBi);

  final int qianBi;

  @override
  List<Object?> get props => [qianBi];
}

class SetManukaProgress extends ProgressStateEvent {
  const SetManukaProgress(this.manuka);

  final int manuka;

  @override
  List<Object?> get props => [manuka];
}

class SetStarkProgress extends ProgressStateEvent {
  const SetStarkProgress(this.stark);

  final int stark;

  @override
  List<Object?> get props => [stark];
}

class SetAsimovProgress extends ProgressStateEvent {
  const SetAsimovProgress(this.asimov);

  final int asimov;

  @override
  List<Object?> get props => [asimov];
}

class SetRisaProgress extends ProgressStateEvent {
  const SetRisaProgress(this.risa);

  final int risa;

  @override
  List<Object?> get props => [risa];
}

class SetMoonProgress extends ProgressStateEvent {
  const SetMoonProgress(this.moon);

  final int moon;

  @override
  List<Object?> get props => [moon];
}

class SetWrongProgress extends ProgressStateEvent {
  const SetWrongProgress(this.wrong);

  final int wrong;

  @override
  List<Object?> get props => [wrong];
}

class SetNeighbourState extends ProgressStateEvent {
  const SetNeighbourState(this.neighbour);

  final String neighbour;

  @override
  List<Object?> get props => [neighbour];
}

class SetProgressState extends ProgressStateEvent {
  const SetProgressState(
    this.hasSave,
    this.neighbour,
    this.plastic,
    this.paper,
    this.metal,
    this.electronics,
    this.glass,
    this.food,
    this.wrong,
    this.manuka,
    this.qianBi,
    this.risa,
    this.stark,
    this.asimov,
    this.moon,
  );

  final bool hasSave;
  final String neighbour;
  final int plastic;
  final int paper;
  final int metal;
  final int electronics;
  final int glass;
  final int food;
  final int wrong;
  final int manuka;
  final int qianBi;
  final int risa;
  final int stark;
  final int asimov;
  final int moon;

  @override
  List<Object?> get props => [
        hasSave,
        neighbour,
        plastic,
        paper,
        metal,
        electronics,
        glass,
        food,
        wrong,
        manuka,
        qianBi,
        risa,
        stark,
        asimov,
        moon,
      ];
}
