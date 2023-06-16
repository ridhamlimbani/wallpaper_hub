import 'package:wallpaper_hub1/Model/categoeries_Model.dart';

List<CategoriesModel> getCateries(){
  List<CategoriesModel> categories=[];
  CategoriesModel categoriesModel=new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/162379/lost-places-pforphoto-leave-factory-162379.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Street Art";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();


  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/63325/grizzly-bears-playing-sparring-63325.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Wild Life";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/1402787/pexels-photo-1402787.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Car";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/819805/pexels-photo-819805.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Bikes";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/2618804/pexels-photo-2618804.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Nature";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/5910511/pexels-photo-5910511.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Gods";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/2740956/pexels-photo-2740956.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="Motivation";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();

  categoriesModel.categoriesImageURL="https://images.pexels.com/photos/2097616/pexels-photo-2097616.jpeg?auto=compress&cs=tinysrgb&w=600";
  categoriesModel.categoriesName="City";
  categories.add(categoriesModel);
  categoriesModel = new CategoriesModel();




  return categories;
}