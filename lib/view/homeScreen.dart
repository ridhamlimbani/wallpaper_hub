import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_hub1/Model/categoeries_Model.dart';
import 'package:wallpaper_hub1/Model/wallpaper_Model.dart';
import 'package:wallpaper_hub1/data/data.dart';
import 'package:wallpaper_hub1/provider_helper/categorieProvider.dart';
import 'package:wallpaper_hub1/provider_helper/search_provider.dart';
import 'package:wallpaper_hub1/utils/colors.dart';
import 'package:wallpaper_hub1/utils/string.dart';
import 'package:wallpaper_hub1/view/categories.dart';
import 'package:wallpaper_hub1/view/search.dart';
import 'package:wallpaper_hub1/widgets/widget.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController searchController=TextEditingController();
  List<CategoriesModel> categories=[];
  List<WallpaperModel> wallpaperList = [];

  int _page=1;
  final int _limit=20;
  bool _isFirstLoadRunning=false;
  bool _isLoadMoreRunning=false;
  bool _hasNextPage=true;

  void _loadMore() async{
    if(_hasNextPage == true && _isFirstLoadRunning ==false && _isLoadMoreRunning==false){
      setState(() {
        _isLoadMoreRunning = true;
      });

      _page +=1;

      try{
        var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=$_limit&page=$_page"),
            headers: {
              "Authorization":AppString.apikey,
            });

        print("Data :- ${response.body.toString()}");

        Map<String,dynamic> jsonData=jsonDecode(response.body);
        jsonData["photos"].forEach((element){

          WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
          wallpaperList.add(wallpaperModel);

          setState(() {});
        });

      }catch(error){
        if(kDebugMode){
          print("Something went wrong");
        }
      }


      setState(() {
        _isLoadMoreRunning=false;
      });

    }
  }

  void _firstLoad()async{
    setState(() {
      _isFirstLoadRunning = true;
    });

    try{
      var response = await http.get(Uri.parse("https://api.pexels.com/v1/curated?per_page=$_limit&page=$_page"),
          headers: {
            "Authorization":AppString.apikey,
          });

      print("Data :- ${response.body.toString()}");

      Map<String,dynamic> jsonData=jsonDecode(response.body);
      jsonData["photos"].forEach((element){

        WallpaperModel wallpaperModel = WallpaperModel.fromJson(element);
        wallpaperList.add(wallpaperModel);

        setState(() {});
      });
    }catch(error){
      if(kDebugMode){
        print("Something went wrong");
      }
    }

    setState(() {
      _isFirstLoadRunning=false;
    });
  }

  late ScrollController _controller;

  @override
  void initState() {
    // TODO: implement initState
    categories=getCateries();
    _firstLoad();
    _controller = ScrollController()..addListener(_loadMore);
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
            backgroundColor: Theme.of(context).primaryColor,
            elevation: 0.0,
            centerTitle: true,
            title: brandName(),
          ),
          body: _isFirstLoadRunning?
          const Center(
            child: CircularProgressIndicator(),
          ) :
          SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: Consumer<SearchProvider>(
                    builder: (context,search,child){
                      return SizedBox(
                        height: 45,
                        child: TextField(
                          enableSuggestions: true,
                          autocorrect: true,
                          onSubmitted: (String searchString){
                            search.getSearchWallpapers(searchString);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen(searchTitle: searchString)));
                          },
                          cursorColor: AppColor.mainColor,
                          style: const TextStyle(fontFamily: "Fontmirror",color: AppColor.mainColor,decorationThickness: 0),
                          controller: search.searchController,
                          decoration: InputDecoration(
                              hintText: "Search Categories",
                              hintStyle: const TextStyle(fontFamily: "Fontmirror",color: AppColor.mainColor),
                              contentPadding: const EdgeInsets.only(left: 20),
                              suffixIcon: const Icon(Icons.search,color: AppColor.mainColor,),
                              filled: true,
                              fillColor: AppColor.mainColor.withOpacity(0.1),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const  BorderSide(
                                      color: AppColor.mainColor
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: const  BorderSide(
                                      color: AppColor.mainColor
                                  )
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide.none,
                              )
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 80,
                  child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      itemCount: categories.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return CategoriesTile(imgUrl: categories[index].categoriesImageURL, title: categories[index].categoriesName);
                      }),
                ),
                const SizedBox(
                  height: 15,
                ),
                wallpapersList(wallpaperList, context,_controller),
                if(_isLoadMoreRunning == true)
                  const Padding(padding: EdgeInsets.only(top: 10,bottom: 40),child: Center(child: CircularProgressIndicator(),),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {

  String imgUrl,title;
  CategoriesTile({Key? key,required this.imgUrl,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 4),
      child: Consumer<CategoriesProvider>(
        builder: (context,categories,child){
          return InkWell(
            onTap: (){
              categories.firstLoad(title);
              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoriesScreen(categoriesTitle: title,)));
            },
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(imgUrl,height: 50,width: 100,fit: BoxFit.fill,),
                ),
                Container(
                  decoration: BoxDecoration(color: AppColor.black26,borderRadius: BorderRadius.circular(16)),
                  height: 50,width: 100,
                  alignment: Alignment.center,
                  child:Text(title,style: const TextStyle(color: AppColor.white,fontFamily: "Fontmirror",fontWeight: FontWeight.bold),) ,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

