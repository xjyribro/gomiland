// ignore_for_file: file_names

part of 'progress_state_bloc.dart';

class ProgressState extends Equatable {
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
  final String neighbourState;

  const ProgressState({
    required this.plastic,
    required this.paper,
    required this.metal,
    required this.electronics,
    required this.glass,
    required this.food,
    required this.wrong,
    required this.manuka,
    required this.qianBi,
    required this.risa,
    required this.stark,
    required this.asimov,
    required this.moon,
    required this.neighbourState,
  });

  const ProgressState.empty()
      : this(
          plastic: 0,
          paper: 0,
          metal: 0,
          electronics: 0,
          glass: 0,
          food: 0,
          wrong: 0,
          manuka: -1,
          qianBi: -1,
          risa: -1,
          stark: -1,
          asimov: -1,
          moon: -1,
          neighbourState: 'intro',
        );

  ProgressState copyWith({
    int? plastic,
    int? paper,
    int? metal,
    int? electronics,
    int? glass,
    int? food,
    int? wrong,
    int? manuka,
    int? qianBi,
    int? risa,
    int? stark,
    int? asimov,
    int? moon,
    String? neighbourState,
  }) {
    return ProgressState(
      plastic: plastic ?? this.plastic,
      paper: paper ?? this.paper,
      metal: metal ?? this.metal,
      electronics: electronics ?? this.electronics,
      glass: glass ?? this.glass,
      food: food ?? this.food,
      wrong: wrong ?? this.wrong,
      manuka: manuka ?? this.manuka,
      qianBi: qianBi ?? this.qianBi,
      risa: risa ?? this.risa,
      stark: stark ?? this.stark,
      asimov: asimov ?? this.asimov,
      moon: moon ?? this.moon,
      neighbourState: neighbourState ?? this.neighbourState,
    );
  }

  @override
  List<Object?> get props => [
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
