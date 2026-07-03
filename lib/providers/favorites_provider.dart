import 'package:flutter/material.dart';
import 'package:food_app/models/item_model.dart';
import 'package:food_app/helpers/db_helper.dart';

class FavoritesProvider with ChangeNotifier {
  List<Item> _favoriteItems = [];

  List<Item> get favoriteItems => [..._favoriteItems];

  // Load favorites from SQL specifically for the logged-in user
  Future<void> fetchFavorites(String userId) async {
    final dataList = await DBHelper.getData('favorites', where: 'userId = ?', whereArgs: [userId]);
    _favoriteItems = dataList.map((item) => Item(
      id: item['id'],
      title: item['title'],
      price: item['price'],
      imageUrl: item['imageUrl'],
      category: '', // Placeholder
      description: '', // Placeholder
    )).toList();
    notifyListeners();
  }

  // Clear favorites from memory (called on logout)
  void clearFavorites() {
    _favoriteItems = [];
    notifyListeners();
  }

  bool isFavorite(Item item) {
    return _favoriteItems.any((fav) => fav.id == item.id);
  }

  Future<void> toggleFavorite(Item item, String userId) async {
    final isFav = isFavorite(item);
    if (isFav) {
      // Remove from DB specifically for this user
      await DBHelper.delete('favorites', where: 'id = ? AND userId = ?', whereArgs: [item.id, userId]);
      _favoriteItems.removeWhere((fav) => fav.id == item.id);
    } else {
      // Insert into DB with userId
      await DBHelper.insert('favorites', {
        'id': item.id,
        'userId': userId,
        'title': item.title,
        'price': item.price,
        'imageUrl': item.imageUrl,
      });
      _favoriteItems.add(item);
    }
    notifyListeners();
  }
}
