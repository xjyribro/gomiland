// ignore_for_file: file_names

part of 'progress_state_bloc.dart';

class ProgressState extends Equatable {
  final bool hasSave;
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
  final String neighbour;

  const ProgressState({
    required this.hasSave,
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
    required this.neighbour,
  });

  const ProgressState.empty()
      : this(
          hasSave: false,
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
          neighbour: 'intro',
        );

  ProgressState copyWith({
    bool? hasSave,
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
    String? neighbour,
  }) {
    return ProgressState(
      hasSave: hasSave ?? this.hasSave,
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
      neighbour: neighbour ?? this.neighbour,
    );
  }

  void resetProgress(BuildContext context) {
    context.read<ProgressStateBloc>().add(SetProgressState(
        hasSave, 'intro', 0, 0, 0, 0, 0, 0, 0, -1, -1, -1, -1, -1, -1));
  }

  void setProgress({
    required BuildContext context,
    required bool hasSave,
    required String neighbour,
    required int plastic,
    required int paper,
    required int metal,
    required int electronics,
    required int glass,
    required int food,
    required int wrong,
    required int manuka,
    required int qianBi,
    required int risa,
    required int stark,
    required int asimov,
    required int moon,
  }) {
    context.read<ProgressStateBloc>().add(
          SetProgressState(
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
          ),
        );
  }

  @override
  List<Object?> get props => [
        hasSave,
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
        neighbour,
      ];
}
