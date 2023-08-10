
List<List<String>> convertListOfLists(List<List<dynamic>> input) {
  List<List<String>> output = [];

  for (List<dynamic> innerList in input) {
    List<String> convertedInnerList = [];
    for (dynamic value in innerList) {
      convertedInnerList.add(value.toString());
    }
    output.add(convertedInnerList);
  }

  return output;
}