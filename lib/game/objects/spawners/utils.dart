List<int> generateRandomSpawnerList(int spawnerCount, int numToPick) {
  List<int> list = List<int>.generate(spawnerCount, (i) => i + 1);
  list.shuffle();
  return list.take(numToPick).toList();
}