import 'package:psychology_mobile/models/saved_result_model.dart';
import 'package:psychology_mobile/services/db_service.dart';

class ResultService {

  static List<SavedResultModel> fetchAllResults() {
    final data = DbService.getLocalStringList(DbEnum.results) ?? [];
    if(data.isNotEmpty) {
      return data.map<SavedResultModel>((e) => savedResultModelFromJson(e)).toList();
    }

    return [];
  }

  static Future<void> setAllResults(List<SavedResultModel> results) async {
    final data = results.map<String>((e) => savedResultModelToJson(e)).toList();
    await DbService.setLocalStringList(DbEnum.results, data);
  }
}