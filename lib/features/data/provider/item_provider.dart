import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../domain/models/item_model.dart';

class ItemProvider extends ChangeNotifier {
  final List<ItemModel> _items = [];

  List<ItemModel> get items => List.unmodifiable(_items);

  final Box _box = Hive.box('tasksBox');
  final _uuid = const Uuid();

  Future<void> loadItems() async {
    final saved = _box.get('items', defaultValue: []);
    try {
      _items
        ..clear()
        ..addAll(List<Map>.from(saved).map((m) => ItemModel.fromMap(m)));
    } catch (_) {
      _items.clear();
    }
    notifyListeners();
  }

  Future<void> saveItems() async {
    await _box.put('items', _items.map((e) => e.toMap()).toList());
  }

  Future<void> addItem({required String title, String? notes}) async {
    final item = ItemModel(
      id: _uuid.v4(),
      title: title,
      notes: notes,
      createdAt: DateTime.now(),
    );
    _items.insert(0, item);
    await saveItems();
    notifyListeners();
  }

  Future<void> updateItem({
    required String id,
    required String title,
    String? notes,
  }) async {
    final idx = _items.indexWhere((i) => i.id == id);
    if (idx == -1) return;
    _items[idx] = ItemModel(
      id: id,
      title: title,
      notes: notes,
      createdAt: _items[idx].createdAt,
    );
    await saveItems();
    notifyListeners();
  }

  Future<void> deleteItem(String id) async {
    _items.removeWhere((i) => i.id == id);
    await saveItems();
    notifyListeners();
  }

  ItemModel? getById(String id) {
    try {
      return _items.firstWhere((i) => i.id == id);
    } catch (e) {
      return null;
    }
  }
}
