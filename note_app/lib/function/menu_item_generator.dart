class MenuItemGenerator {
  List<int> menuGenerator(id) {
    List<int> list = [];
    if (id == 0) {
      list = [
        0,
        0,
        0,
      ];
    } else if (id == 1) {
      list = [
        1,
        1,
        1,
      ];
    } else if (id == 2) {
      list = [
        2,
        2,
        2,
      ];
    } else if (id == 3) {
      list = [
        0,
        1,
        2,
      ];
    }
    return list;
  }
}
