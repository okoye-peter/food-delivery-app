import 'package:yummy/data/dummy_data/data.dart';
import 'package:yummy/data/models/category_model.dart';

class CategoryRepository {
  // TODO: fetch from the API and parse with CategoryModel.fromJson
  List<CategoryModel> getCategories() => foodCategories;
}
