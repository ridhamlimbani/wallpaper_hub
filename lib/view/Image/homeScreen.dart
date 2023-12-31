import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/Model/categoeries_Model.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/data/data.dart';
import 'package:wallpaper_hub1/provider_helper/categorieProvider.dart';
import 'package:wallpaper_hub1/provider_helper/home_provider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/images.dart';
import 'package:wallpaper_hub1/view/Image/categories.dart';
import 'package:wallpaper_hub1/view/Image/search.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController = TextEditingController();
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpaperList = [];
  var homeGetData;
  bool isFabVisible = true;

  loadData() {
    homeGetData = Provider.of<HomeProvider>(context, listen: false);
    homeGetData.getCategoriesWallpapers();
  }

  @override
  void initState() {
    // TODO: implement initState
    categories = getCateries();
    loadData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      color: AppColor.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: AppColor.white,
            title: brandName(),
            centerTitle: true,
            elevation: 0.0,
            actions: [
              IconButton(onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchScreen()));
              }, icon: const Icon(Icons.search,color: AppColor.mainColor,)),
              /*Consumer<HomeProvider>(
                builder: (context,homeProvider,child){
                  return PopupMenuButton<int>(
                    icon: const Icon(Icons.more_vert,color: AppColor.mainColor),
                    onSelected: (item) => homeProvider.handleClick(item, context),
                    itemBuilder: (context) => [
                      PopupMenuItem<int>(value: 0, child: Row(
                        children: const[
                          Icon(Icons.photo,color: AppColor.mainColor,),
                          SizedBox(width: 10,),
                          Text('Photos',style: TextStyle(color: AppColor.mainColor,fontWeight: FontWeight.bold),),
                        ],
                      )),
                      PopupMenuItem<int>(value: 1, child: Row(
                        children: const[
                          Icon(Icons.slow_motion_video,color: AppColor.mainColor,),
                          SizedBox(width: 10,),
                          Text('Video',style: TextStyle(color: AppColor.mainColor,fontWeight: FontWeight.bold),),
                        ],
                      )),
                    ],
                  );
                },
              ),*/
            ],

          ),
          body:  Consumer<HomeProvider>(
            builder: (context,home,child){
              return Column(
                children: [
                  SizedBox(
                    height: 65,
                    child: ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        itemCount: categories.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return CategoriesTile(
                              imgUrl: categories[index].categoriesImageURL,
                              title: categories[index].categoriesName);
                        }),
                  ),
                  Expanded(
                    child: NotificationListener<UserScrollNotification>(
                      onNotification: (scrollInfo) {
                        if(scrollInfo.direction == ScrollDirection.forward){
                          home.setVisible(true);
                        }
                        else if(scrollInfo.direction==ScrollDirection.reverse){
                          home.setVisible(false);
                        }

                        if (!home.isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          home.loadData(context);
                          home.setIsLoading(true);
                        }

                        return true;
                      },
                      child: wallpapersList(home.wallpaperList, context,home.scrollController),
                    ),
                  ),
                  Visibility(
                    visible: home.isLoading,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height  * 0.05,
                        child: Lottie.asset(AppLottie.loading,height: MediaQuery.of(context).size.height  * 0.05,width: 100),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          floatingActionButton: Consumer<HomeProvider>(
            builder: (context,home,child){
              return Visibility(
                visible: home.isFabVisible,
                child: FloatingActionButton(
                  backgroundColor: AppColor.mainColor,
                  onPressed: home.scrollUp,
                  child: const Icon(Icons.arrow_upward,color: AppColor.white,),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  String imgUrl, title;

  CategoriesTile({Key? key, required this.imgUrl, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: Consumer<CategoriesProvider>(
        builder: (context, categories, child) {
          return InkWell(
            onTap: () {
              categories.getCategoriesWallpapers(title);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CategoriesScreen(
                            categoriesTitle: title,
                          )));
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imgUrl,
                    height: 50,
                    width: 100,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColor.black26,
                      borderRadius: BorderRadius.circular(16)),
                  height: 50,
                  width: 100,
                  alignment: Alignment.center,
                  child: Text(
                    title,
                    style: const TextStyle(
                        color: AppColor.white,
                        fontFamily: "Fontmirror",
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
