import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';
import 'package:whereisit/data/dao/item_dao.dart';
import 'package:whereisit/data/database.dart';
import 'package:whereisit/models/item.model.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ItemDao Tests', () {
    late Database db;
    late ItemDao itemDao;
    late DateTime now;

    String user = 'system';

    // Set up the database before running each test.
    setUp(() async {
      now = DateTime.now();
      db = await openDatabase(
        inMemoryDatabasePath,
        onCreate: (db, version) async {
          // Create necessary tables if needed
          await db.execute(DatabaseProvider.createUsersTable);
          await db.execute(DatabaseProvider.createLocationsTable);
          await db.execute(DatabaseProvider.createCategoriesTable);
          await db.execute(DatabaseProvider.createPropertiesTable);
          await db.execute(DatabaseProvider.createRoomsTable);
          await db.execute(DatabaseProvider.createItemsTable);

          await db.execute('''
            INSERT INTO users (
              name,
              username,
              created_by,
              created_at,
              updated_by,
              updated_at
            ) VALUES (
              'System',
              $user,
              $user,
              $now,
              $user,
              $now
            )
          ''');

          await db.execute('''
            INSERT INTO categories (
              name,
              created_by,
              created_at,
              updated_by,
              updated_at
              ) VALUES (
              'Uncategorized',
              $user,
              $now,
              $user,
              $now
            )
          ''');
        },
      );
      itemDao = ItemDao();
    });

    // Close the database after each test.
    tearDown(() async {
      await db.close();
    });

    test('Insert Item', () async {
      final item = Item(
        name: 'Test Item',
        thumbnail: 'thumbnail.jpg',
        quantity: 5,
        favorite: true,
        createdAt: now,
        updatedAt: now,
        createdBy: user,
        updatedBy: user,
      );
      final itemId = await itemDao.insert(item);

      expect(itemId, 1); // Assuming that this is the first item inserted.
    });

    test('Find Item By ID', () async {
      final item = Item(
        name: 'Test Item',
        thumbnail: 'thumbnail.jpg',
        quantity: 5,
        favorite: true,
        createdAt: now,
        updatedAt: now,
        createdBy: user,
        updatedBy: user,
      );
      final itemId = await itemDao.insert(item);

      final foundItem = await itemDao.findById(itemId);
      expect(foundItem.id, itemId);
      expect(foundItem.name, 'Test Item');
    });

    test('Find Items By Tag', () async {
      // Test the findItemsByTag method here with appropriate test data.
    });

    test('Find Items With Location, Property, Room, and Category', () async {
      // Test the findItemsWithLocationPropertyRoomCategory method here with appropriate test data.
    });

    test('Find All Items', () async {
      // Test the findAll method here with appropriate test data.
    });

    test('Update Item', () async {
      final item = Item(
        name: 'Test Item',
        thumbnail: 'thumbnail.jpg',
        quantity: 5,
        favorite: true,
        createdAt: now,
        updatedAt: now,
        createdBy: user,
        updatedBy: user,
      );
      final itemId = await itemDao.insert(item);

      final updatedItem = item.copyWith(name: 'Updated Item');
      final rowsAffected = await itemDao.update(updatedItem);

      expect(rowsAffected, 1);
      final foundItem = await itemDao.findById(itemId);
      expect(foundItem.name, 'Updated Item');
    });

    test('Delete Item', () async {
      final item = Item(
        name: 'Test Item',
        thumbnail: 'thumbnail.jpg',
        quantity: 5,
        favorite: true,
        createdAt: now,
        updatedAt: now,
        createdBy: user,
        updatedBy: user,
      );
      final itemId = await itemDao.insert(item);

      final rowsAffected = await itemDao.delete(itemId);
      expect(rowsAffected, 1);

      final deletedItem = await itemDao.findById(itemId);
      expect(deletedItem, null);
    });
  });
}
