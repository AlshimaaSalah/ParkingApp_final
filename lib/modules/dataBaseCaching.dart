// ignore_for_file: file_names

import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:api_cache_manager/utils/cache_manager.dart';

final DataBaseCaching baseCaching = DataBaseCaching();

class DataBaseCaching {
  final String _cacheKey = 'cache';
  final APICacheManager _apiCacheManager = APICacheManager();
  late APICacheDBModel _apiCacheDBModel;

  addDataCache(String key, var data) async {
    _apiCacheDBModel =
        APICacheDBModel(key: "${_cacheKey}_$key", syncData: data.toString());
    await _apiCacheManager.addCacheData(_apiCacheDBModel);
  }

  Future<APICacheDBModel> getDataCache(String key) async {
    return await _apiCacheManager.getCacheData("${_cacheKey}_$key");
  }

  Future<bool> isDataCacheExist(String key) async {
    return await _apiCacheManager.isAPICacheKeyExist("${_cacheKey}_$key");
  }

  clearDataCache(String key) async {
    return await _apiCacheManager.deleteCache("${_cacheKey}_$key");
  }

  clearAllDataCache() async {
    return await _apiCacheManager.emptyCache();
  }
}
