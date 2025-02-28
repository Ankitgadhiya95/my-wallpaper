import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wallpaper/wallpaperdedetailscreen.dart';
import 'package:wallpaper/wallpaperscreen.dart';
import 'categorymodal.dart';

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  bool isLoading = false;
  String _selectedValue = '1';

  String reason = '';
  //final CarouselController _controller = CarouselController();

  void onPageChange(int index, CarouselPageChangedReason changeReason) {
    setState(() {
      reason = changeReason.toString();
    });
  }

  /*@override
  void initState() {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    Skyapi().loadPostData().then((value) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }*/

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 330;
    return Scaffold(
        backgroundColor: Color.fromRGBO(20, 33, 61, 1),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Color(0XFFE0D7D7FF)),
          centerTitle: true,
          backgroundColor: Color.fromRGBO(20, 33, 61, 1),
          title: Text(
            "Wallpaper",
            style: TextStyle(
                color: Colors.yellowAccent, fontWeight: FontWeight.w600),
          ),
          actions: [
            PopupMenuButton<String>(
              color: Color.fromRGBO(40, 62, 101, 1),
              icon: Icon(
                Icons.settings,
                color: Color(0XFFE0D7D7FF),
              ),
              /*onSelected: (String value) {
                setState(() {
                  _selectedValue = value;
                });
              },*/
              itemBuilder: (BuildContext context) => [
                PopupMenuItem(
                  value: '1',
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.star_border_outlined,
                          color: Color(0XFFE0D7D7FF)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Rate US',
                          style: TextStyle(color: Color(0XFFE0D7D7FF))),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: '2',
                  child: Row(
                    children: [
                      Icon(Icons.share, color: Color(0XFFE0D7D7FF)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Share App',
                          style: TextStyle(color: Color(0XFFE0D7D7FF))),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: '3',
                  onTap: () => _launchURL(
                      "https://nilkanthnest.blogspot.com/2024/07/wallpaper.html"),
                  child: Row(
                    children: [
                      Icon(Icons.policy_outlined, color: Color(0XFFE0D7D7FF)),
                      SizedBox(
                        width: 10,
                      ),
                      Text('Privacy Policy',
                          style: TextStyle(color: Color(0XFFE0D7D7FF))),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
        body: Center(
            child: isLoading == true
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider.builder(
                          itemCount: categoryList.length,
                          options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 2.0,
                            enlargeCenterPage: true,
                          ),
                          itemBuilder: (context, index, realIdx) {
                            return InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => WallpaperDetailScreen(
                                          wall: categoryList[index].bg!,
                                        )));
                              },
                              child: Container(
                                child: Center(
                                    child: Image.network(
                                        categoryList[index].bg!,
                                        fit: BoxFit.cover,
                                        width: 1000)),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        height: screenHeight,
                        child: GridView.builder(
                          itemCount: categoryList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => WallpaperScreen(
                                            imgName: categoryList[index].tital!,
                                          )));
                                },
                                child: Container(
                                  height: double.infinity,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.withOpacity(0.1),
                                    image: DecorationImage(
                                        colorFilter: ColorFilter.mode(
                                            Colors.transparent,
                                            BlendMode.multiply),
                                        image: NetworkImage(
                                          categoryList[index].bg!,
                                        ),
                                        fit: BoxFit.cover),
                                  ),
                                  child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 0.5, sigmaY: 0.5),
                                      child: Container(
                                          // decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),,),
                                          alignment: Alignment.center,
                                          child: Text(
                                              categoryList[index].tital!,
                                              style: TextStyle(
                                                  fontSize: 28,
                                                  color:
                                                      Colors.deepOrangeAccent,
                                                  fontWeight: FontWeight.bold)))

                                      // ,
                                      ),
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            // mainAxisSpacing: 10,

                            childAspectRatio: 3 / 4,
                            //    crossAxisSpacing: 10
                          ),
                        ),
                      ),
                    ],
                  )));
  }
}

void _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
