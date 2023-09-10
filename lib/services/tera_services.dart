import '../model/tera.dart';

class Calculation {
  static double convertToLiter(String depth, List<Tera> TeraTable) {
    double resultLiter = 0;
    List<String> col1 = [];
    List<String> col2 = [];
    double sonding = 0;
    String sondingX1 = "", sondingX2 = "";
    int index = 0;
    int x1 = 0;
    int x2 = 0;
    double y = 0, y1 = 0, y2 = 0;

    if (depth == "") {
      return 0;
    } else {
      sonding = double.parse(depth);
      if (sonding % 1 == 0) {
        x1 = sonding.floor();
        x2 = sonding.ceil();
        sondingX1 = x1.toString();
        sondingX2 = x2.toString();

        for (int i = 0; i < TeraTable.length; i++) {
          col1.add(TeraTable[i].depth);
          col2.add(TeraTable[i].qty);
        }
        index = col1.indexWhere((element) => element == sondingX1);
        y1 = double.parse(col2[index]);
        resultLiter = y1;
      } else {
        x1 = sonding.floor();
        x2 = sonding.ceil();
        sondingX1 = x1.toString();
        sondingX2 = x2.toString();

        for (int i = 0; i < TeraTable.length; i++) {
          col1.add(TeraTable[i].depth);
          col2.add(TeraTable[i].qty);
        }

        index = col1.indexWhere((element) => element == sondingX1);
        y1 = double.parse(col2[index]);
        index = col1.indexWhere((element) => element == sondingX2);
        y2 = double.parse(col2[index]);

        y = y1 + (sonding - x1) * ((y2 - y1) / (x2 - x1));
        resultLiter = y;
      }
    }

    //<><><><><><><><><><><><><><><><><><>
    return resultLiter;
  }
}
